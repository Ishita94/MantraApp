//
//  AddorEditSymptomNavigationButtonPanel.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-03-04.
//

import SwiftUI

struct AddorEditSymptomNavigationButtonPanel: View {
    @Binding var loggedIn: Bool
    @EnvironmentObject var generalViewModel : GeneralViewModel
    @EnvironmentObject var reportViewModel : ReportingViewModel
    @State var readyToNavigateNext: Bool = false
    @State var readyToNavigateBack: Bool = false
    @State var dateString: String
    @Binding var descriptionText: String

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
                                        
                        reportViewModel.remainingReportbyDate.descriptionCompletionStatus = true
                        reportViewModel.saveRemainingReport(report: reportViewModel.remainingReportbyDate, saveFor: "Symptoms" )
                    
                    
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
            if(generalViewModel.currentState==2){
                AddorEditEventsLandingPage(dateString: dateString, loggedIn: $loggedIn)
                    .environmentObject(generalViewModel)
            }
        }
        //TODO: Decide if back button should be there, ideally back button should take to home pg
//        .navigationDestination(isPresented: $readyToNavigateBack) {
//             if(generalViewModel.currentState==2){
//                AddorEditEventsLandingPage(dateString: dateString, loggedIn: $loggedIn)
//                .environmentObject(generalViewModel)
//            }
//        }
    }
}


#Preview {
    let generalViewModel = GeneralViewModel()
    let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
    let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
    let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected
    
    AddorEditSymptomNavigationButtonPanel(loggedIn: Binding.constant(true), dateString: Date.now.datetoString()!, descriptionText: Binding.constant(""))
        .environmentObject(generalViewModel)
        .environmentObject(symptomViewModel)
        .environmentObject(eventsViewModel)
        .environmentObject(reportingViewModel)
}
