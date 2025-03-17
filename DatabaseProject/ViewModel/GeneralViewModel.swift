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
    @Published var currentTitle: String = "Report your symptoms";
    @Published var dateStringofCurrentReport: String = "";
    @Published var selectedReport = Report()

    init() {
        //loadFromPersistentStore()
    }
    func setSelectedSegment (segment: Int){
        selectedSegment = segment
    }
    func incrementState (){
        if(currentState<5) {
            currentState+=1
            setTitle()
        }
    }
    func decrementState (){
        if(currentState>1) {
            currentState-=1
            setTitle()
        }
    }
    func setTitle (){
        currentTitle = getTitlefromState(state: currentState)
    }
    func getTitlefromState (state: Int) -> String {
        switch state {
        case 1:
            return "Report your symptoms"
        case 2:
            return "Report events for your symptoms"
        case 3:
            return "Describe your day"
        case 4:
            return "Questions and Notes"
        case 5:
            return "Pick an emoji"
            
        default: return ""
        }
    }
    func setDateStringofCurrentReport (dateString: String){
        dateStringofCurrentReport = stringtoFormalDate(dateString: dateString)
    }
    func clearDateStringofCurrentReport (){
        dateStringofCurrentReport = ""
    }
    func setSelectedReport (report: Report){
        selectedReport = report //save the selected report
    }
    func clearSelectedReport (){
        selectedReport = Report() //initialize selected report
    }

}
