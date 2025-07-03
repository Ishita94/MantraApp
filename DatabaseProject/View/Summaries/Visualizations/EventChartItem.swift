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
    var itemWidth: CGFloat = 52 //42+5+5, height: 26+12+12
    var body: some View {
        VStack (alignment: .center, spacing: 0){
            if let name = eventName{
                Text(name)
                            .padding()
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(8)
                            .lineLimit(3)
                            .fixedSize(horizontal: false, vertical: true)
//                ZStack{
//                    RoundedRectangle(cornerRadius: 10)
//                        .foregroundColor(Color(.primary0))
//                        .overlay(
//                            RoundedRectangle(cornerRadius: 10)
//                                .stroke(Color(.outlineGrey), lineWidth: 1) // border stroke
//                        )
//                    
//                    Text(eventName!)
//                        .foregroundColor(Color(.primary0TTextOn0))
//                        .font(.contentTextinVisualization)
//                        .lineLimit(3)
//                        .padding()
//                        .fixedSize(horizontal: false, vertical: true) // 👈 Let height expand
                }
            }
        
        .padding(.horizontal, 4)
        .padding(.vertical, 4)
        .frame(maxWidth: .infinity, alignment: .topLeading)
     .customBorderOverlay(isFirst: isFirst, isLast: isLast)
        .allowsHitTesting(false) // prevent weird tap overlaps
    }

}

#Preview {
    EventChartItem()
}
