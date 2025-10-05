//
//  EventTrendModel.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-08-13.
//

import Foundation
import SwiftUI

struct EventTrendModel: Identifiable {
    let id = UUID()  
    var eventReports: [EventReport]
    let aggregatedSymptoms: [AffectedSymptominEventTrend]
    let date: String
    let isFirstTime: Bool

    var dateText: String {
        return stringtoFormalShortDate(dateString: date)
    }
    
    var eventTitles: [String] {
            eventReports.map {
                isFirstTime ? $0.title.lowercased() : PastTenseConverter.convertToPast($0.title.lowercased())
            }
        }
    
    var concatenatedEventTitles: String {
        concatenateStringList(eventTitles)
    }
    
    var baseText: String {
            if isFirstTime {
                return "On \(dateText), you logged \(concatenatedEventTitles) for the first time."
            } else {
                return "On \(dateText), you \(concatenatedEventTitles)."
            }
        }
    
    var hasSymptoms: Bool {
        !aggregatedSymptoms.isEmpty
    }
    
    var transitionText: String {
        hasSymptoms ? " These events may have affected how " : ""
    }
    
    var endingText: String {
        hasSymptoms ? " on that day." : ""
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
