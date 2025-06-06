//
//  SymptomBarItem.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-05-13.
//

import SwiftUI

struct SymptomBarItem: View {
    var symptomRating: Int? = nil
    var isFirst: Bool = false
    var isLast: Bool = false
    var itemWidth: CGFloat = 52 //42+5+5, height: 26+12+12
    var body: some View {
        VStack (alignment: .center, spacing: 0){
            if let rating = symptomRating{
                if(rating==0){
                    RoundedRectangle(cornerRadius: 6)
                        .foregroundColor(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 6)
                                .stroke(Color(.outlineGrey), lineWidth: 1) // border stroke
                        )
                }
                else {
                    RoundedRectangle(cornerRadius: 6)
                        .foregroundColor(RatingRectangleUtils.colorForSegment(rating))
                }
            }
        }
        .padding(.horizontal, 5)
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .customBorderOverlay(isFirst: isFirst, isLast: isLast)
    }
    
}

#Preview {
    SymptomBarItem()
}
