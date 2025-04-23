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
    @State private var descriptionText: String
    @FocusState private var isTextEditorFocused: Bool  // Track focus state
    
    init(loggedIn: Binding<Bool>, dateString: String, report: Report) {
        _loggedIn = loggedIn
        _dateString = State(initialValue: dateString)
        _descriptionText = State(initialValue:  report.description)
        }
    
    @available(iOS 15.0, *)
    var body: some View {
        NavigationStack{
                VStack (){
                    Text("""
                How do you feel today? Please briefly write about your day.
                """)
                    .foregroundColor(.black)
                    .font(.titleinRowItem)
                    
                    ZStack (alignment: .leading){
                        
                        if $descriptionText.wrappedValue.isEmpty && !isTextEditorFocused {
                            Text("2500 characters remaining")
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .foregroundStyle(.secondary)
                                .font(.regularText)
                                .lineSpacing(10)
                                .autocapitalization(.words)
                                .disableAutocorrection(true)
                                .padding()
                        }
                        
                                    // Editable TextEditor
                          TextEditor(text: $descriptionText)
                            .focused($isTextEditorFocused)  // Attach focus state
                            .textFieldStyle(RoundedBorderTextFieldStyle())
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
            Divider()
            BackandNextButtonPanelforDescription(loggedIn: $loggedIn, dateString: dateString, descriptionText: $descriptionText)
            }
        
        }
}


#Preview {
    let generalViewModel = GeneralViewModel()
    let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
    let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
    let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected

        DescriptionContentPage(loggedIn: Binding.constant(true), dateString: Date.now.datetoString()!, report: Report())
        .environmentObject(generalViewModel)
        .environmentObject(symptomViewModel)
        .environmentObject(eventsViewModel)
        .environmentObject(reportingViewModel)
}
