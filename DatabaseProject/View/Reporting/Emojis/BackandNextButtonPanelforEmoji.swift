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
    @Binding var emojiStateofDay : String?
    @State var isSheetVisible: Bool = false

    
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

                    reportViewModel.remainingReportbyDate.emojiStateofDay = emojiStateofDay
                    if(emojiStateofDay != nil){
                        reportViewModel.remainingReportbyDate.emojiCompletionStatus = true
                    }
                    else
                    {
                        reportViewModel.remainingReportbyDate.emojiCompletionStatus = false
                    }
                    reportViewModel.saveRemainingReport(report: reportViewModel.remainingReportbyDate, saveFor: "Emoji")
                    
                    isSheetVisible = true
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
//        .sheet(isPresented: $isSheetVisible){
                ReportCompletionView(isSheetVisible: $isSheetVisible, loggedIn: $loggedIn, dateString: dateString)
            
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
    BackandNextButtonPanelforEmoji(loggedIn: Binding.constant(true), dateString: Date.now.datetoString()!, emojiStateofDay: Binding.constant(""))
        .environmentObject(GeneralViewModel())
        .environmentObject(ReportingViewModel())
}
