//
//  MainController.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-10-21.
//

import Foundation
import Combine
class GeneralViewModel: ObservableObject {
    
    @Published var currentState: Int = 1;
    @Published var selectedSegment: Int = 0
    
    
    init() {
        //loadFromPersistentStore()
    }
}
