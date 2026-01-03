//
//  Reminder.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-10-05.
//

import Foundation
import FirebaseFirestoreSwift
struct Reminder: Identifiable, Hashable, Codable {
    @DocumentID var id: String?
    var title:String
    var startDate: Date
    var endDate: Date
    var userId: String
    var description: String
    var repeatFrequency: String
    var alertTimes: [String] = [] //["08:00", "20:00"] // 8 AM and 8 PM in user's local time
    var alertBefore: String  //["5 min before", "30 min before"...] // will be set for all alert times
    var creationDateTime: Date
    var lastModifiedDateTime: Date
}
