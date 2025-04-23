//
//  BackandNextButtonPanelforEmoji.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2024-01-30.
//

import SwiftUI

struct BackandNextButtonPanelforEmoji: View {
    @Binding var loggedIn: Bool
    @EnvironmentObject var generalViewModel : GeneralViewModel
    @EnvironmentObject var reportViewModel : ReportingViewModel
    @State var readyToNavigateNext: Bool = false
    @State var readyToNavigateBack: Bool = false
    @State var dateString: String
    @Binding var emojiStateofDay : String
    @Binding var emojiValue : String
    @State var emojiCompletionStatus: Bool = false
    @State var isSheetVisible: Bool = false
    @State var isReportIncomplete: Bool = false
    
    var body: some View {
        HStack{
            Button(action: {
                generalViewModel.decrementState()
                readyToNavigateBack=true
            }) {
                HStack {
                    Image(systemName: "arrow.left")
                        .foregroundColor(Color(.primary4))
                    Text("Back")
                        .foregroundColor(Color (.primary4))
                    
                }
                .padding()
                
                .overlay( /// apply a rounded border
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color(.primary4), lineWidth: 1)
                )
                
                Spacer()
                
                Button(action: {
                    generalViewModel.incrementState()

//                    reportViewModel.remainingReportbyDate.emojiStateofDay = emojiStateofDay
                    if(!emojiStateofDay.isEmpty){
                        reportViewModel.remainingReportbyDate.emojiStateofDay = emojiStateofDay
                        reportViewModel.remainingReportbyDate.emojiValue = emojiValue
                        reportViewModel.remainingReportbyDate.emojiCompletionStatus = true
                        reportViewModel.remainingReportbyDate.reportCompletionStatus = true
                        reportViewModel.saveRemainingReport(report: reportViewModel.remainingReportbyDate, saveFor: "Emoji")
                        
                        isSheetVisible = true
                    }
                    else
                    {
                        isReportIncomplete = true // there is nothing to set for emoji in this report, and state of day/emoji cannot be selected to nothing
//                        reportViewModel.remainingReportbyDate.emojiStateofDay = ""
//                        reportViewModel.remainingReportbyDate.emojiValue = ""
//                        reportViewModel.remainingReportbyDate.emojiCompletionStatus = false
                    }
                    
                }) {
                    HStack {
                        Image(systemName: "arrow.right")
                            .foregroundColor(.white)
                        Text("Next").foregroundColor(.white)
                    }
                    .background(Color(.primary4))
                }
                .padding()
                .background(Color(.primary4))
                .cornerRadius(10)
            }
            
            //        .padding()
            .frame(maxWidth: .infinity, maxHeight: 50)
        }
        .navigationDestination(isPresented: $isSheetVisible) {
                ReportCompletionView(isSheetVisible: $isSheetVisible, loggedIn: $loggedIn, dateString: dateString)
            
        }
        .navigationDestination(isPresented: $isReportIncomplete) {
            ReportingView(loggedIn: $loggedIn)
        }
        .navigationDestination(isPresented: $readyToNavigateBack) {
                    if(generalViewModel.currentState==4){
                        QuestionsandNotesLandingPage(dateString: dateString, loggedIn: $loggedIn)
                            .environmentObject(generalViewModel)
                    }
                }
        
    }
}

#Preview {
    let generalViewModel = GeneralViewModel()
    let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
    let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
    let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected
    
    BackandNextButtonPanelforEmoji(loggedIn: Binding.constant(true), dateString: Date.now.datetoString()!, emojiStateofDay: Binding.constant(""), emojiValue: Binding.constant(""))
        .environmentObject(generalViewModel)
        .environmentObject(symptomViewModel)
        .environmentObject(eventsViewModel)
        .environmentObject(reportingViewModel)
}
