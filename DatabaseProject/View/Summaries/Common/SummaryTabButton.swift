//
//  SummaryTabButton.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-05-08.
//

import SwiftUI

struct SummaryTabButton: View {
    let isActive: Bool
    let activeForegroundColor: Color
    let activeBackgroundColor: Color
    let title: String
    var animation: Namespace.ID
    
    // Constructor to pass the namespace
    init(isActive: Bool, activeForegroundColor: Color, activeBackgroundColor: Color, title: String, animation: Namespace.ID) {
        self.isActive = isActive
        self.activeForegroundColor = activeForegroundColor
        self.activeBackgroundColor = activeBackgroundColor
        self.title = title
        self.animation = animation
        }
    
    var body: some View {
        Text(title)
            .font(.tabTitleinSummariesPage)
            .foregroundColor(isActive ? activeForegroundColor : .primary4)
            .padding(.vertical, 14)
            .padding(.horizontal, 14)
            .contentShape(Rectangle())
            .background{
                if isActive{
                    Capsule()
                        .fill(Color(.primary4).gradient)
                        .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                }
            }
            .cornerRadius(8)
    }
    
}

// Preview wrapper 
struct SummaryTabButtonPreview: View {
    @Namespace private var animation
    
    var body: some View {
        SummaryTabButton(
            isActive: true,
            activeForegroundColor: .white,
            activeBackgroundColor: Color(.primary4),
            title: SummaryTypeTab.briefSummary.title,
            animation: animation
        )
        .padding()
        .background(Color.gray.opacity(0.2))
        .previewLayout(.sizeThatFits)
    }
}

#Preview {
    SummaryTabButtonPreview()
}
