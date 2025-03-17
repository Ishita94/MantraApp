//
//  EmojiPickerViewCustomized.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2024-01-30.
//

import SwiftUI
import EmojiPicker

public struct EmojiPickerViewCustomized: View {

    @Environment(\.dismiss)
    var dismiss

    @State public var selectedEmoji: Emoji = Emoji(value: "", name: "")
    @Binding public var emojiStateofDay : String
    @Binding public var emojiValue : String

    @State
    private var search: String = ""

    private var selectedColor: Color
    private var searchEnabled: Bool

    public init(emojiStateofDay: Binding<String> , emojiValue: Binding<String> , searchEnabled: Bool = false, selectedColor: Color = .blue, emojiProvider: EmojiProvider = DefaultEmojiProvider()) {
        self.selectedColor = selectedColor
        self.searchEnabled = searchEnabled
        self.emojis = emojiProvider.getAll()
        self._emojiStateofDay = emojiStateofDay
        self._emojiValue = emojiValue
    }

    let columns = [
        GridItem(.adaptive(minimum: 80))
    ]

    let emojis: [Emoji]

    private var searchResults: [Emoji] {
        if search.isEmpty {
            return emojis
        } else {
            return emojis
                .filter { $0.name.lowercased().contains(search.lowercased()) }
        }
    }

    public var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(searchResults, id: \.self) { emoji in
                    VStack{
                        RoundedRectangle(cornerRadius: 16)
                            .fill((selectedEmoji == emoji ? selectedColor : Color.white).opacity(1.0))
                            .frame(width: 64, height: 64)
                            .overlay {
                                Text(emoji.value)
                                    .font(.largeTitle)
                            }
                            .onTapGesture {
                                selectedEmoji = emoji
                                emojiStateofDay = emoji.name
                                emojiValue = emoji.value
                            }
                        Text(emoji.name)
                            .font(.smallRegularText)
                    }
                    .onAppear {
                        if !$emojiStateofDay.wrappedValue.isEmpty{
                            self.selectedEmoji = self.emojis
                                .filter { $0.name.lowercased().contains($emojiStateofDay.wrappedValue.lowercased()) }.first ?? Emoji(value: "", name: "")
                        }
                    }
                }
            }
            //.padding(.horizontal)
        }
        .frame(maxHeight: .infinity)
//        .searchable(text: $search)
    }

}

struct EmojiPickerViewCustomized_Previews: PreviewProvider {
    static var previews: some View {
        EmojiPickerViewCustomized(emojiStateofDay: Binding.constant(""), emojiValue: Binding.constant(""))
    }
}
