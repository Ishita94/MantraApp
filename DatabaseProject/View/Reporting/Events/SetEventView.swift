//
//  SetEventView.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-12-23.
//

import SwiftUI

struct SetEventView: View {
    @State var item: Event
    @State var title: String
    @Binding var loggedIn: Bool
    @State var isSheetVisible: Bool
    @State var selection: String
    @State var readyToNavigate: Bool = false
    @State var dateString: String
    @State var eventReportItem: EventReport?

    @EnvironmentObject var eventViewModel : EventsViewModel
    @Environment(\.dismiss) var dismiss
    let categories = ["Physical Well-Being", "Emotional Well-Being", "Miscellaneous"]
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack (alignment: .leading){
                    Text("New Event Report")
                        .foregroundColor(.white)
                        .background(Color(.primary4))
                        .font(.smallTitle)
                        .cornerRadius(6)
                        .padding(.bottom, 16.0)
                    
                    Text("Title")
                        .foregroundColor(Color(.blackMediumEmphasis))
                        .font(.regularText)
                        .padding(.bottom, 11.0)
                    
                    TextEditor(text: $title)
                        .padding(4)
                        .background(Color.clear)
                        .foregroundColor(Color(.blackMediumEmphasis))
                        .font(.titleinRowItemEditable)
                        .overlay( /// apply a rounded border
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color(.outlineGrey), lineWidth: 1)
                        )
                        .frame(height: 56)
                    //                            }
                    //                            .frame(height: 100)
                    Text("Category")
                        .foregroundColor(Color(.blackMediumEmphasis))
                        .font(.regularText)
                        .padding(.bottom, 11.0)
                    
                    Picker("Select a category", selection: $selection) {
                        ForEach(categories, id: \.self) {
                            Text($0)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: 56, alignment: .leading)
                    .font(.bigTitle)
                    .accentColor(Color(.blackMediumEmphasis))
                    .pickerStyle(.menu)
                    .padding(4)
                    .overlay( /// apply a rounded border
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(Color(.outlineGrey), lineWidth: 1)
                    )
                    
                    Divider()
                    
                    Button(action: {
                        eventViewModel.saveEvent(event: Event(title: title, category: selection, creationDateTime: Date.now, userId: "", tracking: false), eventReport: eventReportItem)
                        
                        readyToNavigate = true
                    }) {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.white)
                            Text("Confirm")
                                .foregroundColor(.white)
                                .font(.smallTitle)
                                .frame(maxWidth: .infinity)
                        }
                        .padding()
                        .background(Color(.primary4))
                        .cornerRadius(10)
                    }
                    
                    Button(action: {
                        dismiss()
                    }) {
                        HStack {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(Color(.warning2))
                            Text("Cancel")
                                .foregroundColor(Color(.warning2))
                                .font(.smallTitle)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding()
                    .overlay( /// apply a rounded border
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(Color(.outlineGrey), lineWidth: 1)
                    )
                }
                .padding()
                .cornerRadius(30)
                
                
            }
            .navigationDestination(isPresented: $readyToNavigate) {
                if let eventReport = eventReportItem {//edit
                    if let id = eventReport.id{
                        AddorEditEventsLandingPage(dateString: dateString, loggedIn: $loggedIn)
                    }
                }
                else
                {
                    SuggestedEventsView(isSheetVisible: $isSheetVisible, loggedIn: $loggedIn, dateString: dateString)
                }
            }
            .presentationDetents([.fraction(0.5), .large])
        }
    }
}

#Preview {
    let generalViewModel = GeneralViewModel()
    let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
    let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
    let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected
    
    SetEventView(item: Event(title: "Went on a walk", category: "Physical Well-Being", creationDateTime: Date.now, userId: "", tracking: false), title: "Went on a walk", loggedIn: Binding.constant(true), isSheetVisible: true, selection: "Physical Well-Being", dateString: Date.now.datetoString()!)
        .environmentObject(generalViewModel)
        .environmentObject(symptomViewModel)
        .environmentObject(eventsViewModel)
        .environmentObject(reportingViewModel)
}
