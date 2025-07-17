//
//  EventChartItem.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-05-21.
//

import SwiftUI

struct EventChartItem: View {
    var eventName: String? = nil
    var isFirst: Bool = false
    var isLast: Bool = false
    var body: some View {
        VStack (alignment: .center, spacing: 0){
            if let name = eventName{
                Text(name)
                    .font(.contentTextinVisualization)
                    .foregroundColor(Color(.primary0TTextOn0))
//                    .lineLimit(3)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
            }
        }
        .frame(maxWidth: .infinity, alignment: .topLeading)
        .background(Color(.primary0))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(.outlineGrey), lineWidth: 1)
        )
        .allowsHitTesting(false) // prevent weird tap overlaps
    }
    
}

#Preview {
    EventChartItem()
}
