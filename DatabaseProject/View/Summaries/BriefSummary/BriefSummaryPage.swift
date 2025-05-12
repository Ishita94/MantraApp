//
//  BriefSummaryLandingPage.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-04-23.
//

import SwiftUI

struct BriefSummaryPage: View {
    @Binding var loggedIn: Bool

    var body: some View {
        VStack {
            Text("For the week of \(week.start.fullMonthandDate()) to \(week.end.fullMonthandDate()), you reported the following.")
                .foregroundColor(Color(.black))
                .font(.tabTitleinSummariesPage)
            Divider()
            
            
            }
        
    }
}

#Preview {
    
let generalViewModel = GeneralViewModel()
let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected

BriefSummaryPage(loggedIn: Binding.constant(true)) .environmentObject(generalViewModel)
    .environmentObject(symptomViewModel)
    .environmentObject(eventsViewModel)
    .environmentObject(reportingViewModel)
}
