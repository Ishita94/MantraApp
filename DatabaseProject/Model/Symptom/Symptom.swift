//
//  Symptom.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-10-05.
//

import Foundation
struct Symptom: Identifiable {
    
    var id: UUID = UUID()
    var symptomName:String
    var rating:Int
    var recentStatus:String

}
