//
//  EventSummaryRow.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-05-05.
//

import SwiftUI

struct EventSummaryRow: View {
    let eventTrend: EventTrendModel
    
    // Define your three colors
    let colorA: Color = .primary0TTextOn0      // Date, Event titles, Symptom names
    let colorB: Color = .offBlackText    // Normal text
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // Date and events with colors
            buildBaseText()
            
            // Symptoms section with three colors
            if eventTrend.hasSymptoms {
                (Text(eventTrend.transitionText)
                    .foregroundColor(colorB) +
                 
                 buildSymptomText() +
                 
                 Text(eventTrend.endingText)
                    .foregroundColor(colorB))
                .font(.body)
            }
        }
        .padding()
        .background(Color.gray.opacity(0.05))
        .cornerRadius(12)
    }
    
    private func buildBaseText() -> Text {
        // "On " (colorB)
        var result = Text("On ")
            .font(.headline)
            .fontWeight(.semibold)
            .foregroundColor(colorB)
        
        // Date (colorA)
        result = result + Text(eventTrend.dateText)
            .font(.headline)
            .fontWeight(.semibold)
            .foregroundColor(colorA)
        
        // ", you " (colorB)
        result = result + Text(", you ")
            .font(.headline)
            .fontWeight(.semibold)
            .foregroundColor(colorB)
        
        // Event titles (colorA)
        result = result + Text(eventTrend.concatenatedEventTitles)
            .font(.headline)
            .fontWeight(.semibold)
            .foregroundColor(colorA)
        
        // "." (colorB)
        result = result + Text(".")
            .font(.headline)
            .fontWeight(.semibold)
            .foregroundColor(colorB)
        
        return result
    }
    
    private func buildSymptomText() -> Text {
        let symptoms = eventTrend.aggregatedSymptoms
        var result = Text("")
        
        for (index, symptom) in symptoms.enumerated() {
            // "your "
            result = result + Text("your ")
                .foregroundColor(colorB)
            
            // Symptom name (colorA)
            result = result + Text("\(symptom.name.lowercased()) ")
                .foregroundColor(colorA)
            
            // "was "
            result = result + Text("was ")
                .foregroundColor(colorB)
            
            // Trend value (colorC - different per symptom)
            result = result + Text(symptom.trend.lowercased())
                .fontWeight(.semibold)
                .foregroundColor(symptom.colorforSymptomTrend)
            
            // Connector
            if index < symptoms.count - 1 {
                if index == symptoms.count - 2 {
                    result = result + Text(" and ")
                        .foregroundColor(colorB)
                } else {
                    result = result + Text(", ")
                        .foregroundColor(colorB)
                }
            }
        }
        
        return result
    }
}

#Preview {
    EventSummaryRow(eventTrend: EventTrendModel(eventReports: [], aggregatedSymptoms: [], date: Date()))
}
