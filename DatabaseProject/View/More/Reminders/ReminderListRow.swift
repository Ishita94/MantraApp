//
//  ReminderListRow.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-10-05.
//

import SwiftUI

struct ReminderListRow: View {
    var item: Reminder
    @Binding var loggedIn: Bool
    @State var readyToNavigate: Bool = false
    @EnvironmentObject var generalViewModel : GeneralViewModel
    
    var body: some View {
            ZStack{
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.primary0))
                    .frame(maxWidth: .infinity, minHeight: 100)
                HStack{
                    VStack(alignment: .leading, spacing: 12){
                        Text(item.title )
                            .font(.buttonText)
                            .foregroundColor(Color(.primary0TTextOn0))
                        
                        ForEach(item.alertTimes, id:\.self) { time in
                            VStack(alignment: .leading, spacing: 7){
                                Text("\(item.repeatFrequency) at \(time) ") //TODO: need to show AM/PM
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 4)
                                    .background(Color(.secondary2))
                                    .foregroundStyle(Color(.white))
                                    .font(.textBoxContent)
                                    .cornerRadius(6)
                                    .frame(minHeight: 20)
                            }
                        }
                    }
                   
                        Spacer()
                        
                        Button(action: {
                            readyToNavigate = true
                        }) {
                            Image("ic-edit")
                        }
                    }
                .padding(.horizontal, 26)
                .padding(.vertical, 13)
                .navigationDestination(isPresented: $readyToNavigate) {
                    AddorEditReminderPage(item: item, loggedIn: $loggedIn, times: "")
                }
                
            }
        }
}

#Preview {
    ReminderListRow(item: Reminder(title: "", startDate: Date(), endDate: Date(), userId: "", description: "", repeatFrequency: "Daily", alertBefore: "5 minutes before", creationDateTime: Date(), lastModifiedDateTime: Date()), loggedIn: Binding.constant(true)).environmentObject(GeneralViewModel())
}
