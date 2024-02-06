//
//  BackandNextButtonPanelforQuestionsandNotes.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2024-01-30.
//

import SwiftUI

struct BackandNextButtonPanelforQuestionsandNotes: View {
        @Binding var loggedIn: Bool
        @EnvironmentObject var generalViewModel : GeneralViewModel
        @EnvironmentObject var reportViewModel : ReportingViewModel
        @State var readyToNavigateNext: Bool = false
        @State var readyToNavigateBack: Bool = false
        @State var dateString: String
        @Binding var questionsText: String
        @Binding var notesText: String

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
                        
                        reportViewModel.remainingReportbyDate.questions = questionsText
                        reportViewModel.remainingReportbyDate.notes = notesText
                        reportViewModel.remainingReportbyDate.questionsandNotesCompletionStatus = true
                            reportViewModel.saveRemainingReport(report: reportViewModel.remainingReportbyDate, saveFor: "QuestionsandNotes" )
                        
                        
                        readyToNavigateNext = true
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
            .navigationDestination(isPresented: $readyToNavigateNext) {
                if(generalViewModel.currentState==5){
                    EmojiLandingPage(dateString: dateString, loggedIn: $loggedIn)
                        .environmentObject(generalViewModel)
                }
            }
            .navigationDestination(isPresented: $readyToNavigateBack) {
                if(generalViewModel.currentState==3){
                    DescriptionLandingPage(dateString: dateString, loggedIn: $loggedIn)
                        .environmentObject(generalViewModel)
                }
            }
        }
    }

#Preview {
    BackandNextButtonPanelforQuestionsandNotes(loggedIn: Binding.constant(true), dateString: Date.now.datetoString()!, questionsText: Binding.constant(""), notesText: Binding.constant("") )
        .environmentObject(GeneralViewModel())
        .environmentObject(ReportingViewModel())
}
