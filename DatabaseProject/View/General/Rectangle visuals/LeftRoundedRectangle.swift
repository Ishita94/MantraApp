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

        let topLeft = CGPoint(x: rect.minX + cornerRadius, y: rect.minY)
        let bottomLeft = CGPoint(x: rect.minX + cornerRadius, y: rect.maxY)

        path.move(to: CGPoint(x: rect.maxX, y: rect.minY)) // top-right
        path.addLine(to: topLeft)
        path.addArc(
            center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius),
            radius: cornerRadius,
            startAngle: .degrees(-90),
            endAngle: .degrees(-180),
            clockwise: true
        )
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - cornerRadius))
        path.addArc(
            center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius),
            radius: cornerRadius,
            startAngle: .degrees(180),
            endAngle: .degrees(90),
            clockwise: true
        )
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY)) // bottom-right
        path.closeSubpath()

        return path
    }
}

#Preview{
    LeftRoundedRectangle(cornerRadius: 16)
        .fill(Color.blue)
            .frame(width: 200, height: 100)
}

