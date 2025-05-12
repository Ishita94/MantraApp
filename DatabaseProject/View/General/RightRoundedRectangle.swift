//
//  RightRoundedRectangle.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-03-21.
//

import Foundation
import SwiftUI

struct RightRoundedRectangle: Shape {
    var cornerRadius: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()

        let topRight = CGPoint(x: rect.maxX - cornerRadius, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY)

        path.move(to: CGPoint(x: rect.minX, y: rect.minY)) // top-left
        path.addLine(to: topRight)
        path.addArc(
            center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius),
            radius: cornerRadius,
            startAngle: .degrees(-90),
            endAngle: .degrees(0),
            clockwise: false
        )
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius))
        path.addArc(
            center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
            radius: cornerRadius,
            startAngle: .degrees(0),
            endAngle: .degrees(90),
            clockwise: false
        )
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY)) // bottom-left
        path.closeSubpath()

        return path
    }
}
