//
//  RemindersLandingPage.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-09-24.
//

import SwiftUI

struct RemindersLandingPage: View {
    @EnvironmentObject var reminderViewModel : ReminderViewModel
//    @EnvironmentObject var generalViewModel : GeneralViewModel
    @Binding var loggedIn: Bool
    @State var readytoNavigate: Bool = false

    var body: some View {
            VStack (alignment: .leading){
                NavBar(loggedIn: $loggedIn, titleText: "Reminders", subtitleText: "")
                
                Divider()
                
                Text("Current Reminders" )
                    .font(.sectionTitleinSymptomsPage)
                    .foregroundColor(Color(.blackMediumEmphasis))
                    .padding(16)
                
                if reminderViewModel.isLoading {
                    ProgressView("Loading...")  // Show loading indicator
                        .progressViewStyle(CircularProgressViewStyle(tint: .primary4))  // Change color
                        .scaleEffect(1.25)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                else if (reminderViewModel.reminders.count>0)
                {
                    ScrollView{
                        ForEach(reminderViewModel.reminders, id: \.self) { reminder in
                            ReminderListRow(item: reminder, loggedIn: $loggedIn)
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
                else
                {
                    DisabledStateButtonwithTitle(title: "You have not set any reminders yet.")
                }
                
                Spacer()
                
                Divider()
                    .padding(.bottom, 20)
                
                Button(action: {
                    readytoNavigate = true
                }) {
                    HStack (alignment: .center, spacing: 12){
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.white)
                        Text("Add a new reminder")
                            .foregroundColor(.white)
                            .font(.tabTitleinSummariesPage)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Color(.primary4))
                    .cornerRadius(10)
                }
            }
            .task {
                await reminderViewModel.getAllReminders()
            }
            .padding()
            
            .navigationDestination(isPresented: $readytoNavigate)
            {
                AddorEditReminderPage(item: Reminder(title: "", startDate: Date(), endDate: Date(), userId: "", description: "", repeatFrequency: "Daily", alertBefore: "5 minutes before", creationDateTime: Date(), lastModifiedDateTime: Date()), loggedIn: $loggedIn, times: "")
            }
        }
        
}


#Preview {
    RemindersLandingPage(loggedIn: Binding.constant(true))
}
