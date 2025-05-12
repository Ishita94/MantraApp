//
//  SummariesTabBar.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-05-04.
//

import SwiftUI

struct SummariesTabBar: View {
    @Binding var selectedTab: SummaryTypeTab
    
    var body: some View {
        HStack {
                    ForEach(SummaryTypeTab.allCases) { tab in
                        Button(action: {
                            selectedTab = tab
                        }) {
                            Text(tab.title)
                                .font(.tabTitleinSummariesPage)
                                .foregroundColor(selectedTab == tab ? .white : .primary4)
                                .padding(.vertical, 8)
                                .padding(.horizontal, 16)
                                .background(selectedTab == tab ? Color(.primary4) : Color.clear)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding(.horizontal)
//        if #available(iOS 18.0, *) {
//            TabView(selection: $selectedTab)
//            {
//                Tab.init(value: .briefSummary) {
//                    BriefSummaryLandingPage(loggedIn: $loggedIn)
//                        .toolbarVisibility(.hidden, for: .tabBar)
//                }
//                Tab.init(value: .visualization) {
//                    VisualizationsLandingPage(loggedIn: $loggedIn)
//                        .toolbarVisibility(.hidden, for: .tabBar)
//                }
//            }
//        } else {
//            // Fallback on earlier versions
//            TabView(selection: $selectedTab)
//            {
//                BriefSummaryLandingPage(loggedIn: $loggedIn)
//                    .tag(SummaryTypeTab.briefSummary)
//                    .toolbar(.hidden, for: .tabBar)
//                VisualizationsLandingPage(loggedIn: $loggedIn)
//                    .tag(SummaryTypeTab.visualization)
//                    .toolbar(.hidden, for: .tabBar)
//            }
//        }
    }
}

#Preview {
    let generalViewModel = GeneralViewModel()
    let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
    let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
    let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected
    
    SummariesTabBar(selectedTab: Binding.constant(.briefSummary))
        .environmentObject(generalViewModel)
        .environmentObject(symptomViewModel)
        .environmentObject(eventsViewModel)
        .environmentObject(reportingViewModel)
}
