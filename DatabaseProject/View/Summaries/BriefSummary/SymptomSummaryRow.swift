//
//  SymptomSummaryRow.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-05-05.
//

import SwiftUI

struct SymptomSummaryRow: View {
    var symptomTrendModel: SymptomTrendModel

    var body: some View {
            if symptomTrendModel.symptomDataPoints.count > 0 {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .foregroundColor(Color(.greyNonClickable))
                    
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color(.outlineGrey), lineWidth: 1)
                    
                    HStack(alignment: .center) {
                        // Symptom Name
                        Text(symptomTrendModel.symptomName)
                            .font(.largeTitleinListinSummariesandMorePage)
                            .foregroundColor(Color(.offBlackText))
                        
                        Spacer()
                        
                        // Trend Description
                        Text(symptomTrendModel.completeTrendString)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color(.secondary2))
                            .font(.smallTitle)
                            .foregroundColor(Color(.white))
                            .multilineTextAlignment(.leading)
                            .cornerRadius(6)
                            .frame(minHeight: 20)
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 15)
                }
            }
        }
    }

#Preview {
    SymptomSummaryRow(symptomTrendModel: SymptomTrendModel(symptomName: "", symptomDataPoints: [], completeTrendString: "", trendStrength: .moderate)) 
}
