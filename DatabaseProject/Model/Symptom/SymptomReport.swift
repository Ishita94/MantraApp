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

    var day:String
    var date:String
    var emojiIconName:String
    var emojiStateofDay:String
    var symptom:Symptom
    var symptomComparisonState:String

}
