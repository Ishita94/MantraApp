//
//  SymptomController.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-10-21.
//

import Foundation
import Combine
import OrderedCollections
import EmojiPicker

class SymptomViewModel: ObservableObject {
    @Published var reportList = [Report]()
    @Published var trackedSymptomsofUser = [Symptom]()
    var symptomStatesforComparison : [SymptomComparisonState] = [
            SymptomComparisonState(stateName: "Much Better", imageName: "much-better"),
            SymptomComparisonState(stateName: "Somewhat Better", imageName: "somewhat-better"),
            SymptomComparisonState(stateName: "No Change", imageName: "no-change"),
            SymptomComparisonState(stateName: "Somewhat Worse", imageName: "much-worse"),
            SymptomComparisonState(stateName: "Much Worse", imageName: "much-worse")
        ]
    @Published var dictionaryofSuggestedReports: OrderedDictionary<Date , SymptomReport> = [:]
    @Published var emojis: [Emoji] = DefaultEmojiProvider().getAll()
    private var symptomDataService : SymptomDataService
    //    @Published var reportedSymptomsofUserbyDate = [SymptomReport]()
    //@Published var dictionaryofReports: OrderedDictionary<String , Report> = [:]
    //    @Published var reportsofUser = [SymptomReport]()
    //    @Published var suggestedSymptomsofUserbeforeDate = [SymptomReport]()

    init(generalViewModel: GeneralViewModel) {
        self.symptomDataService = SymptomDataService(generalViewModel: generalViewModel)
    }
    
    func getReportsofUser() {
        
        DispatchQueue.main.async {
            Task{
                await self.symptomDataService.getReportsofUser() { reportsofUser in
                        self.reportList = reportsofUser
                }
            }
            }
        }
    
    func getTrackedSymptomsofUser() {
        
        DispatchQueue.main.async {
            Task{
               let symptoms = await self.symptomDataService.getTrackedSymptomsofUser()
                    
                    // Update the UI in the main thread
                    DispatchQueue.main.async {
                        self.trackedSymptomsofUser = symptoms
                    }
                }
        }
        }
    
//    func getSymptomsinReport(report: Report){
//        DispatchQueue.main.async {
//            Task{
//                await self.symptomDataService.getSymptomsinReport(report: report) {
//                    DispatchQueue.main.async {
//                        self.trackedSymptomsofUser = symptoms
//                    }
//                }
//            }
//        }
//    }
    
//    func getReportedSymptomsofUserbyDate(date: String, showAfterCreatingNewSymptomReport: Bool) {
//        //TODO: remove redundant 'showAfterCreatingNewSymptomReport'
//        //if(showAfterCreatingNewSymptomReport){
//            
//            let fromDate: Date? = prepareDate(dateString: date)
//            let toDate: Date? = prepareNextDate(date: fromDate!)
//            
//            DispatchQueue.main.async {
//                SymptomDataService().getReportedSymptomsbyDate(fromDate: fromDate!, toDate: toDate!) { reportsofUser in
//                        self.reportedSymptomsofUserbyDate = reportsofUser
//                    }
//            }
////        }
////        else
////        {
////            self.reportedSymptomsofUserbyDate = self.dictionaryofReports[date] ?? []
////        }
//        
//    }
    
    func getSuggestedSymptomsofUserbeforeDate(date: Date){
        //before this date, nothing reported today
        //all tracked symptoms
        //last report instance
        DispatchQueue.main.async {
            Task{
                let preparedDate:Date? = prepareDatefromDate(date: date)
                //get all tracked symptoms, get all symptomreports of this user before today that has same symptomid of tracked symptoms
                
                let symptoms = await self.symptomDataService.getTrackedSymptomsofUser()
                self.trackedSymptomsofUser = symptoms
                let trackedSymptomIds: [String] = self.trackedSymptomsofUser.map({$0.id!})
                self.dictionaryofSuggestedReports = [:]
                
                let symptomReports = await self.symptomDataService.getSuggestedSymptomsofUser(trackedSymptomIds: trackedSymptomIds, reportList: self.reportList, date: preparedDate!)
                    
                    self.dictionaryofSuggestedReports = symptomReports
                }
        }
    }
    
    func saveNewReport(){
        DispatchQueue.main.async {
            Task{
                let existingReport = self.reportList.first(where: { $0.dateString == Date.now.datetoString()!})
                await self.symptomDataService.createNewReport(existingReport: existingReport)
            }
        }
    }
        
    func saveSymptomReport(symptomReport: SymptomReport){
        DispatchQueue.main.async {
            Task{
                await self.symptomDataService.setNewSymptomofUser(symptomReport: symptomReport)
            }
        }
    }
    
    func editSymptomReport(symptomReport: SymptomReport){
        DispatchQueue.main.async {
            Task{
                await self.symptomDataService.editSymptomReport(symptomReport: symptomReport)
            }
        }
    }
    
    func setSymptomReportofTrackedSymptom(symptomReport: SymptomReport){
        DispatchQueue.main.async {
            Task{
                await self.symptomDataService.setSymptomReportofTrackedSymptom(symptomReport: symptomReport, firstreportofSymptom: false)
            }
        }
    }
}

