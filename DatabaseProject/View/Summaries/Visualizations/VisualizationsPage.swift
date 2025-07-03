//
//  VisualizationsLandingPage.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-05-03.
//

import SwiftUI

struct VisualizationsPage: View {
    @Binding var loggedIn: Bool
    @EnvironmentObject var summariesViewModel : SummariesViewModel
//    @State var week: Week
    @State var isSheetVisible: Bool = false
    @State var showEmoji = false
    @State var showSymptoms: [String] = []
    @State var showEvents: [String] = []
    
    private func autoSelectSymptoms () {
        showSymptoms = summariesViewModel.dictionaryofSymptoms.elements.map (\.key)
        showEvents = summariesViewModel.dictionaryofEvents.elements.map (\.key)
    }
    
    var body: some View {
        VStack (alignment:.leading){
            KeyBar()
            
            if let week = summariesViewModel.selectedWeek{
                HStack{
                    Button(action: {
                        summariesViewModel.decrementWeek()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color(.blackMediumEmphasis))
                    }
                    Spacer()
                    Text(summariesViewModel.formatStringfromWeek(week))
                        .font(.smallTitle)
                        .foregroundStyle(Color(.black))
                    Spacer()
                    if(summariesViewModel.showingNextWeek())
                    {
                        Button(action: {
                            summariesViewModel.incrementWeek()
                        }) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color(.blackMediumEmphasis))
                        }
                    }
                    else{
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color(.disabledBackground))
                    }
                }
                .padding(.top, 6)
            }
            Divider()
            
            ScrollView{
                //Emoji Bar
                if showEmoji
                {
                    EmojiBar(selectedWeekDays: summariesViewModel.selectedWeekDays)
                }
                
                //Symptom Bars
                if showSymptoms.count>0
                {
                    ForEach(showSymptoms, id: \.self){item in
                        SymptomBar(selectedWeekDays: summariesViewModel.selectedWeekDays, symptomName: item)
                    }
                }
                
                //Event Chart
                //TODO: Fix
                if showEvents.count>0
                {
                    EventChart(selectedWeekDays: summariesViewModel.selectedWeekDays, dictionaryofEvents:  summariesViewModel.dictionaryofEvents.filter{showEvents.contains($0.key)})
                }
                
//                Spacer()
            }
            .frame(maxWidth: .infinity)
            .scrollContentBackground(.hidden)
            
            Divider()
                .padding(.bottom, 4)
            
            WeekDayBar()
            
            
            Divider()
//                .padding(.bottom, 4)
            
            Button(action: {
                isSheetVisible = true
            }) {
                HStack (alignment: .center, spacing: 12){
                    Image(systemName: "pencil")
                        .foregroundColor(.white)
                    Text("Edit visualizations")
                        .foregroundColor(.white)
                        .font(.tabTitleinSummariesPage)
                }
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
                .background(Color(.primary4))
                .cornerRadius(10)
            }
        }
        .onAppear()
        {
            autoSelectSymptoms()
        }
        .sheet(isPresented: $isSheetVisible){
            EditVisualizationView(showEmoji: $showEmoji, showSymptoms: $showSymptoms, showEvents: $showEvents)
                .environmentObject(summariesViewModel)
        }
    }
}

#Preview {
    
    let generalViewModel = GeneralViewModel()
    let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
    let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
    let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected
    
    VisualizationsPage(loggedIn: Binding.constant(true))
        .environmentObject(generalViewModel)
        .environmentObject(symptomViewModel)
        .environmentObject(eventsViewModel)
        .environmentObject(reportingViewModel)
}
