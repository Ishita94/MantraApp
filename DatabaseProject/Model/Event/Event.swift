//
//  EventReport.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2024-01-21.
//

import Foundation
import FirebaseFirestoreSwift
struct Event: Identifiable, Hashable, Codable {
    
    @DocumentID var id: String?
    var title:String
    var category:String
    var creationDateTime: Date
    var lastModifiedDateTime: Date
    var userId: String
    var eventId: String?
    var tracking:Bool
}
