//
//  SymptomComparisonState.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-11-04.
//

import Foundation
import FirebaseFirestoreSwift
struct SymptomComparisonState: Identifiable, Hashable, Codable {
    
    @DocumentID var id: String?
    var stateName:String
    var imageName:String
}
