//
//  EventSummaryRow.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-05-05.
//

import SwiftUI

struct EventSummaryRow: View {
    let eventTrend: EventTrendModel
    
    let colorA: Color = .primary0TTextOn0
    let colorB: Color = .offBlackText
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(Color(.greyNonClickable))
            
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.outlineGrey), lineWidth: 1)
            
            VStack(alignment: .leading, spacing: 0) {
                buildFullText()
                    .font(.blackinText)
                    .multilineTextAlignment(.leading)
                    .frame(minHeight: 20, alignment: .leading) 
            }
            .padding(16)
            .frame(maxWidth: .infinity, alignment: .leading)  //Ensure VStack is leading-aligned
        }
    }
    
    private func buildFullText() -> Text {
        var result = buildBaseText()
        
        if eventTrend.hasSymptoms && !eventTrend.isFirstTime {
            result = result +
                Text(eventTrend.transitionText).foregroundColor(colorB) +
                buildSymptomText() +
                Text(eventTrend.endingText).foregroundColor(colorB)
        }
        
        return result
    }
    
    private func buildBaseText() -> Text {
        var result = Text("On ")
            .foregroundColor(colorB)
        
        result = result + Text(eventTrend.dateText)
            .foregroundColor(colorA)
        
        // Different text based on isFirstTime
        if eventTrend.isFirstTime {
            result = result + Text(", you logged ")
                .foregroundColor(colorB)
            
            result = result + Text(eventTrend.concatenatedEventTitles)
                .foregroundColor(colorA)
            
            result = result + Text(" for the first time.")
                .foregroundColor(colorB)
        } else {
            result = result + Text(", you ")
                .foregroundColor(colorB)
            
            result = result + Text(eventTrend.concatenatedEventTitles)
                .foregroundColor(colorA)
            
            result = result + Text(".")
                .foregroundColor(colorB)
        }
        
        return result
    }
    
    private func buildSymptomText() -> Text {
        let symptoms = eventTrend.aggregatedSymptoms
        var result = Text("")
        
        for (index, symptom) in symptoms.enumerated() {
            result = result + Text("your ")
                .foregroundColor(colorB)
            
            result = result + Text("\(symptom.name.lowercased()) ")
                .foregroundColor(colorA)
            
            result = result + Text("was ")
                .foregroundColor(colorB)
            
            result = result + Text(symptom.trend.lowercased())
                .foregroundColor(symptom.colorforSymptomTrend)
            
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
    EventSummaryRow(eventTrend: EventTrendModel(eventReports: [], aggregatedSymptoms: [], date: "", isFirstTime: false))
}
