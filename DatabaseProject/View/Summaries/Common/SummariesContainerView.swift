//
//  SummariesContainerView.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-05-04.
//

import SwiftUI

struct SummariesContainerView: View {
    @EnvironmentObject var summariesViewModel : SummariesViewModel
    @Binding var loggedIn: Bool
    @State var selectedTab: SummaryTypeTab = .briefSummary
    @State var week: Week
    
    var body: some View {
        VStack(alignment: .leading) {
            NavBar(loggedIn: $loggedIn, titleText: "Summary for", subtitleText: summariesViewModel.formatStringfromWeekwithYear (week))
            Divider()
            HStack{
                Spacer()
                CustomTabbarforSummaries(selectedTab: $selectedTab)
                Spacer()
            }
            .padding(.top, 10)
            switch selectedTab {
            case .briefSummary:
                BriefSummaryPage(loggedIn: $loggedIn, week: week)
                    .padding(.top, 4)

            case .visualization:
                VisualizationsPage(loggedIn: $loggedIn, week: week)
                    .padding(.top, 4)
            }
        }
        .onAppear()
        {
            summariesViewModel.getReportsinDateRange(fromDate: week.start, toDate: week.end)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        
    }
}

#Preview {
    let generalViewModel = GeneralViewModel()
    let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
    let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
    let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected
    let summariesViewModel = SummariesViewModel(generalViewModel: generalViewModel)  // Injected
    SummariesContainerView(loggedIn: Binding.constant(true), week: Week(start: Date.now, end: Date.now))
        .environmentObject(generalViewModel)
        .environmentObject(symptomViewModel)
        .environmentObject(eventsViewModel)
        .environmentObject(reportingViewModel)
        .environmentObject(summariesViewModel)

}
