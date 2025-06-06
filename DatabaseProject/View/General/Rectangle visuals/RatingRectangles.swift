//
//  RatingRectangles.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-05-17.
//

import SwiftUI

struct RatingRectangleUtils {
    static let colors: [Color] = [
        Color(.scale1), Color(.scale2), Color(.scale3), Color(.scale4), Color(.scale5), Color(.scale6), Color(.scale7),Color(.scale8), Color(.scale9), Color(.scale10)
    ]
    static func colorForSegment(_ segment: Int) -> Color {
        let x = segment % colors.count
        return colors[segment % colors.count]
    }
    static func getSegmentWidth(totalWidth: CGFloat, numberOfSegments: Int) -> CGFloat {
        let width = totalWidth / CGFloat(numberOfSegments)
        return width
    }
}
