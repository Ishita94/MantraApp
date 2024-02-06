//
//  DescriptionContentPage.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2024-01-23.
//

import SwiftUI

struct DescriptionContentPage: View {
    @Binding var loggedIn: Bool
    @State var dateString: String
    @EnvironmentObject var reportingViewModel : ReportingViewModel
//    @State var readyToNavigate: Bool = false
    @Binding var descriptionText: String

    var body: some View {
        NavigationStack{
                VStack (){
                    Text("""
                How do you feel today? Please briefly write about your day.
                """)
                    .foregroundColor(.black)
                    .font(.titleinRowItem)
                    
                    VStack{
                        TextEditor(text: $descriptionText)
                            .foregroundStyle(.secondary)
                            .font(.regularText)
                            .lineSpacing(10)
                            .autocapitalization(.words)
                            .disableAutocorrection(true)
                            .padding()
                            
                    }
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color(.outlineDarker), lineWidth: 1)
                    )
                    
                    
                    
                    //                    .foregroundColor(Color(.blackMediumEmphasis))
                    //                    .font(.regularText)
                    //                    .multilineTextAlignment(.center)
                    //                    .frame(maxWidth: 275)
                    //                    .padding(.bottom, 23)
                    
                    //                Button(action: {
                    //                    readyToNavigate = true
                    //                }) {
                    //                    HStack {
                    //                        Image(systemName: "plus.circle.fill")
                    //                            .foregroundColor(.white)
                    //                        Text("Add or edit list of events")
                    //                            .foregroundColor(.white)
                    //                            .font(.titleinRowItem)
                    ////                            .frame(maxWidth: .infinity)
                    //                    }
                    //                }
                    //                .padding()
                    //                .buttonStyle(PlainButtonStyle())
                    //                .background(Color(.primary4))
                    //                .cornerRadius(10)
                }
                
                //            .navigationDestination(isPresented: $readyToNavigate) {
                ////                SuggestedEventsView(isSheetVisible: $isSheetVisible, loggedIn: $loggedIn, dateString: dateString)
                //
                //            }
            }
        }
    
}


#Preview {
    DescriptionContentPage(loggedIn: Binding.constant(true), dateString: Date.now.datetoString()!, descriptionText: Binding.constant(""))
        .environmentObject(SymptomViewModel())
            .environmentObject(GeneralViewModel())
            .environmentObject(EventsViewModel())
            .environmentObject(ReportingViewModel())
}
