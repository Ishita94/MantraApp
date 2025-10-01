//
//  EventReport.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2024-01-21.
//

import Foundation
import FirebaseFirestoreSwift
struct EventReport: Identifiable, Hashable, Codable {
    
    @DocumentID var id: String?
    var title:String
    var category:String?
    var creationDateTime: Date
    var lastModifiedDateTime: Date
    var eventId: String
    var userId: String
//    var pastTenseTitle: String?=nil // Only calculate when needed
//        
//        // Method to calculate and store it
//        mutating func generatePastTenseTitle() {
//            if pastTenseTitle == nil {
//                pastTenseTitle = PastTenseConverter.convertToPast(title.lowercased())
//            }
//        }
//    var reportCompletionStatus:Bool
    
//    static func == (lhs: EventReport, rhs: EventReport) -> Bool {
//            return lhs.title == rhs.title
//        }
}
