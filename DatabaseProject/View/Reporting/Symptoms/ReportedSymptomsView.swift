//
//  ReportedSymptomsContentPage.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-10-05.
//

import SwiftUI

struct ReportedSymptomsView: View {
//    @State var reportedItems:[Symptom] = [
//        Symptom(symptomName: "Nausea", rating: 6, recentStatus: "New")
//        ,
//        Symptom(symptomName: "Nausea", rating: 6, recentStatus: "New"),
//        Symptom(symptomName: "Nausea", rating: 6, recentStatus: "New")
//
//    ]
    @EnvironmentObject var symptomViewModel : SymptomViewModel

    @Binding var loggedIn: Bool
    @State var dateString: String
//    @State var data: [SymptomReport]
    


//    @Binding var path: NavigationPath

    var body: some View {
        VStack(alignment: .leading){
            Text("""
                Reported Symptoms
                """)
            .font(.symptomTitleinReportingPage)
            .foregroundColor(Color(.black))
            .padding(.vertical, 6)
            
            if(symptomViewModel.reportedSymptomsofUserbyDate.count>0){
                Text("""
                These are symptoms you have added today
                """)
                .font(.regularText)
                .foregroundColor(Color(.blackMediumEmphasis))
                                
                ScrollView{
                    ForEach(symptomViewModel.reportedSymptomsofUserbyDate, id: \.self) { item in
                        ReportedSymptomListRow(item: item, loggedIn: $loggedIn, dateString: dateString)
                    }
                    .scrollContentBackground(.hidden)
                    .listStyle(.plain)
                    //            .frame(maxWidth: .infinity, maxHeight: 150)
                    
                }
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
//            .onAppear(){
//                if let reports = symptomViewModel.dictionaryofReports[dateString]
//                {
//                    data = symptomViewModel.dictionaryofReports[dateString]!
//                }
//                else {
//                    data = []
//                }
//            }
    }
    
}

#Preview {
    ReportedSymptomsView(loggedIn: Binding.constant(true), dateString: Date.now.datetoString()!)
        .environmentObject(SymptomViewModel())
}
