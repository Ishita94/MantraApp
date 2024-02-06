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
            QuestionsandNotesContentPage(loggedIn: $loggedIn, dateString: dateString, questionsText: $reportingViewModel.remainingReportbyDate.questions, notesText: $reportingViewModel.remainingReportbyDate.notes)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            Divider()
            BackandNextButtonPanelforQuestionsandNotes(loggedIn: $loggedIn, dateString: dateString, questionsText: $reportingViewModel.remainingReportbyDate.questions, notesText: $reportingViewModel.remainingReportbyDate.notes)
            
        }
        .onAppear {
            reportingViewModel.getRemainingReport(date: prepareDate(dateString: dateString)!)
        }
        .padding()
    }
}

#Preview {
    QuestionsandNotesLandingPage(dateString: Date.now.datetoString()!, loggedIn: Binding.constant(true)).environmentObject(SymptomViewModel())
        .environmentObject(GeneralViewModel())
        .environmentObject(EventsViewModel())
        .environmentObject(ReportingViewModel())

}
