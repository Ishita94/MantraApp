//
//  StepofReportRow.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-03-28.
//

import SwiftUI

struct StepofReportRow: View {
    @EnvironmentObject var generalViewModel : GeneralViewModel

    @State var report: Report
    @Binding var loggedIn: Bool
    @State var readyToNavigate: Bool = false
    @State var stepNumber: Int = 1
    @State var stepName: String = "Symptoms"
    @State var dateString: String
    
    var body: some View {
        NavigationStack (){
            
            ZStack{
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.primary0))
                    .frame(maxWidth: .infinity, maxHeight: 81)
                HStack{
                    VStack(alignment: .leading){
                        Text("Step \(stepNumber)")
                            .foregroundColor(Color(.blackMediumEmphasis))
                            .font(.regularText)
                        Spacer()
                        Text(stepName)
                            .foregroundColor(Color(.primary0TTextOn0))
                            .font(.symptomTitleinReportedSymptomsPage)
                        
                        
                    }
                    Spacer()
                    Button(action: {
                        generalViewModel.setCurrentStateandTitle(state: stepNumber)
                        readyToNavigate=true
                    }) {
                        Image("ic-edit")
                    }
                }
                .padding()
                .navigationDestination(isPresented: $readyToNavigate) {
                    if(stepNumber==1)
                    {
                        AddorEditSymptomsLandingPage(loggedIn: $loggedIn, date: report.creationDateTime, dateString: report.dateString, createNewReport: false)
                    }
                    else if(stepNumber==2)
                    {
                        AddorEditEventsLandingPage(dateString: report.dateString, loggedIn: $loggedIn)
                    }
                    else if(stepNumber==3)
                    {
                        DescriptionLandingPage(dateString: report.dateString, loggedIn: $loggedIn)
                    }
                    else if(stepNumber==4)
                    {
                        QuestionsandNotesLandingPage(dateString: report.dateString, loggedIn: $loggedIn)
                    }
                    else if(stepNumber==5)
                    {
                        EmojiLandingPage(dateString: report.dateString, loggedIn: $loggedIn)
                    }
                }
//                .padding(.bottom, 8)
            }
        }
    }
}

#Preview {
    let generalViewModel = GeneralViewModel()
    let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
    let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
    let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected
    
    StepofReportRow(report: Report(), loggedIn: Binding.constant(true), stepNumber: 0, stepName: "", dateString: Date.now.datetoString()! ) .environmentObject(generalViewModel)
        .environmentObject(symptomViewModel)
        .environmentObject(eventsViewModel)
        .environmentObject(reportingViewModel)
}
