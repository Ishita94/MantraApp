//
//  ReportingViewModel.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2024-01-23.
//

import Foundation
import Combine
import OrderedCollections

class ReportingViewModel: ObservableObject {
    private var reportingDataService : ReportingDataService
    
    @Published  var descriptionText = ""
//    @Published  var questionsText = ""
//    @Published  var notesText = ""
//    @Published  var emojiStateofDay = ""
    

    @Published var remainingReportbyDate = RemainingReport(id: "", symptomCompletionStatus: false, eventCompletionStatus: false, descriptionCompletionStatus: false, questionsandNotesCompletionStatus: false, emojiCompletionStatus: false, description: "",questions: "", notes: "", emojiValue: "ic-incomplete-red-filled", emojiStateofDay: "", creationDateTime: Date.now, userId:  AuthViewModel.getLoggedInUserId(), dayNameofWeek: "", monthNameofWeek: "", dateString: "", symptomNames: "", reportCompletionStatus: false)
    
    init(generalViewModel: GeneralViewModel) {
        self.reportingDataService = ReportingDataService(generalViewModel: generalViewModel)
    }
    
//    func getRemainingReport(date: Date){
//        let formattedFromDate: Date? = prepareDatefromDate(date: date)
//        let formattedToDate: Date? = prepareNextDate(date: formattedFromDate!)
//        
//                DispatchQueue.main.async {
//                    self.reportingDataService.getRemainingReportbyDate(fromDate: formattedFromDate!, toDate: formattedToDate!) { report in
//                        
//                        // Update the UI in the main thread
//                        self.remainingReportbyDate = report
//
//                    }
//                    
//                }
//            }
    
    func saveRemainingReport(report: RemainingReport, saveFor: String){
        DispatchQueue.main.async {
                Task{
//                    if let id = report.id{//remaining report row exists for this user and date in the database, just need to update
//                        await self.reportingDataService.editRemainingReport(report: report, saveFor: saveFor)
//                    }
//                    else //add new row for remaining report in database
//                    {
                        await self.reportingDataService.setRemainingReport(report: report, saveFor: saveFor)
                    //}
                }
        }
    }
}

