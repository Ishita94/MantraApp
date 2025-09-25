//
//  HomePageView.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-18.
//

import SwiftUI

struct HomePageView: View {
    @EnvironmentObject var generalViewModel : GeneralViewModel
    @Binding var loggedIn: Bool
    //    @Binding var selectedTab: Int
    @State var selectedTab: TabType = .reporting
    var body: some View {
        VStack (alignment: .center){
            switch selectedTab {
            case .reporting:
                ReportingView(loggedIn: $loggedIn)
            case .summaries:
                SummariesDashboardView(loggedIn: $loggedIn, selectedTab: $selectedTab)
            case .more:
                MoreView(loggedIn: $loggedIn)
            }
            Spacer()
            Divider()
            CustomTabBar(selectedTab: $selectedTab)
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        let generalViewModel = GeneralViewModel()
        let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
        let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
        let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected
        
        HomePageView(loggedIn: Binding.constant(true))
            .environmentObject(generalViewModel)
            .environmentObject(symptomViewModel)
            .environmentObject(eventsViewModel)
            .environmentObject(reportingViewModel)
            .padding()
    }
}
