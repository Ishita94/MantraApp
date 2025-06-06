//
//  SummaryTypeTab.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-05-04.
//

enum SummaryTypeTab: String, CaseIterable, Identifiable {
    case briefSummary = "briefSummary"
    case visualization = "visualization"
    var id: String {self.rawValue}
    var title: String {
        switch self {
        case .briefSummary:
            return "Brief Summary"
        case .visualization:
            return "Visualization"
        }
    }
}
