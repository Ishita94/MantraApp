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
    @Published  var descriptionText = ""
//    @Published  var questionsText = ""
//    @Published  var notesText = ""
//    @Published  var emojiStateofDay = ""
    
    @Published var remainingReportbyDate = RemainingReport(descriptionCompletionStatus: false, questionsandNotesCompletionStatus: false, emojiCompletionStatus: false, description: "", questions: "", notes: "", emojiIconName: "ic-incomplete-red-filled", emojiStateofDay: nil, creationDateTime: Date.now, userId: "")
    
    func getRemainingReport(date: Date){
        let formattedFromDate: Date? = prepareDatefromDate(date: date)
        let formattedToDate: Date? = prepareNextDate(date: formattedFromDate!)
        
                DispatchQueue.main.async {
                    ReportingDataService().getRemainingReportbyDate(fromDate: formattedFromDate!, toDate: formattedToDate!) { report in
                        
                        // Update the UI in the main thread
                        self.remainingReportbyDate = report

                    }
                    
                }
            }
    
    func saveRemainingReport(report: RemainingReport, saveFor: String){
        DispatchQueue.main.async {
                Task{
                    if let id = report.id{//remaining report row exists for this user and date in the database, just need to update
                        await ReportingDataService().editRemainingReport(report: report, saveFor: saveFor)
                    }
                    else //add new row for remaining report in database
                    {
                        await ReportingDataService().setRemainingReport(report: report, saveFor: saveFor)
                    }
                }
        }
    }
}

