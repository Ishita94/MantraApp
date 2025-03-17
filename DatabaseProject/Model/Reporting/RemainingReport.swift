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
    var symptomCompletionStatus:Bool = false
    var eventCompletionStatus:Bool = false
    var descriptionCompletionStatus:Bool = false
    var questionsandNotesCompletionStatus:Bool = false
    var emojiCompletionStatus:Bool = false
    var description:String
    var questions:String
    var notes:String
    var emojiValue:String?
    var emojiStateofDay:String?
    var creationDateTime: Date
    var userId: String
    var dayNameofWeek:String
    var monthNameofWeek:String
//    var date:Date
    var dateString:String
    //var rating:Int
    var symptomNames:String
    //var symptomComparisonState:String
    var reportCompletionStatus:Bool
    var symptomReports: [SymptomReport] = []
}
