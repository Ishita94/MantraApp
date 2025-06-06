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
            
            VStack (spacing: 15){
                TitleBarforReportingTab(loggedIn: $loggedIn)
                ScrollView {
                    VStack (spacing: 12){
                        ForEach(symptomViewModel.reportList, id: \.self) { item in
                            NavigationLink {
                                //                            AddorEditSymptomsLandingPage(loggedIn: $loggedIn, dateString: item.dateString,
                                //                        showAfterCreatingNewSymptomReport: false)
                                
                                EditReportView(loggedIn: $loggedIn, dateString: item.dateString)
                                
                            } label: {
                                ReportListRow(item: item)
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                generalViewModel.setSelectedReport(report: item)
                                generalViewModel.setDateStringofCurrentReport(dateString: item.dateString)
                            })
                        }
                    }
                    .padding(.bottom, 12)
                }
                .frame(maxWidth: .infinity)
                .scrollContentBackground(.hidden)
//                .listStyle(.plain)
                .onAppear {
                    // Call for the data
                    symptomViewModel.getReportsofUser()
                    generalViewModel.clearDateStringofCurrentReport()
                    generalViewModel.clearSelectedReport()
                }
                
                if(!symptomViewModel.reportList.contains(where: { $0.dateString == Date.now.datetoString()!}))
                {
                    ReportListRowforNewEntry(item: Report(id:"", dayNameofWeek: "", monthNameofWeek: "", dateString: "", emojiStateofDay: "", symptomNames: "",reportCompletionStatus: false, description: "", questions: "", notes: "", symptomCompletionStatus: false, eventCompletionStatus: false,    descriptionCompletionStatus: false, questionsandNotesCompletionStatus: false, emojiCompletionStatus: false, creationDateTime: Date.now, userId: AuthViewModel.getLoggedInUserId()), loggedIn: $loggedIn)
                    //                    .environmentObject(SymptomViewModel())
                    //                    .environmentObject(GeneralViewModel())
                    //                    .environmentObject(EventsViewModel())
                }
            }
            .padding()
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
