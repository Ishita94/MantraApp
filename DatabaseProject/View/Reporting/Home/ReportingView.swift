//
//  ReportingView.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-18.
//

import SwiftUI

struct ReportingView: View {
    @State var reportedItems:[ReportListItem] = [ReportListItem]()
    var reportingDataService = ReportingDataService()
    
    var body: some View {
        VStack{
            List(reportedItems) { item in
                
                ReportListRow(item: item)
                
            }
            .listStyle(.plain)
            .onAppear {
                // Call for the data
                reportedItems = reportingDataService.getData()
            }
            ReportListRowforNewEntry(item: ReportListItem(day: "Thu", date: "Aug 20", emojiIconName: "ic-incomplete-red-filled", emojiStateofDay: "Nauseous", symptoms: "Nausea, Headache"))
        }
        

                     }
                     }


struct ReportingView_Previews: PreviewProvider {
    static var previews: some View {
        ReportingView()
    }
}
