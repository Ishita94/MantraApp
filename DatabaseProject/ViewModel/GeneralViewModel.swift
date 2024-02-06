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
    @Published var selectedSegment: Int = 0 //for rating slider
    
    
    init() {
        //loadFromPersistentStore()
    }
    func setSelectedSegment (segment: Int){
        selectedSegment = segment
    }
    func incrementState (){
        if(currentState<5) {
            currentState+=1
        }
    }
    func decrementState (){
        if(currentState>1) {
            currentState-=1
        }
    }
}
