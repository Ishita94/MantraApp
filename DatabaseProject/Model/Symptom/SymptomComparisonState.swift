//
//  SymptomComparisonState.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-11-04.
//

import Foundation
import FirebaseFirestoreSwift
import SwiftUICore
struct SymptomComparisonState: Identifiable, Hashable, Codable {
    @DocumentID var id: String?
    var stateName:String
    var imageName:String
    var color: Color {
            switch stateName {
            case "Much Better": return .muchBetter
            case "Somewhat Better": return .somewhatBetter
            case "No Change":   return .noChange
            case "Somewhat Worse":       return .somewhatWorse
            case "Much Worse":       return .muchWorse
            default:            return .primary0TTextOn0
            }
        }
    var symptomComparisonStateValue: Int {
            switch stateName {
            case "Much Better": return 1
            case "Somewhat Better": return 2
            case "No Change":   return 3
            case "Somewhat Worse":       return 4
            case "Much Worse":       return 5
            default:            return 3 //default to No Change
            }
        }
}

 
