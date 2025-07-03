//
//  EmojiBarItem.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-05-13.
//

import SwiftUI
import EmojiPicker

struct EmojiBarItem: View {
    var emoji: Emoji = Emoji(value: "", name: "")
    var isFirst: Bool = false
    var isLast: Bool = false
    var body: some View {
            VStack (alignment: .center, spacing: 0){
                Text(emoji.value)
                    .font(.editReportNavBarTitle)
                    Text(emoji.name)
                        .font(.emojiTitleinVisualization)
                        .foregroundColor(.black)
                        .lineLimit(2)
                            .allowsTightening(true)
                            .multilineTextAlignment(.center)
                            .padding(.top, (emoji.name.count > 7) ? -2 : 0) // only shift up if wrapping is likely
                            .padding(.horizontal, 1)
                            .frame(maxHeight: (emoji.name.count > 7) ? 32 : 24)

                // enables wrapping
//                        .lineLimit(nil)
//                        .multilineTextAlignment(.center)
//                        .fixedSize(horizontal: false, vertical: true)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .customBorderOverlay(isFirst: isFirst, isLast: isLast)
    }
}

#Preview {
    EmojiBarItem()
}
