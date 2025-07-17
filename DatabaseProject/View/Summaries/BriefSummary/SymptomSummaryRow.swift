//
//  SymptomSummaryRow.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-05-05.
//

import SwiftUI

struct SymptomSummaryRow: View {
    var symptomName: String
    var symptomReports: [SymptomReport]

    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(Color(.greyNonClickable)) // this is the actual fill

            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.outlineGrey), lineWidth: 1)
            
            HStack (alignment: .center){
                Text(symptomName)
                    .font(.largeTitleinListinSummariesandMorePage)
                    .foregroundColor(Color(.offBlackText))
                
                if(symptomReports.count>0){
                    Spacer()
                    
                    Text("Trended worse beginning of the week, then trended better ")
                        .background(Color(.secondary2))
                        .font(.smallTitle)
                        .foregroundColor(Color(.white))
                        .multilineTextAlignment(.leading)
                        .cornerRadius(6)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .frame(minHeight: 20)
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
    }
}

#Preview {
    SymptomSummaryRow(symptomName: "", symptomReports: [])
}
