//
//  QuestionsandNotesLandingPage.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2024-01-23.
//

import SwiftUI

struct QuestionsandNotesLandingPage: View {
    @EnvironmentObject var reportingViewModel : ReportingViewModel
    @EnvironmentObject var generalViewModel : GeneralViewModel
    @State var dateString: String
    
    @Binding var loggedIn: Bool
    
    var body: some View {
        VStack{
            NavBar(loggedIn: $loggedIn)
            Divider()
            SecondaryNavBar()
                .environmentObject(generalViewModel)
            Divider()
            QuestionsandNotesContentPage(loggedIn: $loggedIn, dateString: dateString, report:  generalViewModel.selectedReport)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//            Divider()
//            BackandNextButtonPanelforQuestionsandNotes(loggedIn: $loggedIn, dateString: dateString, questionsText: $reportingViewModel.remainingReportbyDate.questions, notesText: $reportingViewModel.remainingReportbyDate.notes)
            
        }
//        .onAppear {
//            reportingViewModel.getRemainingReport(date: prepareDate(dateString: dateString)!)
//        }
        .padding()
    }
}

#Preview {
    let generalViewModel = GeneralViewModel()
    let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
    let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
    let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected

    QuestionsandNotesLandingPage(dateString: Date.now.datetoString()!, loggedIn: Binding.constant(true))
    .environmentObject(generalViewModel)
    .environmentObject(symptomViewModel)
    .environmentObject(eventsViewModel)
    .environmentObject(reportingViewModel)
}
