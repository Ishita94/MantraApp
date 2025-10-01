//
//  OptionRow.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-09-24.
//


import SwiftUI

enum MoreMenuOption: String, CaseIterable {
    case allQuestionsAndNotes = "All Questions and Notes"
    case faqs = "Cancer Education (FAQs)"
    case reminders = "Reminders"
    case tutorials = "Tutorials"
    case settings = "Settings"
}

struct OptionRow: View {
    @EnvironmentObject var generalViewModel : GeneralViewModel
    
    @Binding var loggedIn: Bool
    @State var readyToNavigate: Bool = false
    @State var option: MoreMenuOption
    
    var body: some View {
        NavigationStack (){
            ZStack{
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.primary0))
                    .frame(maxWidth: .infinity, maxHeight: 81)
                HStack{
                    Text(option.rawValue)
                        .foregroundColor(Color(.primary0TTextOn0))
                        .font(.symptomTitleinReportedSymptomsPage)
                    
                    Spacer()
                    Button(action: {
                        readyToNavigate=true
                    }) {
                        Image("ic-play-blue")
                    }
                }
                .padding()
                .navigationDestination(isPresented: $readyToNavigate) {
                    switch option {
                    case .allQuestionsAndNotes:
                        QuestionsandNotesList()
                    case .faqs:
                        FAQsLandingPage()
                    case .reminders:
                        RemindersLandingPage()
                    case .tutorials:
                        QuestionsandNotesList()
                    case .settings:
                        FAQsLandingPage()
                    }
                   
                    //                    if(stepNumber==1)
                    //                    {
                    //                        AddorEditSymptomsLandingPage(loggedIn: $loggedIn, date: report.creationDateTime, dateString: report.dateString, createNewReport: false)
                    //                    }
                    //                    else if(stepNumber==2)
                    //                    {
                    //                        AddorEditEventsLandingPage(dateString: report.dateString, loggedIn: $loggedIn)
                    //                    }
                    //                    else if(stepNumber==3)
                    //                    {
                    //                        DescriptionLandingPage(dateString: report.dateString, loggedIn: $loggedIn)
                    //                    }
                    //                    else if(stepNumber==4)
                    //                    {
                    //                        QuestionsandNotesLandingPage(dateString: report.dateString, loggedIn: $loggedIn)
                    //                    }
                    //                    else if(stepNumber==5)
                    //                    {
                    //                        EmojiLandingPage(dateString: report.dateString, loggedIn: $loggedIn)
                    //                    }
                }
                .padding(.bottom, 8)
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
