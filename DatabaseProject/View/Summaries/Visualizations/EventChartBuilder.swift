//
//  EventChartBuilder.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-07-08.
//

import CoreFoundation
import OrderedCollections
import UIKit
import Foundation

class EventChartBuilder{
    static func buildEventGrid(columnWidth: CGFloat, spacing: CGFloat, selectedWeekDays: [CustomDateModel], eventDictionary: OrderedDictionary<String , [EventReport]>) -> [[EventChartModel?]] {
        var grid: [[EventChartModel?]] = []
        var eventId = 0
        let fontSizeofEventText: CGFloat = 12
        
        // Process each column (day) in order
        for (columnIndex, dayModel) in selectedWeekDays.enumerated() {
            let eventsInDay = eventDictionary[dayModel.dateString] ?? []
            
            // Process events in this column top to bottom
            for event in eventsInDay {
                eventId += 1
                
                // Check if event title fits in single column
                let textWidth = getTextWidth(for: event.title, fontSize: fontSizeofEventText) // Adjust fontSize as needed
                let needsSpanning = textWidth > (columnWidth - 16) // 16 for padding
                
                // Determine span based on text width and availability
                let spanWidth: CGFloat
                let endColumn: Int
                
                if needsSpanning && columnIndex < selectedWeekDays.count - 1 {
                    // Try to span 2 columns if text doesn't fit and not at end
                    spanWidth = 1.3
                    endColumn = columnIndex + 1
                } else {
                    // Stay in 1 column
                    spanWidth = 1
                    endColumn = columnIndex
                }
                
                // Find the first available row for this event
                let rowIndex = findFirstAvailableRow(
                    startColumn: columnIndex,
                    endColumn: endColumn,
                    grid: &grid,
                    count: selectedWeekDays.count
                )
                
                // Calculate position and size
                let xOffset = CGFloat(columnIndex) * (columnWidth + spacing)
                let width = CGFloat(spanWidth) * columnWidth + CGFloat(spanWidth - 1) * spacing //width of the event grid cell
                // Calculate available text width (subtract horizontal padding)
                let horizontalPadding: CGFloat = 16 // 8 left + 8 right padding
                let availableTextWidth = width - horizontalPadding

                // Calculate height based on text
                let textHeight = getTextHeight(for: event.title, fontSize: fontSizeofEventText, width: availableTextWidth)
                let verticalPadding: CGFloat = 8 // 4 top + 4 bottom of text
                let verticalPaddingOutsideCell: CGFloat = 6 // 3 top + 3 bottom of text

                let height = textHeight + verticalPadding + verticalPaddingOutsideCell

                let eventItem = EventChartModel(
                    id: eventId,
                    title: event.title,
                    row: rowIndex,
                    xOffset: xOffset,
                    width: width,
                    height: height,
                    isFirst: columnIndex == 0, //for each event keeps track of the row and column
                    isLast: endColumn == selectedWeekDays.count - 1
                )
                
                // Place the event in the grid
                placeEventInGrid(
                    eventItem: eventItem,
                    row: rowIndex,
                    startColumn: columnIndex,
                    endColumn: endColumn,
                    grid: &grid,
                    count: selectedWeekDays.count
                )
            }
        }
        
        return grid
    }
    
    private static func getTextWidth(for text: String, fontSize: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let attributes = [NSAttributedString.Key.font: font]
        let size = text.size(withAttributes: attributes)
        return size.width
    }
    
    static func getTextHeight(for text: String, fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let attributes = [NSAttributedString.Key.font: font]
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        
        let boundingRect = attributedString.boundingRect(
            with: CGSize(width: width, height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            context: nil
        )
        
        return boundingRect.height
    }
    
    private static func findFirstAvailableRow(startColumn: Int, endColumn: Int, grid: inout [[EventChartModel?]], count: Int) -> Int {
        // Check existing rows
        for (rowIndex, row) in grid.enumerated() {
            var canPlace = true
            for col in startColumn...endColumn {
                if col < row.count && row[col] != nil {
                    canPlace = false
                    break
                }
            }
            if canPlace {
                return rowIndex
            }
        }
        
        // Create new row
        let newRowIndex = grid.count
        grid.append(Array(repeating: nil, count: count))
        return newRowIndex
    }
    
    
    private static func placeEventInGrid(eventItem: EventChartModel, row: Int, startColumn: Int, endColumn: Int, grid: inout [[EventChartModel?]], count: Int) {
        // Ensure row exists
        while grid.count <= row {
            grid.append(Array(repeating: nil, count: count))
        }
        
        // Place the event in ALL columns of its span
        for col in startColumn...endColumn {
            if col < grid[row].count {
                grid[row][col] = eventItem
            }
        }
    }
}

