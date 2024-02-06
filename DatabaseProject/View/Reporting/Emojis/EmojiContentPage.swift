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
    @Binding var emojiStateofDay : String?
    @State var selectedEmoji: Emoji? 

    @State var displayEmojiPicker: Bool = false


    var body: some View {
        NavigationStack{
            VStack (){
                
                Text("""
                Please choose the emoji that best represents your day.
                """)
                .foregroundColor(.black)
                .font(.titleinRowItem)
                
                Divider()
                
                EmojiPickerViewCustomized(selectedEmoji: $selectedEmoji, emojiStateofDay: $emojiStateofDay, selectedColor: Color(.primary4), emojiProvider: LimitedEmojiProvider())
                
                                    
                            }
                        }
        }
    
}


#Preview {
    EmojiContentPage(loggedIn: Binding.constant(true), dateString: Date.now.datetoString()!, emojiStateofDay: Binding.constant(""))
}
