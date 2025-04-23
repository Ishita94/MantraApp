//
//  Symptom.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-10-05.
//

import Foundation
import FirebaseFirestoreSwift
struct Symptom: Identifiable, Hashable, Codable {
    
    @DocumentID var id: String?
    var symptomName:String
    var rating:Int?
    var status:String
    var creationDateTime: Date
    var lastModifiedDateTime: Date
    var tracking: Bool
    var userId: String
}
