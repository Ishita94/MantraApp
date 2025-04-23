//
//  LeftRoundedRectangle.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-03-21.
//

import Foundation
import SwiftUI

struct LeftRoundedRectangle: Shape {
    var cornerRadius: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        // Start from the top-right corner
        path.move(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX + cornerRadius, y: rect.minY))  // Move left, stopping before the rounded part
        path.addArc(
            center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius),
            radius: cornerRadius,
            startAngle: Angle(degrees: -90),
            endAngle: Angle(degrees: -180),
            clockwise: false
        )
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - cornerRadius))  // Move down to bottom-left
        path.addArc(
            center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius),
            radius: cornerRadius,
            startAngle: Angle(degrees: -180),
            endAngle: Angle(degrees: -270),
            clockwise: false
        )
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))  // Move right to bottom-right
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))  // Move back up
        return path
    }
}
