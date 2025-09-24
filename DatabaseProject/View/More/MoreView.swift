//
//  MoreView.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-18.
//

import SwiftUI
enum MenuOption: String, CaseIterable {
    case allQuestionsAndNotes = "All Questions and Notes"
    case faqs = "Cancer Education (FAQs)"
    case reminders = "Reminders"
    case tutorials = "Tutorial"
    case settings = "Settings"
}
    
struct MoreView: View {
    @Binding var loggedIn: Bool
    
    var body: some View {
        NavigationStack{
            VStack (alignment: .leading){
                TitleBarforMoreTab(loggedIn: $loggedIn)
              
                VStack (alignment: .leading, spacing: 12 ){
                    OptionRow(loggedIn: $loggedIn, option: .allQuestionsAndNotes)
                    OptionRow(loggedIn: $loggedIn, option: .faqs)
                    OptionRow(loggedIn: $loggedIn, option: .reminders)
                    OptionRow(loggedIn: $loggedIn, option: .tutorials)
                    OptionRow(loggedIn: $loggedIn, option: .settings)
                }
                .padding(.top, 16)

                        
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        }
        }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        let generalViewModel = GeneralViewModel()
        let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
        let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
        let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected
        let summariesViewModel = SummariesViewModel(generalViewModel: generalViewModel)  // Injected

        MoreView(loggedIn: Binding.constant(true))
            .environmentObject(generalViewModel)
            .environmentObject(symptomViewModel)
            .environmentObject(eventsViewModel)
            .environmentObject(reportingViewModel)
            .environmentObject(summariesViewModel)

    }
}
