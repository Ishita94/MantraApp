//
//  ReportingDataService.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2024-01-23.
//

import Foundation
import Firebase
import FirebaseFirestore

struct ReportingDataService {
    private var generalViewModel : GeneralViewModel
    init(generalViewModel: GeneralViewModel) {
           self.generalViewModel = generalViewModel
       }
    
    func setRemainingReport(report: RemainingReport, saveFor: String) async{
        
        // Get reference to database
        let db = Firestore.firestore()

        if let reportId = generalViewModel.selectedReport.id { //Report exists for that date
            
            do {
                
                if(saveFor=="Description"){
                    try await db.collection("remainingReports").document(reportId)
                        .updateData(["description": report.description,
                                    "descriptionCompletionStatus": report.descriptionCompletionStatus,
                                     "lastModifiedDateTime": Date()])
                }
                else if(saveFor=="QuestionsandNotes"){
                    try await db.collection("remainingReports").document(reportId)
                        .updateData(["questions": report.questions,
                                    "notes": report.notes,
                                    "questionsandNotesCompletionStatus": report.questionsandNotesCompletionStatus,
                                     "lastModifiedDateTime": Date()])
                }
                else if(saveFor=="Emoji"){
                    try await db.collection("remainingReports").document(reportId)
                        .updateData(["emojiStateofDay": report.emojiStateofDay,
                                     "emojiValue": report.emojiValue,
                                    "emojiCompletionStatus": report.emojiCompletionStatus,
                                     "reportCompletionStatus": report.reportCompletionStatus,
                                     "lastModifiedDateTime": Date()])
                }
            } catch {
                print("Error adding description/questionsandnotes/emoji: \(error.localizedDescription)")
            }
        }
    }
    
//    func editRemainingReport(report: RemainingReport, saveFor: String) async{
//        
//        // Get reference to database
//        let db = Firestore.firestore()
//        if let id=report.id
//        {
//            let eventRef = db.collection("remainingReports").document(id)
//            if(saveFor=="Description"){
//                try? await eventRef.updateData(["description": report.description,
//                                                "descriptionCompletionStatus": report.descriptionCompletionStatus])
//            }
//            else if(saveFor=="QuestionsandNotes"){
//                try? await eventRef.updateData(["questions": report.questions,
//                                                "notes": report.notes,
//                                                "questionsandNotesCompletionStatus": report.questionsandNotesCompletionStatus])
//            }
//            else if(saveFor=="Emoji"){
//                try? await eventRef.updateData(["emojiStateofDay": report.emojiStateofDay,
//                                                "emojiCompletionStatus": report.emojiCompletionStatus])
//            }
//        }
//    }
    
//    func getRemainingReportbyDate(fromDate: Date?, toDate: Date?, completion: @escaping (RemainingReport) -> Void) {
//        
//        // Get a reference to the database
//        let db = Firestore.firestore()
//        
//        let fdate = Timestamp(date: fromDate!)
//        let tdate = Timestamp(date: toDate!)
//        var reportsofUserQuery = db.collection("remainingReports")
//            .whereField("userId", isEqualTo: AuthViewModel.getLoggedInUserId())
//            .whereField("creationDateTime", isGreaterThanOrEqualTo: fdate)
//            .whereField("creationDateTime", isLessThan: tdate)
//            .order(by: "creationDateTime", descending: true)
//        
//        reportsofUserQuery.getDocuments { snapshot, error in
//            
//            if snapshot != nil && error == nil {
//                
//                var reports = [RemainingReport]()
//                
//                for doc in snapshot!.documents {
//                    let report = try? doc.data(as: RemainingReport.self)
//                    
//                    if let remainingReport = report {
//                        reports.append(remainingReport)
//                    }
//                }
//                
//                // Return the data
//                if(reports.isEmpty) {//remaining report has not been created for this date and user
//                    completion(
//                        RemainingReport(id: "", symptomCompletionStatus: false, eventCompletionStatus: false, descriptionCompletionStatus: false, questionsandNotesCompletionStatus: false, emojiCompletionStatus: false, description: "",questions: "", notes: "", emojiValue: "ic-incomplete-red-filled", emojiStateofDay: "", creationDateTime: fromDate!, userId: AuthViewModel.getLoggedInUserId(), dayNameofWeek: "", monthNameofWeek: "", dateString: "", symptomNames: "", reportCompletionStatus: false))//dummy
//                }
//                else{
//                    completion(reports[0])
//                }
//            }
//            else {
//                print("Error in database retrieval")
//            }
//        }
//    }
    
}
