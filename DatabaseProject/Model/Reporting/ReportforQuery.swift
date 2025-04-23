//
//  ReportforQuery.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-03-05.
//


import Foundation
import FirebaseFirestoreSwift

struct ReportforQuery: Identifiable, Hashable, Codable {
    
//    var id: UUID = UUID()
    @DocumentID var id: String?

    
    var emojiStateofDay:String = ""
    var emojiValue:String = ""
    //var symptomComparisonState:String
//    var reportCompletionStatus:Bool
    var description:String = ""
    var questions:String = ""
    var notes:String = ""
    var symptomCompletionStatus:Bool = false
    var eventCompletionStatus:Bool = false
    var descriptionCompletionStatus:Bool = false
    var questionsandNotesCompletionStatus:Bool = false
    var emojiCompletionStatus:Bool = false
    
    var creationDateTime: Date
    var lastModifiedDateTime: Date
    var userId: String
    

   // var recentStatus: String
  //  var symptomId: String
}
