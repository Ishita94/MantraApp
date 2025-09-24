//
//  SymptomTrendModel.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-07-21.
//

import CoreFoundation
import Foundation
import SwiftUICore

struct AffectedSymptominEventTrend: Equatable {
    let name: String
    let trend: String
    let colorforSymptomName: Color?    // Pre-calculated
    let colorforSymptomTrend: Color?   // Pre-calculated
    let rating: Int
    //        let trendType: TrendType          // Raw data for custom logic
    
    //    var startDate: Date?
    //    var endDate: Date?
    
}
