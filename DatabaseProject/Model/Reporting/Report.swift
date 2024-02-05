//
//  Report.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-11-05.
//

import Foundation
import FirebaseFirestoreSwift

struct Report: Identifiable, Hashable, Codable {
    
//    var id: UUID = UUID()
    @DocumentID var id: String?

    var dayNameofWeek:String
    var monthNameofWeek:String
//    var date:Date
    var dateString:String
    //var rating:Int
    var emojiIconName:String?
    var emojiStateofDay:String
    var symptomNames:String
    //var symptomComparisonState:String
    var reportCompletionStatus:Bool
    var description:String?
    var questions:String?
    var notes:String?
    var reportCompletionStatus:Bool
    var reportCompletionStatus:Bool
    var reportCompletionStatus:Bool

   // var recentStatus: String
  //  var symptomId: String
}
