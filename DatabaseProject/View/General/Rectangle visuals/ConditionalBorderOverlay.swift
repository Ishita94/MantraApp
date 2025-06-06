//
//  ConditionalBorderOverlay.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-05-16.
//

import SwiftUI
// Draw borders conditionally

import SwiftUI

public extension View {
    func customBorderOverlay(
        isFirst: Bool,
        isLast: Bool,
        strokeColor: Color? = nil,
        lineWidth: CGFloat = 1
    ) -> some View {
        let actualColor = strokeColor ?? Color(.outlineGrey)

        return self.overlay(
            GeometryReader { geo in
                Path { path in
                    let w = geo.size.width
                    let h = geo.size.height

                    // Top
                    path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: w, y: 0))

                    // Bottom
                    path.move(to: CGPoint(x: 0, y: h))
                    path.addLine(to: CGPoint(x: w, y: h))

                    // Left
                    if !isFirst {
                        path.move(to: CGPoint(x: 0, y: 0))
                        path.addLine(to: CGPoint(x: 0, y: h))
                    }

                    // Right
                    if !isLast {
                        path.move(to: CGPoint(x: w, y: 0))
                        path.addLine(to: CGPoint(x: w, y: h))
                    }
                }
                .stroke(actualColor, lineWidth: lineWidth)
            }
        )
    }
}
