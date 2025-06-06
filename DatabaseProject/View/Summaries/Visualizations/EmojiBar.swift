//
//  EmojiBar.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-05-13.
//

import SwiftUI
import EmojiPicker

struct EmojiBar: View {
    @EnvironmentObject var summariesViewModel : SummariesViewModel
    var selectedWeekDays: [CustomDateModel]
    var body: some View {
        GeometryReader { geo in
            let spacing: CGFloat = 0
            let itemWidth = (geo.size.width - spacing * 6) / 7

            HStack (spacing: spacing){
                ForEach(selectedWeekDays.indices, id: \.self){index in
                    let item = selectedWeekDays[index]
                    let emoji = summariesViewModel.dictionaryofEmoji[item.dateString] ?? Emoji(value: "", name: "")
                    EmojiBarItem(emoji: emoji, isFirst: index == 0, isLast: index == selectedWeekDays.count - 1)
                        .frame(width: itemWidth, height: 64)
                }
            }
        }
        .frame(height: 64)
    }
}

#Preview {
    EmojiBar(selectedWeekDays: [])
}
