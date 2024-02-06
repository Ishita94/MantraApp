//
//  RemainingReport.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2024-01-23.
//

import Foundation
import FirebaseFirestoreSwift

struct RemainingReport: Identifiable, Hashable, Codable {
    
    //    var id: UUID = UUID()
    @DocumentID var id: String?
    var descriptionCompletionStatus:Bool = false
    var questionsandNotesCompletionStatus:Bool = false
    var emojiCompletionStatus:Bool = false
    var description:String
    var questions:String
    var notes:String
    var emojiIconName:String?
    var emojiStateofDay:String?
    var creationDateTime: Date
    var userId: String
}
