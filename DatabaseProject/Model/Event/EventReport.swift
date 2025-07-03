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
//    var reportCompletionStatus:Bool
}
