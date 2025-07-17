//
//  EventChartModel.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-07-08.
//

import CoreFoundation

struct EventChartModel {
    let id: Int
    let title: String
    let row: Int
    let xOffset: CGFloat
    let width: CGFloat
    let height: CGFloat
    let isFirst: Bool
    let isLast: Bool
}
