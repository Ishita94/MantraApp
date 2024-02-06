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

    @Binding
    public var selectedEmoji: Emoji?
    @Binding public var emojiStateofDay : String?

    @State
    private var search: String = ""

    private var selectedColor: Color
    private var searchEnabled: Bool

    public init(selectedEmoji: Binding<Emoji?>, emojiStateofDay: Binding<String?> , searchEnabled: Bool = false, selectedColor: Color = .blue, emojiProvider: EmojiProvider = DefaultEmojiProvider()) {
        self._selectedEmoji = selectedEmoji
        self.selectedColor = selectedColor
        self.searchEnabled = searchEnabled
        self.emojis = emojiProvider.getAll()
        self._emojiStateofDay = emojiStateofDay
        //TODO: Need to change selectedEmoji if emojiStateofDay!=nil
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
                            }
                        Text(emoji.name)
                            .font(.smallRegularText)
                    }
                }
            }
            //.padding(.horizontal)
        }
        .frame(maxHeight: .infinity)
        .searchable(text: $search)
    }

}

struct EmojiPickerViewCustomized_Previews: PreviewProvider {
    static var previews: some View {
        EmojiPickerViewCustomized(selectedEmoji: .constant(Emoji(value: "", name: "")), emojiStateofDay: Binding.constant(""))
    }
}
