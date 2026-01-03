//
//  AddorEditReminderPage.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-10-05.
//

import SwiftUI

func formatTimesList(_ times: [String]) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm"
    
    let displayFormatter = DateFormatter()
    displayFormatter.timeStyle = .short
    
    let formattedTimes = times.compactMap { timeString -> String? in
        guard let date = formatter.date(from: timeString) else { return nil }
        return displayFormatter.string(from: date)
    }
    
    return formattedTimes.joined(separator: ", ")
}

struct AddorEditReminderPage: View {
    @State var item: Reminder
    @Binding var loggedIn: Bool
    @State var readyToNavigate: Bool = false
    @State var times: String
    @State var isSheetVisible: Bool = false

    @Environment(\.dismiss) var dismiss

//    @State var repeatFrequency: String
//    @State var alertTimes: [String] = [] //["08:00", "20:00"] // 8 AM and 8 PM in user's local time
//    @State var alertBefore: String  //["08:00", "20:00"] // 8 AM and 8 PM in user's local time

    var body: some View {
        VStack (alignment: .leading){
            NavBar(loggedIn: $loggedIn, titleText: item.id != nil ? "Edit reminder" : "Add a new reminder", subtitleText: "") 

            Divider()
            
            ScrollView{
                VStack (alignment: .leading){
                    Text("Title")
                        .foregroundColor(Color(.blackMediumEmphasis))
                        .font(.textBoxContent)
                        .padding(.bottom, 8.0)
                    
                    TextEditor(text: $item.title)
                        .padding(8)
                        .background(Color.clear)
                        .foregroundColor(Color(.blackMediumEmphasis))
                        .font(.textBoxContent)
                        .overlay( /// apply a rounded border
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color(.outlineDarker), lineWidth: 1)
                        )
                        .frame(height: 56)
                    
                    Divider()
                        .padding(.top, 16.0)

                    
                    Text("Starts")
                        .foregroundColor(Color(.blackMediumEmphasis))
                        .font(.textBoxContent)
                        .padding(.bottom, 8.0)
                    
                    HStack {
                        DatePicker("", selection: $item.startDate, displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .labelsHidden()
                        
                        Spacer()
                        
                        Image("ic-datepicker")
                    }
                    .padding(8)
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(Color(.outlineDarker), lineWidth: 1)
                    )
                    .frame(height: 56)
                    
                    Text("Ends")
                        .foregroundColor(Color(.blackMediumEmphasis))
                        .font(.textBoxContent)
                        .padding(.bottom, 8.0)
                    
                    HStack {
                        DatePicker("", selection: $item.endDate, displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .labelsHidden()
                        
                        Spacer()
                        
                        Image("ic-datepicker")
                    }
                    .padding(8)
                    .background(Color.clear)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(Color(.outlineDarker), lineWidth: 1)
                    )
                    .frame(height: 56)
                    
                    Divider()
                        .padding(.top, 16.0)
                    
                    Text("Time")
                        .foregroundColor(Color(.blackMediumEmphasis))
                        .font(.textBoxContent)
                        .padding(.bottom, 8.0)
                    
                    Button(action: {
                        isSheetVisible = true
                    }) {
                        HStack {
                            if item.alertTimes.isEmpty {
                                Text("Select times")
                                    .foregroundColor(Color(.systemGray))
                            } else {
                                Text(formatTimesList(item.alertTimes))
                                    .foregroundColor(Color(.blackMediumEmphasis))
                            }
                            
                            Spacer()
                            
                            Image(systemName: "clock")
                                .foregroundColor(Color(.primary4))
                        }
                        .padding(12)
                        .background(Color.clear)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color(.outlineDarker), lineWidth: 1)
                        )
                        .frame(height: 56)
                    }
                    .sheet(isPresented: $isSheetVisible) {
//                        TimeSelectionSheet(alertTimes: $item.alertTimes)
                    }
                    
                    Text("Time")
                        .foregroundColor(Color(.blackMediumEmphasis))
                        .font(.textBoxContent)
                        .padding(.bottom, 8.0)
                    
                    TextEditor(text: $times)
                        .padding(8)
                        .background(Color.clear)
                        .foregroundColor(Color(.blackMediumEmphasis))
                        .font(.textBoxContent)
                        .overlay( /// apply a rounded border
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color(.outlineDarker), lineWidth: 1)
                        )
                        .frame(height: 56)
                    
                    Divider()
                        .padding(.top, 16.0)
                    
                    Text("Repeat")
                        .foregroundColor(Color(.blackMediumEmphasis))
                        .font(.textBoxContent)
                        .padding(.bottom, 8.0)
                    
                    TextEditor(text: $item.repeatFrequency)
                        .padding(8)
                        .background(Color.clear)
                        .foregroundColor(Color(.blackMediumEmphasis))
                        .font(.textBoxContent)
                        .overlay( /// apply a rounded border
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color(.outlineDarker), lineWidth: 1)
                        )
                        .frame(height: 56)
                    
                    Divider()
                        .padding(.top, 16.0)
                    
                    Text("Alert")
                        .foregroundColor(Color(.blackMediumEmphasis))
                        .font(.textBoxContent)
                        .padding(.bottom, 8.0)
                    
                    TextEditor(text: $item.alertBefore)
                        .padding(8)
                        .background(Color.clear)
                        .foregroundColor(Color(.blackMediumEmphasis))
                        .font(.textBoxContent)
                        .overlay( /// apply a rounded border
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color(.outlineDarker), lineWidth: 1)
                        )
                        .frame(height: 56)
                    
                    Divider()
                        .padding(.top, 16.0)
                    
                    Text("Description")
                        .foregroundColor(Color(.blackMediumEmphasis))
                        .font(.textBoxContent)
                        .padding(.bottom, 8.0)
                    
                    TextEditor(text: $item.description)
                        .padding(8)
                        .background(Color.clear)
                        .foregroundColor(Color(.blackMediumEmphasis))
                        .font(.textBoxContent)
                        .overlay( /// apply a rounded border
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color(.outlineDarker), lineWidth: 1)
                        )
                        .frame(height: 56)
                }
            }
                
                
                Divider()
                .padding(.vertical, 16.0)
                
                VStack (alignment: .leading){
                    Button(action: {
                        dismiss()
                        
                    }) {
                        HStack {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.white)
                            Text("Save Reminder")
                                .foregroundColor(.white)
                                .font(.titleinRowItem)
                        }
                        .frame(maxWidth: .infinity)
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
                        }
                        .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .overlay( /// apply a rounded border
                        RoundedRectangle(cornerRadius: 10)
                            .strokeBorder(Color(.outlineGrey), lineWidth: 1)
                    )
                }
            
        }
        .padding()
        .navigationTitle("")  // ← Add empty title (since you use custom NavBar)
           .navigationBarTitleDisplayMode(.inline)  // ← This ensures proper navigation behavior
       
    }
}

#Preview {
    AddorEditReminderPage(item: Reminder(title: "", startDate: Date(), endDate: Date(), userId: "", description: "", repeatFrequency: "Daily", alertBefore: "5 minutes before", creationDateTime: Date(), lastModifiedDateTime: Date()), loggedIn: Binding.constant(true), times: "")
}
