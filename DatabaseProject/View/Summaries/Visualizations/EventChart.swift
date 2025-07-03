//
//  EventChart.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-05-21.
//

import SwiftUI
import OrderedCollections

struct EventChart: View {
    //    @EnvironmentObject var summariesViewModel: SummariesViewModel
    var selectedWeekDays: [CustomDateModel]
    var dictionaryofEvents: OrderedDictionary<String, [EventReport]>
    var body: some View {
        ScrollView([.horizontal, .vertical]) {
            ForEach(Array(dictionaryofEvents), id: \.key) { item in
                
                VStack(spacing: 8) {
                    Text(item.key)
                }
                //                ForEach(0..<7) { index in
                //                    VStack(spacing: 12) {
                //                        ForEach(0..<3) { _ in
                //                            Rectangle()
                //                                .fill(Color.blue)
                //                                .frame(width: 60, height: 40)
                //                                .cornerRadius(6)
                //                        }
                //                    }
                //                    .frame(width: 70)
                //                }
                //            }
            }
            .padding()
            
            .frame(height: 300)
            
        }
    }
}

                
                
        
//        GeometryReader { geo in
//            let spacing: CGFloat = 8
//            let columnWidth = (geo.size.width - spacing * 6) / 7
//
//            ScrollView(.vertical) {
//                VStack(alignment: .leading, spacing: 0) {
//                    ForEach(selectedWeekDays.indices, id: \.self) { index in
//                        let item = selectedWeekDays[index].dateString
//                        let eventsInDay = dictionaryofEventsbyDate[item] ?? []
//
//                        HStack(alignment: .top, spacing: spacing) {
//                            Spacer().frame(width: CGFloat(index) * (columnWidth + spacing))
//
//                            VStack(alignment: .leading, spacing: 8) {
//                                ForEach(eventsInDay.indices, id: \.self) { i in
//                                    let event = eventsInDay[i]
//
//                                    EventChartItem(
//                                        eventName: event.name,
//                                        isFirst: index == 0,
//                                        isLast: index == selectedWeekDays.count - 1,
//                                        itemWidth: columnWidth
//                                    )
//                                    .frame(width: columnWidth * 2)
//                                }
//                            }
//                        }
//                    }
//                }
//                .padding(.horizontal, 8)
//            }
//        }
//        .frame(height: 400) // give GeometryReader a max height
//    }
//}


#Preview {
    EventChart(selectedWeekDays: [ CustomDateModel(date:Date.now, shortDay: "Mar 20", monthandDate: "Mar 20", dateString: "20/3/2025") ]
               , dictionaryofEvents: [:])
}
