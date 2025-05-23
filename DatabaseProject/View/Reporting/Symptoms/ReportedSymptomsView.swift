//
//  ReportedSymptomsContentPage.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-10-05.
//

import SwiftUI

struct ReportedSymptomsView: View {

//    @EnvironmentObject var symptomViewModel : SymptomViewModel
    @EnvironmentObject var generalViewModel : GeneralViewModel

    @Binding var loggedIn: Bool
    @State var dateString: String
    
//    @Binding var path: NavigationPath

    var body: some View {
        VStack(alignment: .leading){
            Text("""
                Reported Symptoms
                """)
            .font(.symptomTitleinReportingPage)
            .foregroundColor(Color(.black))
            .padding(.vertical, 6)
            
            if(generalViewModel.selectedReport.symptomReports.count>0){
                Text("""
                These are symptoms you have added today.
                """)
                .font(.regularText)
                .foregroundColor(Color(.blackMediumEmphasis))
                                
//                ScrollView{
                    ForEach(generalViewModel.selectedReport.symptomReports, id: \.self) { item in
                        ReportedSymptomListRow(item: item, loggedIn: $loggedIn, dateString: dateString)
                    }
//                    .scrollContentBackground(.hidden)
//                    .listStyle(.plain)
//                }
            }
            else
            {
                Text("""
                You have not added any symptoms today.
                """)
                .font(.regularText)
                .foregroundColor(Color(.blackMediumEmphasis))
            }
        }
    }
    
}

#Preview {
    ReportedSymptomsView(loggedIn: Binding.constant(true), dateString: Date.now.datetoString()!)
        .environmentObject(GeneralViewModel())

}
