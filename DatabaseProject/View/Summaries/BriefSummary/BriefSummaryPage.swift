//
//  BriefSummaryLandingPage.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-04-23.
//

import SwiftUI

struct BriefSummaryPage: View {
    @EnvironmentObject var summariesViewModel : SummariesViewModel
    @Binding var loggedIn: Bool
//    @State var week: Week
    
    var body: some View {
        VStack (alignment: .leading){
            //TODO: add error msg
            if let week = summariesViewModel.selectedWeek{
                (Text("For the week of ")
                 + Text(week.start.fullMonthandDate())
                    .foregroundColor(Color(.primary0TTextOn0))
                 + Text(" to ")
                 + Text(week.end.fullMonthandDate())
                    .foregroundColor(Color(.primary0TTextOn0))
                 + Text(", you reported the following.")
                )
                .font(.tabTitleinSummariesPage)
                .foregroundColor(Color(.black))
                .padding(.top, 4)
            }
            Divider()
           
            ScrollView{
                VStack (alignment: .leading, spacing: 12)
                {
                    
                    Text("Symptoms")
                        .font(.sectionTitleinSummariesPage)
                        .foregroundColor(Color(.black))
                    
                    if(summariesViewModel.dictionaryofSymptoms.count>0)
                    {
                        ForEach(Array(summariesViewModel.dictionaryofSymptoms), id: \.key) { item in
                            SymptomSummaryRow(symptomName: item.key, symptomReports: item.value)
                        }
                    }
                    else
                    {
                        SymptomSummaryRow(symptomName: "You have not logged any symptoms in this period.", symptomReports: [])
                    }
                    
                    Spacer()
                    
                    Text("Events")
                        .font(.sectionTitleinSummariesPage)
                        .foregroundColor(Color(.black))
                    
                    if(summariesViewModel.eventTrends.count>0)
                    {
                        ForEach(summariesViewModel.eventTrends) { item in
                            EventSummaryRow(eventTrend: item) //per each event
                        }
                    }
                    else
                    {
                        DisabledStateButtonwithTitle(title: "You have not logged any events in this period.")
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
            }
         
            .scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    
    let generalViewModel = GeneralViewModel()
    let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
    let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
    let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected
    let summariesViewModel = SummariesViewModel(generalViewModel: generalViewModel)  // Injected
    
    BriefSummaryPage(loggedIn: Binding.constant(true))
        .environmentObject(generalViewModel)
        .environmentObject(symptomViewModel)
        .environmentObject(eventsViewModel)
        .environmentObject(reportingViewModel)
        .environmentObject(summariesViewModel)
}
