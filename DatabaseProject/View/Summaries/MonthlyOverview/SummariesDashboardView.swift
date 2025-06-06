//
//  SummaryDashboardView.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-04-23.
//

import SwiftUI

struct SummariesDashboardView: View {
    //    @EnvironmentObject var generalViewModel : GeneralViewModel
    @EnvironmentObject var summariesViewModel : SummariesViewModel
    @Binding var loggedIn: Bool
    @Binding var selectedTab: TabType
    
    var body: some View {
        NavigationStack{
            VStack (alignment: .leading){
                TitleBarforSummariesTab(loggedIn: $loggedIn)
                ScrollView{
                    VStack {
                        ForEach(summariesViewModel.weeks, id: \.self) { week in
                            WeeklySummaryRow(loggedIn: $loggedIn, week: week)
                        }
                    }
                }
//                .padding(.bottom, 8)
            }
            .onChange(of: summariesViewModel.dateCompontents) { _ in
                Task {
                    await summariesViewModel.getWeeklyBoundaries()
                }
            }
            .onChange(of: selectedTab) { newValue in
                if(newValue == .summaries){
                    summariesViewModel.resetDateComponents()
                    summariesViewModel.resetSelectedWeek()
                }
            }
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            
        }
    }
}

struct SummariesDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        let generalViewModel = GeneralViewModel()
        let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
        let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
        let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected
        let summariesViewModel = SummariesViewModel(generalViewModel: generalViewModel)  // Injected

        SummariesDashboardView(loggedIn: Binding.constant(true), selectedTab: Binding.constant(.summaries))
            .environmentObject(generalViewModel)
            .environmentObject(symptomViewModel)
            .environmentObject(eventsViewModel)
            .environmentObject(reportingViewModel)
            .environmentObject(summariesViewModel)

    }
}
