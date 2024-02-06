//
//  BackandNextButtonPanel.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-24.
//

import SwiftUI

struct BackandNextButtonPanel: View {
    @Binding var loggedIn: Bool
    @EnvironmentObject var generalViewModel : GeneralViewModel
    @EnvironmentObject var reportViewModel : ReportingViewModel
    @State var readyToNavigateNext: Bool = false
    @State var readyToNavigateBack: Bool = false
    @State var dateString: String


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
                //TODO: Disable back button and next button in boundary cases
//                .foregroundColor(Color(.disabledBackground))
//                .background(Color(.disabledBackground))
                .overlay( /// apply a rounded border
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color(.primary4), lineWidth: 1)
                )
                
                Spacer()
                
                Button(action: {
                    generalViewModel.incrementState()
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
            .frame(maxWidth: .infinity, maxHeight: 50)
        }
        .navigationDestination(isPresented: $readyToNavigateNext) {
            if(generalViewModel.currentState==2){
                AddorEditEventsLandingPage(dateString: dateString, loggedIn: $loggedIn).environmentObject(generalViewModel)
            }
            else if(generalViewModel.currentState==3){
                DescriptionLandingPage(dateString: dateString, loggedIn: $loggedIn)
                    .environmentObject(generalViewModel)
            }
        }
        .navigationDestination(isPresented: $readyToNavigateBack) {
            if(generalViewModel.currentState==1){
                AddorEditSymptomsLandingPage(loggedIn: $loggedIn, dateString: dateString,
            showAfterCreatingNewSymptomReport: false)
                .environmentObject(generalViewModel)
            }
            else if(generalViewModel.currentState==2){
                AddorEditEventsLandingPage(dateString: dateString, loggedIn: $loggedIn)
                .environmentObject(generalViewModel)
            }
        }
    }
}

#Preview {
    BackandNextButtonPanel(loggedIn: Binding.constant(true), dateString: Date.now.datetoString()!)
        .environmentObject(GeneralViewModel())
        .environmentObject(ReportingViewModel())
}
