//
//  SuggestedEventsView.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-12-23.
//

import SwiftUI

struct SuggestedEventsView: View {
    @Binding var isSheetVisible: Bool
    @State var readyToNavigate: Bool = false
    @State var readyToCreateNewEvent: Bool = false
    @State private var path = NavigationPath()
    @Binding var loggedIn: Bool
    @State var dateString: String
    @EnvironmentObject var eventsViewModel : EventsViewModel
    @Environment(\.dismiss) var dismiss
    @State var selectedEvents: [EventReport] = []

    var body: some View {
        NavigationStack (path: $path){
            ZStack{
                VStack(alignment: .leading)
                {
                    Text("""
                     Please choose up to 5 events to understand more about your health.
                     """)
                    .foregroundColor(Color(.black))
                    .font(.titleinRowItem)
                    Divider()
                    Text("""
                Select Add a new event to add a new event to the list.
                """)
                    .foregroundColor(Color(.black))
                    .font(.regularText)
                    .padding(.bottom, 8.0)
                    Text("""
                Swipe left on an event to delete it from the list.
                """)
                    .foregroundColor(Color(.black))
                    .font(.regularText)
                    .padding(.bottom, 8.0)
                    
                    Button(action: {
                        readyToCreateNewEvent=true
                    }) {
                        HStack {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.white)
                            Text("Add a new event")
                                .foregroundColor(.white)
                                .font(.titleinRowItem)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding()
                    .background(Color(.primary4))
                    .cornerRadius(10)
                    
                    Divider()
                    
                    Text("Suggested Events")
                    .foregroundColor(Color(.blackMediumEmphasis))
                    .font(.navSmallTitle)
                    .padding(.bottom, 8.0)

                    ScrollView{
                        ForEach(eventsViewModel.suggestedEvents, id: \.self) { item in
                            SuggestedEventRow(item: item, loggedIn: $loggedIn, selectedEvents: $selectedEvents)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .scrollContentBackground(.hidden)
                    
                    Button(action: {
                        eventsViewModel.saveEventReport(events: selectedEvents)
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
                                .font(.titleinRowItem)
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
                .presentationDetents([.fraction(0.8), .large])
            }
            .navigationDestination(isPresented: $readyToNavigate) {
                AddorEditEventsLandingPage(dateString: dateString, loggedIn: $loggedIn)
            }
            .navigationDestination(isPresented: $readyToCreateNewEvent) {
                //create new event
                SetEventView(item: Event(title: "", category: "", creationDateTime: Date.now, lastModifiedDateTime: Date.now, userId: AuthViewModel.getLoggedInUserId(), tracking: false), title: "", loggedIn: $loggedIn, isSheetVisible: isSheetVisible, selection: "Physical Well-Being", dateString: dateString)
            }
        }
        .onAppear()
        {
            eventsViewModel.getSuggestedEvents()
        }
    }
        
}

#Preview {
    let generalViewModel = GeneralViewModel()
    let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
    let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
    let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected
    
    SuggestedEventsView(isSheetVisible:  Binding.constant(true), loggedIn: Binding.constant(true), dateString: Date.now.datetoString()!)
        .environmentObject(generalViewModel)
        .environmentObject(symptomViewModel)
        .environmentObject(eventsViewModel)
        .environmentObject(reportingViewModel)
}
