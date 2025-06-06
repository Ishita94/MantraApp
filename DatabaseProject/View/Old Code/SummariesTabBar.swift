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
