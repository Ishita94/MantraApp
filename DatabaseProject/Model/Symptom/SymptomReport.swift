//
//  ReportListItem.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-10-28.
//

import Foundation
import FirebaseFirestoreSwift

struct SymptomReport: Identifiable, Hashable, Codable {
    
//    var id: UUID = UUID()
    @DocumentID var id: String?

    var dateFormatted:String?
    var dateString:String?
    var creationDateTime: Date
    var lastModifiedDateTime: Date
    var rating:Int
    var emojiIconName:String?
    //var emojiStateofDay:String
    var symptomName:String
    var symptomComparisonState:String
    var reportCompletionStatus:Bool
    var recentStatus: String
    var symptomId: String?
    var userId: String
}
