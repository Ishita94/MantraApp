//
//  LimitedEmojiProvider.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2024-01-30.
//

import Foundation
import EmojiPicker

final class LimitedEmojiProvider: EmojiProvider {

    func getAll() -> [Emoji] {
        return [
            Emoji(value: "🙂", name: "Content"),
            Emoji(value: "🤔", name: "Confused"),
            Emoji(value: "😮", name: "Surprised"),
            Emoji(value: "😐", name: "Neutral"),
            Emoji(value: "😄", name: "Happy"),
            Emoji(value: "🎢", name: "Rollercoaster"),
            Emoji(value: "🥱", name: "Tired"),
            Emoji(value: "😨", name: "Scared"),
            Emoji(value: "😜", name: "Silly"),
            Emoji(value: "😠", name: "Angry"),
            Emoji(value: "🫤", name: "Disappointed"),
            Emoji(value: "☹️", name: "Sad"),
            Emoji(value: "😤", name: "Frustrated"),
            Emoji(value: "😴", name: "Sleepy"),
            Emoji(value: "😰", name: "Anxious"),
            Emoji(value: "😣", name: "In Pain")
        ]
    }

}
