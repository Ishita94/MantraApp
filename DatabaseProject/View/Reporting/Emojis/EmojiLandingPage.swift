//
//  EmojiLandingPage.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2024-01-23.
//

import SwiftUI

struct EmojiLandingPage: View {
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
            EmojiContentPage(loggedIn: $loggedIn, dateString: dateString, report: generalViewModel.selectedReport)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
//            BackandNextButtonPanelforEmoji(loggedIn: $loggedIn, dateString: dateString, emojiStateofDay: $generalViewModel.selectedReport.emojiStateofDay, emojiValue: $generalViewModel.selectedReport.emojiValue)
        }
        .padding()
    }
}

#Preview {
    let generalViewModel = GeneralViewModel()
    let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
    let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
    let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected
    
    EmojiLandingPage(dateString: Date.now.datetoString()!, loggedIn: Binding.constant(true))
        .environmentObject(generalViewModel)
        .environmentObject(symptomViewModel)
        .environmentObject(eventsViewModel)
        .environmentObject(reportingViewModel)
}
