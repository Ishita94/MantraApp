//
//  ReportingView.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-18.
//

import SwiftUI

struct ReportingView: View {
    @State var reportedItems:[Report] = [Report]()
    @State var finalReportedItems:[Report] = [Report]()
    var reportingDataService = SymptomDataService()
    @EnvironmentObject var symptomViewModel : SymptomViewModel
    @Binding var loggedIn: Bool
    @State private var selectedItem: Symptom? = nil

    var body: some View {
        NavigationStack{
            
            VStack{
                TitleBarforTabs(loggedIn: $loggedIn)
                ScrollView{
                    ForEach(symptomViewModel.reportList, id: \.self) { item in
                        NavigationLink {
                            AddorEditSymptomsLandingPage(loggedIn: $loggedIn, dateString: item.dateString,
                        showAfterCreatingNewSymptomReport: false)
                        } label: {
                            ReportListRow(item: item)
                        }
                    }
                }
                
                .frame(maxWidth: .infinity)
                .scrollContentBackground(.hidden)
                .listStyle(.plain)
                .onAppear {
                    // Call for the data
                    symptomViewModel.getReportsofUser()
                }
                ReportListRowforNewEntry(item: Report(dayNameofWeek: "Thu", monthNameofWeek: "Aug 20", dateString: Date.now.datetoString() ?? "", emojiIconName: "ic-incomplete-red-filled", emojiStateofDay: "Nauseous", symptomNames: "Nausea, Headache", reportCompletionStatus: false), loggedIn: $loggedIn)
                    .environmentObject(SymptomViewModel())
                    .environmentObject(GeneralViewModel())
                    .environmentObject(EventsViewModel())
            }
            
            .padding()
           .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
    }
}


struct ReportingView_Previews: PreviewProvider {
    static var previews: some View {
        ReportingView(loggedIn: Binding.constant(true)).environmentObject(SymptomViewModel())
            .environmentObject(GeneralViewModel())
            .environmentObject(EventsViewModel())
            .environmentObject(ReportingViewModel())

    }
}
