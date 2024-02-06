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
            EmojiContentPage(loggedIn: $loggedIn, dateString: dateString, emojiStateofDay: $reportingViewModel.remainingReportbyDate.emojiStateofDay)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            Divider()
            BackandNextButtonPanelforEmoji(loggedIn: $loggedIn, dateString: dateString, emojiStateofDay: $reportingViewModel.remainingReportbyDate.emojiStateofDay)
        }
        .onAppear {
            reportingViewModel.getRemainingReport(date: prepareDate(dateString: dateString)!)
        }
        .padding()
    }
}

#Preview {
    EmojiLandingPage(dateString: Date.now.datetoString()!, loggedIn: Binding.constant(true)).environmentObject(SymptomViewModel())
        .environmentObject(GeneralViewModel())
        .environmentObject(EventsViewModel())
        .environmentObject(ReportingViewModel())

}
