//
//  EditReportView.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-03-28.
//

import SwiftUI

struct EditReportView: View {
    
    //    @EnvironmentObject var symptomViewModel : SymptomViewModel
    @EnvironmentObject var generalViewModel : GeneralViewModel
    
    @Binding var loggedIn: Bool
    @State var dateString: String
    
    
    let steps :[(Int, String)] = [(1,"Symptoms"), (2,"Events"), (3, "Description of Today"), (4, "Questions and Notes"), (5, "Selected Emoji")]
    
    
    //    @Binding var path: NavigationPath
    
    var body: some View {
        NavigationStack{
            VStack(alignment: .leading){
                Text("Edit Report")
                    .foregroundColor(Color(.black))
                    .font(.editReportNavBarTitle)
                Divider()
                
                Text("""
                        Select any step of the process to make  changes as required.
                        """)
                .font(.titleinRowItem)
                .foregroundColor(Color(.black))
                //                .padding(.vertical, 5)
                
                Text("""
                        This report was last edited on \(datetoFormalDateString(date: generalViewModel.selectedReport.lastModifiedDateTime)).
                        
                        """)
                .font(.regularText)
                .foregroundColor(Color(.black))
                .padding(.top, 12)
//                .padding(.bottom, 24)
                
                if(generalViewModel.selectedReport.id != nil){
                    ScrollView{
                        ForEach(steps, id: \.0) { item in
                            StepofReportRow(report: generalViewModel.selectedReport, loggedIn: $loggedIn, stepNumber: item.0, stepName: item.1,  dateString: dateString)
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
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

    #Preview {
//        EditReportView(loggedIn: Binding.constant(true), dateString: Date.now.datetoString()!)
//            .environmentObject(GeneralViewModel())
    }
