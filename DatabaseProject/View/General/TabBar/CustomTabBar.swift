//
//  CustomTabBar.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-05-08.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: TabType

    var body: some View {
        HStack (alignment: .center, spacing: 0)
        {
            Button {
                selectedTab = .reporting
            }
            label: {
                TabBarButton(imageName: "ic_round-add-comment", titleName: "Reporting", isActive: selectedTab == .reporting, spacing: 9)
            }
            
            Spacer()
            
            Button {
                selectedTab = .summaries
            }
            label: {
                TabBarButton(imageName: "ic_round-insert-chart", titleName: "Summaries", isActive: selectedTab == .summaries, spacing: 9)
            }
            
            Spacer()

            Button {
                selectedTab = .more
            }
            label: {
                TabBarButton(imageName: "widget_small", titleName: "More", isActive: selectedTab == .more, spacing: 7)
            }
        }
        .padding()
        .frame(height: 85)
    }
}

#Preview {
    CustomTabBar(selectedTab: Binding.constant(.reporting))
}
