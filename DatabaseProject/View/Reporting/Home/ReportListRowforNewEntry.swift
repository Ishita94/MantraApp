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
    
    var body: some View {
//        NavigationStack{
            ZStack{
                Image("ic-report-list-item-bordered")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                HStack {
                        VStack (alignment:.trailing){
                            Text(Date.now.dayNameOfWeek()!)
                            //item.date.dayNameOfWeek()!
                                .font(.dateText)
                                .foregroundColor(Color("BlackMediumEmphasis"))
                            
                            Text(Date.now.monthandDate()!)
                                .font(.dateText)
                        
                        }
                    Spacer()
                    ZStack{
//                        Image("ic-report-list-item-blue-background")
                        
                        HStack{
                            Image(systemName:"plus")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 30)
                                .foregroundColor(Color(.white))
                            //                            .font(.system(size: 8))
                        //TODO: Fix
                            NavigationLink {
                                AddorEditSymptomsLandingPage(loggedIn: $loggedIn, date: Date.now, dateString: Date.now.datetoString()!)
                                
                            } label: {
                                Text("Add Today's Report")
                                    .aspectRatio(contentMode: .fit)
                                    .font(.system(size: 18))
                                    .padding()
                                    .foregroundColor(Color("Primary4tTextOn4"))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.white, lineWidth: 2)
                                    ).background(Color("Primary4")) // If you have this
                                    .cornerRadius(10)         // You also need the cornerRadius here
                            }
                            
                        }
                        
                    }

                    
                }
//                .background(Color(.primary0))
                .padding()
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

