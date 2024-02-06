//
//  ReportedEventsView.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-12-23.
//

import SwiftUI

struct ReportedEventsView: View {
        @EnvironmentObject var eventsViewModel : EventsViewModel

        @Binding var loggedIn: Bool
        @State var dateString: String

    var body: some View {
        VStack(alignment: .leading){
            Text("Reported Events")
            .font(.symptomTitleinReportingPage)
            .foregroundColor(Color(.black))
            .padding(.vertical, 6)
            
            if(eventsViewModel.reportedEventsofUserbyDate.count>0){
                Text("""
                    These are events you have added today
                    """)
                .font(.regularText)
                .foregroundColor(Color(.blackMediumEmphasis))
                
                ScrollView{
                    ForEach(eventsViewModel.reportedEventsofUserbyDate, id: \.self) { item in
                        ReportedEventRow(item: item, loggedIn: $loggedIn,  dateString: dateString)
                    }
                    .scrollContentBackground(.hidden)
//                    .listStyle(.plain)
                    //            .frame(maxWidth: .infinity, maxHeight: 150)
                    
                }
            }
            else
            {
                Text("""
                    You have not added any events today.
                    """)
                .font(.regularText)
                .foregroundColor(Color(.blackMediumEmphasis))
            }
        }
    }
}

#Preview {
    ReportedEventsView(loggedIn: Binding.constant(true), dateString: Date.now.datetoString()!)
        .environmentObject(EventsViewModel())
}
