//
//  CustomTabbarforSummaries.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-05-08.
//

import SwiftUI

struct CustomTabbarforSummaries: View {
    @Binding var selectedTab: SummaryTypeTab
    var activeForegroundColor: Color = .white
    var activeBackgroundColor: Color = .primary4
    
    //For matched Geometry Effect
    @Namespace private var animation
    
    @State private var tabLocation: CGRect = .zero
    var body: some View {
        HStack (spacing: 0){
            ForEach(SummaryTypeTab.allCases) { tab in
                Button(action: {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        selectedTab = tab
                    }
                }) {
                    SummaryTabButton(isActive: selectedTab == tab, activeForegroundColor: activeForegroundColor, activeBackgroundColor: activeBackgroundColor, title: tab.title, animation: animation)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal)
        .frame(height: 60)
        .background(tabBarBackground)
        .animation(.smooth(duration: 0.3, extraBounce: 0), value: selectedTab)
    }
    
    // Extracted background view
    private var tabBarBackground: some View {
        ZStack(alignment: .leading) {
            // Main background with stroke
            Capsule()
                .fill(Color.primary0)
                .overlay(
                    Capsule()
                        .stroke(Color.outlineGrey, lineWidth: 1)
                )
        }
    }
}

#Preview {
    let generalViewModel = GeneralViewModel()
    let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
    let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
    let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected
    
    CustomTabbarforSummaries(selectedTab: Binding.constant(.briefSummary))
        .environmentObject(generalViewModel)
        .environmentObject(symptomViewModel)
        .environmentObject(eventsViewModel)
        .environmentObject(reportingViewModel)
}

