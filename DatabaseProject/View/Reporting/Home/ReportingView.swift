//
//  ReportingView.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-18.
//

import SwiftUI
import EmojiPicker

struct ReportingView: View {
    @State var reportedItems:[Report] = [Report]()
    @State var finalReportedItems:[Report] = [Report]()
    @EnvironmentObject var symptomViewModel : SymptomViewModel
    @EnvironmentObject var generalViewModel : GeneralViewModel
    @Binding var loggedIn: Bool
    @State private var selectedItem: Symptom? = nil
    @State private var emojis: [Emoji] = DefaultEmojiProvider().getAll()

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
                           // ReportListRow(item: item, emoji: emojis.first(where: { $0.name == item.emojiStateofDay }))
                        }
                        .simultaneousGesture(TapGesture().onEnded {
                            generalViewModel.setSelectedReport(report: item)
                            generalViewModel.setDateStringofCurrentReport(dateString: item.dateString)
                        })
                    }
                }
                
                .frame(maxWidth: .infinity)
                .scrollContentBackground(.hidden)
                .listStyle(.plain)
                .onAppear {
                    // Call for the data
                    symptomViewModel.getReportsofUser()
                    generalViewModel.clearDateStringofCurrentReport()
                    generalViewModel.clearSelectedReport()
                }
                ReportListRowforNewEntry(item: Report(id:"", dayNameofWeek: "", monthNameofWeek: "", dateString: "", emojiStateofDay: "", symptomNames: "",reportCompletionStatus: false, description: "", questions: "", notes: "", symptomCompletionStatus: false, eventCompletionStatus: false,    descriptionCompletionStatus: false, questionsandNotesCompletionStatus: false, emojiCompletionStatus: false, creationDateTime: Date.now, userId: AuthViewModel.getLoggedInUserId()), loggedIn: $loggedIn)
//                    .environmentObject(SymptomViewModel())
//                    .environmentObject(GeneralViewModel())
//                    .environmentObject(EventsViewModel())
            }
            
            .padding()
           .frame(maxWidth: .infinity, maxHeight: .infinity)
            
        }
    }
}


struct ReportingView_Previews: PreviewProvider {
    static var previews: some View {
        let generalViewModel = GeneralViewModel()
        let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
        let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
        let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected
        
        ReportingView(loggedIn: Binding.constant(true))
            .environmentObject(generalViewModel)
            .environmentObject(symptomViewModel)
            .environmentObject(eventsViewModel)
            .environmentObject(reportingViewModel)

    }
}
