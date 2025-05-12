//
//  SummaryDashboardView.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-04-23.
//

import SwiftUI

struct SummariesDashboardView: View {
    @EnvironmentObject var generalViewModel : GeneralViewModel
    @Binding var loggedIn: Bool
    
    var body: some View {
        NavigationStack{
            
            VStack{
                TitleBarforTabs(loggedIn: $loggedIn)
            }
        }
    }
}

struct SummaryDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        let generalViewModel = GeneralViewModel()
        let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
        let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
        let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected
        
        ReportingView(loggedIn: Binding.constant(true))
            .environmentObject(generalViewModel)
            .environmentObject(symptomViewModel)
            .environmentObject(eventsViewModel)
            .environmentObject(reportingViewModel)

    }
}
