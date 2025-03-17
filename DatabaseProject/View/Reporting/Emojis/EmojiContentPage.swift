//
//  EmojiContentPage.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2024-01-23.
//

import SwiftUI
import EmojiPicker

struct EmojiContentPage: View {
    @Binding var loggedIn: Bool
    @State var dateString: String
    @EnvironmentObject var reportingViewModel : ReportingViewModel

//    @State var readyToNavigate: Bool = false
//    @Binding var emojiStateofDay : String
//    @Binding var emojiValue : String
//    @State var selectedReport : Report

    @State  private var emojiStateofDay : String
    @State private var emojiValue : String
    @State var selectedEmoji: Emoji?

    @State var displayEmojiPicker: Bool = false

    init(loggedIn: Binding<Bool>, dateString: String, report: Report) {
        _loggedIn = loggedIn
        _dateString = State(initialValue: dateString)
        _emojiStateofDay = State(initialValue:  report.emojiStateofDay)
        _emojiValue = State(initialValue: report.emojiValue)  
        }
    
    var body: some View {
        NavigationStack{
            VStack (){
                
                Text("""
                Please choose the emoji that best represents your day.
                """)
                .foregroundColor(.black)
                .font(.titleinRowItem)
                
                Divider()
                
                EmojiPickerViewCustomized(emojiStateofDay: $emojiStateofDay, emojiValue: $emojiValue, selectedColor: Color(.primary4), emojiProvider: LimitedEmojiProvider())
                
                Divider()

                BackandNextButtonPanelforEmoji(loggedIn: $loggedIn, dateString: dateString, emojiStateofDay: $emojiStateofDay, emojiValue: $emojiValue)
                                    
                            }
                        }
        }
    
}


#Preview {
    EmojiContentPage(loggedIn: Binding.constant(true), dateString: Date.now.datetoString()!, report: Report())
}
