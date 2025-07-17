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

    @EnvironmentObject var eventViewModel : EventsViewModel
    @Environment(\.dismiss) var dismiss
    let categories = ["Physical Well-Being", "Emotional Well-Being", "Miscellaneous"]
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack (alignment: .leading){
                    Divider()
                        .padding(.bottom, 19.0)
                    
                    if item.id==nil{//create new event
                        Text("New Event Report")
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color(.primary4))
                            .foregroundStyle(Color(.white))
                            .font(.smallTitle)
                            .cornerRadius(6)
                            .frame(maxHeight: 16)
                            .padding(.bottom, 16.0)
                    }
                    
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
                    
                    Menu {
                        ForEach(categories, id: \.self) { category in
                            Button(category) {
                                selection = category
                            }
                        }
                    } label: {
                        HStack {
                            Text(selection)
                                .foregroundColor(.black)

                            Spacer()

                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                        }
                        .padding()
                        .frame(maxWidth: .infinity, minHeight: 56)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color(.outlineGrey), lineWidth: 1)
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Divider()
                    
                    Button(action: {
                        eventViewModel.saveEvent(event: Event(id: item.id, title: title, category: selection, creationDateTime: item.creationDateTime, lastModifiedDateTime: Date.now, userId: AuthViewModel.getLoggedInUserId(), eventId: item.eventId, tracking: false))
                        
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
                if let id = item.id{//edit
                    AddorEditEventsLandingPage(dateString: dateString, loggedIn: $loggedIn)
                }
                else
                {
                    SuggestedEventsView(isSheetVisible: $isSheetVisible, loggedIn: $loggedIn, dateString: dateString, creationDateTime: item.creationDateTime)
                }
            }
            .presentationDetents([.fraction(0.6), .large])
        }
    }
}

#Preview {
    let generalViewModel = GeneralViewModel()
    let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
    let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
    let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected
    
    SetEventView(item: Event(title: "Went on a walk", category: "Physical Well-Being", creationDateTime: Date.now, lastModifiedDateTime: Date.now, userId: "", tracking: false), title: "Went on a walk", loggedIn: Binding.constant(true), isSheetVisible: true, selection: "Physical Well-Being", dateString: Date.now.datetoString()!)
        .environmentObject(generalViewModel)
        .environmentObject(symptomViewModel)
        .environmentObject(eventsViewModel)
        .environmentObject(reportingViewModel)
}
