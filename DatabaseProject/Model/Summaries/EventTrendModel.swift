//
//  EventTrendModel.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-08-13.
//

import Foundation
import SwiftUI

struct EventTrendModel {
    var eventReports: [EventReport]
    let aggregatedSymptoms: [AffectedSymptominEventTrend]
    let date: Date
    
    var dateText: String {
        date.datetoFormalDatewithDayString()
    }
    
    var eventTitles: [String] {
        eventReports.map { PastTenseConverter.convertToPast($0.title.lowercased()) }
    }
    
    var concatenatedEventTitles: String {
        concatenateStringList(eventTitles)
    }
    
    var baseText: String {
        "On \(dateText), you \(concatenatedEventTitles)."
    }
    
    var hasSymptoms: Bool {
        !aggregatedSymptoms.isEmpty
    }
    
    var transitionText: String {
        hasSymptoms ? " These events may have affected how " : ""
    }
    
    var endingText: String {
        hasSymptoms ? " during this period." : ""
    }
    
    private func concatenateStringList(_ items: [String]) -> String {
        if items.count == 1 {
            return items[0]
        } else if items.count == 2 {
            return items.joined(separator: " and ")
        } else {
            let allButLast = items.dropLast().joined(separator: ", ")
            return "\(allButLast), and \(items.last!)"
        }
    }
}
