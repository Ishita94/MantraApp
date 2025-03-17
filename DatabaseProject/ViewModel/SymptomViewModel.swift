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
    @Published var reportsofUser = [SymptomReport]()
    @Published var reportedSymptomsofUserbyDate = [SymptomReport]()
    @Published var suggestedSymptomsofUserbeforeDate = [SymptomReport]()
    @Published var trackedSymptomsofUser = [Symptom]()
    //@Published var dictionaryofReports: OrderedDictionary<String , Report> = [:]
    @Published var dictionaryofSuggestedReports: OrderedDictionary<String , SymptomReport> = [:]
    @Published var symptomStatesforComparison : [SymptomComparisonState] = [
            SymptomComparisonState(stateName: "Much Better", imageName: "much-better"),
            SymptomComparisonState(stateName: "Somewhat Better", imageName: "somewhat-better"),
            SymptomComparisonState(stateName: "No Change", imageName: "no-change"),
            SymptomComparisonState(stateName: "Somewhat Worse", imageName: "much-worse"),
            SymptomComparisonState(stateName: "Much Worse", imageName: "much-worse")
        ]
    @Published var emojis: [Emoji] = DefaultEmojiProvider().getAll()
    private var symptomDataService : SymptomDataService
    
   
    init(generalViewModel: GeneralViewModel) {
        self.symptomDataService = SymptomDataService(generalViewModel: generalViewModel)
    }
    
    func getReportsofUser() {
        
        DispatchQueue.main.async {
            
            
            
            Task{
                await self.symptomDataService.getReportsofUser() { reportsofUser in
                    
                    // Update the UI in the main thread
//                    DispatchQueue.main.async {
                        self.reportList = reportsofUser
                        //self.prepareDictionaryforReportList()
                        //self.prepareReportsforReportList()
//                    }
                }
            }
            }
        }
    
//    func prepareDictionaryforReportList() {
//        dictionaryofReports = OrderedDictionary(grouping: reportList, by: {$0.dateString ?? ""})
//    }
    
    func prepareReportsforReportList() {
        for report in reportList {
//            let date = stringtoDate(dateString: report.creationDateTime);
            var formattedDay = ""
            var formattedDate = ""
//            if var date = report.creationDateTime {
//            report.dayNameofWeek = report.creationDateTime.dayNameOfWeek() ?? ""
//            report.monthNameofWeek = report.creationDateTime.monthandDate() ?? ""
            //}
            
//            let reportCompletionStatus = false //TODO: need to figure out how to store complete/incomplete status
//            self.reportList.append(Report(dayNameofWeek: formattedDay, monthNameofWeek: formattedDate, dateString: key, emojiStateofDay: "Nauseous", symptomNames: symptomNames, reportCompletionStatus: reportCompletionStatus, creationDateTime: date!, userId: ""))
            //TODO: check
            
            //emojis.first(where: { $0.name == item.emojiStateofDay }
            //TODO: Need to update emojistateofdayicon
            //TODO: Need to update emojistateofday

            
        }
    }
    
    
    func getTrackedSymptomsofUser() {
        
        DispatchQueue.main.async {
            self.symptomDataService.getTrackedSymptomsofUser() { symptoms in
                    
                    // Update the UI in the main thread
                    DispatchQueue.main.async {
                        self.trackedSymptomsofUser = symptoms
                    }
                }
                
            }
        }
    
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
            // Get last report of the symtomId, before today
            let preparedDate:Date? = prepareDatefromDate(date: date)
            //TODO: get all tracked symptoms, get all symptomreports of this user before today that has same symptomid of tracked symptoms
            
            self.symptomDataService.getTrackedSymptomsofUser() { symptoms in
                self.trackedSymptomsofUser = symptoms
                var trackedSymptomIds: [String] = self.trackedSymptomsofUser.map({$0.id!})
                let group = DispatchGroup()
                self.dictionaryofSuggestedReports = [:]
                
                    for symptom in symptoms{
                        group.enter()

                        if let unwrappedSymptomId = symptom.id{
                            self.symptomDataService.getSuggestedSymptomsofUser(trackedSymptomIds: trackedSymptomIds, symptomId: unwrappedSymptomId, date: preparedDate!) { symptomReport in
                                 if let id = symptomReport.symptomId {
                                     if(id==""){ //to handle error situation where there is a symptom but no report of it
                                                //ideally, it wouldn't happen
                                     }
                                     else
                                     {
                                         let alreadyReported = self.reportedSymptomsofUserbyDate.contains{
                                             element in
                                             if (element.symptomId == symptomReport.symptomId) { //already reported that day
                                                 return true
                                             } else {
                                                 self.dictionaryofSuggestedReports[id] = symptomReport //show suggestion
                                                 return false
                                             }
                                         }
                                         if(!alreadyReported)
                                         {
                                             self.dictionaryofSuggestedReports[id] = symptomReport //show suggestion
                                         }
                                     }
                                 }
                            }
                        }
                        group.leave()
                    }
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
                await self.symptomDataService.setSymptomReportofTrackedSymptom(symptomReport: symptomReport)
            }
        }
    }
}

