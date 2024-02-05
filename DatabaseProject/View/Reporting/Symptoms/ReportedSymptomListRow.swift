//
//  ReportedSymptomListRow.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-10-03.
//

import SwiftUI

struct ReportedSymptomListRow: View {
    var item: Symptom

    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.primary0))
                .frame(maxWidth: .infinity, maxHeight: 92)
            HStack{
                VStack(alignment: .leading){
                    HStack{
                        Text(item.symptomName)
                            .font(.symptomTitleinReportingPage)
                            .foregroundColor(Color(.offBlackText))
                        
                        Text(item.recentStatus)
                            //.padding()
                            .background(Color(.warning1))
                            .foregroundStyle(.white)
                            .font(.symptomSmallTitleinReportedSymptomsPage)
                            .cornerRadius(6)
                            .frame(maxHeight: 27)

                    }
                    Text("Severity Rating " + item.recentStatus + "/10")
                        //.padding()
                        .background(Color(.secondary2))
                        .foregroundStyle(Color(.white))
                        .font(.symptomSmallTitleinReportedSymptomsPage)
                        .cornerRadius(6)
                        .frame(maxHeight: 51)

                }.padding(.top, 10)
                Spacer()
                Image("ic-edit")

                
            }
            .padding()
            

        
    }
}

}

#Preview {
ReportedSymptomListRow(item: Symptom(symptomName: "N/A", rating: 0, recentStatus: "N/A"))
}



