//
//  ReportListRowforNewEntry.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-18.
//

import SwiftUI

struct ReportListRowforNewEntry: View {
    var item: Report
    @EnvironmentObject var symptomController : SymptomViewModel
    @EnvironmentObject var eventController : EventsViewModel
    @Binding var loggedIn: Bool
    @State private var readyToNavigate = false

    var body: some View {
        NavigationStack{
            ZStack{
                RoundedRectangle(cornerRadius: 19)
                        .foregroundColor(Color(.primary0)) // this is the actual fill

                    // Border overlay
                    RoundedRectangle(cornerRadius: 19)
                        .stroke(Color(.blackMediumEmphasis), lineWidth: 2)
            
                HStack {
                        VStack (alignment:.trailing){
                            Text(Date.now.dayNameOfWeek())
                            //item.date.dayNameOfWeek()!
                                .font(.dateText)
                                .foregroundColor(Color("BlackMediumEmphasis"))
                            
                            Text(Date.now.monthandDate())
                                .font(.dateText)
                        
                        }
                    Spacer()
                    
                    Button(action: {
                        readyToNavigate = true
                    }) {
                        HStack {
                            Image(systemName:"plus")
                                .font(.smallTitle)
                                .foregroundColor(Color(.white))
                            Text("Add Today's Report")
                                .font(.titleinRowItem)
                                .foregroundColor(Color("Primary4tTextOn4"))
                        }
                        .padding()
                        .background(Color(.primary4))
                        .cornerRadius(10)
                    }
                    
//                    HStack{
//
//                       Image(systemName:"plus")
//                                .resizable()
//                                .aspectRatio(contentMode: .fit)
//                                .frame(height: 30)
//                                .foregroundColor(Color(.white))
//                            
//                        NavigationLink {
//                                AddorEditSymptomsLandingPage(loggedIn: $loggedIn, date: Date.now, dateString: Date.now.datetoString()!, createNewReport: true)
//                                
//                            } label: {
//                                Text("Add Today's Report")
//                                    .aspectRatio(contentMode: .fit)
//                                    .font(.system(size: 18))
//                                    .padding()
//                                    .foregroundColor(Color("Primary4tTextOn4"))
//                                    .overlay(
//                                        RoundedRectangle(cornerRadius: 10)
//                                            .stroke(Color.white, lineWidth: 2)
//                                    )
//                                    .background(Color("Primary4"))
//                                    .cornerRadius(10)
//                            }
//                        
//                    }
                }
                .padding()
            }
            .padding(.vertical, 15)
            .frame(maxWidth: .infinity, maxHeight: 60)
        }
        .navigationDestination(isPresented: $readyToNavigate) {
            AddorEditSymptomsLandingPage(loggedIn: $loggedIn, date: Date.now, dateString: Date.now.datetoString()!)
        }
        }
}


struct ReportListRowforNewEntry_Previews: PreviewProvider {
    static var previews: some View {
        let generalViewModel = GeneralViewModel()
        let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
        let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
        let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected
        
        ReportListRowforNewEntry(item: Report(id:"", dayNameofWeek: "", monthNameofWeek: "", dateString: "", emojiStateofDay: "", symptomNames: "",reportCompletionStatus: false, description: "", questions: "", notes: "", symptomCompletionStatus: false, eventCompletionStatus: false,    descriptionCompletionStatus: false, questionsandNotesCompletionStatus: false, emojiCompletionStatus: false, creationDateTime: Date.now, userId: AuthViewModel.getLoggedInUserId()), loggedIn: Binding.constant(true))            .environmentObject(generalViewModel)
            .environmentObject(symptomViewModel)
            .environmentObject(eventsViewModel)
            .environmentObject(reportingViewModel)
    }
    }

