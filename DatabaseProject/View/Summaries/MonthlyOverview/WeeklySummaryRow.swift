//
//  WeeklySummaryRow.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-04-23.
//

import SwiftUI

struct WeeklySummaryRow: View {
    @EnvironmentObject var summariesViewModel : SummariesViewModel

    @Binding var loggedIn: Bool
    @State var readyToNavigate: Bool = false
//    @State var stepNumber: Int = 1
    @State var week: Week

    @State var title: String = ""
//    @State var dateString: String
//
    var rowColor: Color = Color(.primary0)
    var rowTitleTextColor: Color = Color(.primary0TTextOn0)
    var rowSubTitleTextColor: Color = Color(.blackMediumEmphasis)

    init(loggedIn: Binding<Bool>, week: Week) {
        do {
            self._loggedIn = loggedIn
            self._week = .init(initialValue: week)
            if(Date()>=week.start && Date()<=week.end){
                rowColor = Color(.primary4)
                rowTitleTextColor = Color(.primary4TTextOn4)
                rowSubTitleTextColor = Color(.white)
            }
        }
        
    }
    var body: some View {
        NavigationStack (){
            ZStack{
                RoundedRectangle(cornerRadius: 16)
                        .fill(rowColor)
                        .frame(maxWidth: .infinity, maxHeight: 81)
                HStack{
                    VStack(alignment: .leading, spacing: 6){
                        Text(summariesViewModel.formatStringfromWeek(week))
                            .foregroundColor(rowTitleTextColor)
                            .font(.largeTitleinListinSummariesandMorePage)
                        Text("Click to view summary")
                            .foregroundColor(rowSubTitleTextColor)
                            .font(.regularText)
                    }
                    Spacer()
                    Button(action: {
                        summariesViewModel.setSelectedWeek(start: week.start, end: week.end)
                        readyToNavigate=true
                    }) {
                        Image("ic-edit")
                    }
                }
                .padding()
            }
            .navigationDestination(isPresented: $readyToNavigate) {
                SummariesContainerView(loggedIn: $loggedIn)
            }
        }
    }
}

#Preview {
    let generalViewModel = GeneralViewModel()
    let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
    let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
    let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected
    
    WeeklySummaryRow(loggedIn: Binding.constant(true), week: Week(start: Date.now, end: Date.now))
        .environmentObject(generalViewModel)
        .environmentObject(symptomViewModel)
        .environmentObject(eventsViewModel)
        .environmentObject(reportingViewModel)
}
