//
//  EventChart.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-05-21.
//

import SwiftUI
import OrderedCollections

struct EventChart: View {
    @EnvironmentObject var summariesViewModel: SummariesViewModel
    var selectedWeekDays: [CustomDateModel]
    var showEvents: [String]
    @State private var calculatedHeight: CGFloat = 0
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            eventsWithSimpleSpanning()
        }
        .onAppear()
        {
            summariesViewModel.setDictionaryofEventsbyDate(showEvents: showEvents)
        }
        .onChange(of: showEvents) { newValue in
            print("showEvents changed from \(showEvents) to \(newValue)")
            summariesViewModel.setDictionaryofEventsbyDate(showEvents: newValue)
        }
    }
    
    @ViewBuilder
    private func eventsWithSimpleSpanning() -> some View {
        GeometryReader { geo in
            let spacing: CGFloat = 0
            let columnWidth = (geo.size.width - spacing * 6) / 7
            
            let eventGrid = EventChartBuilder.buildEventGrid(columnWidth: columnWidth, spacing: spacing, selectedWeekDays: selectedWeekDays, eventDictionary: summariesViewModel.dictionaryofEventsbyDate)
            
            if eventGrid.isEmpty {
                Text("No events to display")
                    .font(.keyRangeTitleinSummariesPage)
                    .foregroundColor(Color(.primary0TTextOn0))
                    .padding(.leading, 18)
            } else {
                
                let totalHeight = eventGrid.reduce(0) { total, row in
                    total + (row.compactMap { $0?.height }
                        .max()
                             ?? 0)
                }
                
                ZStack(alignment: .topLeading) {
                    // Draw Vertical lines
                    ForEach(0..<selectedWeekDays.count+1, id: \.self) { columnIndex in
                        let xPosition = CGFloat(columnIndex) * (columnWidth + spacing) - (spacing / 2)
                        
                        Rectangle()
                            .fill(
                                // First and last separators are clear/transparent
                                (columnIndex == 0 || columnIndex == selectedWeekDays.count)
                                ? Color.clear
                                : Color(.outlineGrey)
                            )
                            .frame(width: 1, height: totalHeight)
                            .position(x: xPosition, y: totalHeight/2)
                    }
                    
                    // Draw events on top
                    ForEach(eventGrid.indices, id: \.self) { rowIndex in
                        let yPosition = {
                            let prevHeight = eventGrid.prefix(rowIndex).reduce(0) { total, row in
                                total + (row.compactMap { $0?.height }
                                    .max()
                                         ?? 0)
                            }
                            let currentRowHeight = eventGrid[rowIndex].compactMap { $0?.height }.max() ?? 0
                            return prevHeight + (currentRowHeight / 2)
                        }()
                        eventRow(rowIndex: rowIndex, itemsinRow: eventGrid[rowIndex], yPosition: yPosition)
                    }
                }
                .frame(height: totalHeight)
                .onAppear {
                    calculatedHeight = totalHeight
                }
                .onChange(of: totalHeight) { newHeight in
                    calculatedHeight = newHeight
                }
            }
        }
        .frame(height: calculatedHeight > 0 ? calculatedHeight : 100) // Default height of 100 until calculated
    }

    
    @ViewBuilder
    private func eventRow(rowIndex: Int, itemsinRow: [EventChartModel?], yPosition: CGFloat) -> some View {
        let validItems = itemsinRow.compactMap { $0 }.filter { $0.id > 0 }
        // Get unique events by ID to avoid duplicates
        let uniqueEvents = Dictionary(grouping: validItems) { $0.id }
            .compactMapValues { $0.first }
            .values
        
        ForEach(Array(uniqueEvents), id: \.id)
        {
            eventItem in
            
            eventCell(eventItem: eventItem, rowIndex: rowIndex, yPosition: yPosition )
        }
        
    }
    
    @ViewBuilder
    private func eventCell(eventItem: EventChartModel, rowIndex: Int, yPosition: CGFloat) -> some View {
        let xPosition = eventItem.xOffset + eventItem.width / 2
        //        let yPosition = CGFloat(rowIndex) * (44) + 22
        
        EventChartItem( eventName: eventItem.title,
                        isFirst: eventItem.isFirst,
                        isLast: eventItem.isLast)
        .frame(width: eventItem.width, height: eventItem.height)
        .position(x: xPosition, y: yPosition)
    }
}


#Preview {
    EventChart(selectedWeekDays: [ CustomDateModel(date:Date.now, shortDay: "Mar 20", monthandDate: "Mar 20", dateString: "20/3/2025")], showEvents: [])
}
