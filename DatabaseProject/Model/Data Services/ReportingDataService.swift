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
    
    func getRemainingReportbyDate(fromDate: Date?, toDate: Date?, completion: @escaping (RemainingReport) -> Void) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        let fdate = Timestamp(date: fromDate!)
        let tdate = Timestamp(date: toDate!)
        var reportsofUserQuery = db.collection("remainingReports")
            .whereField("userId", isEqualTo: AuthViewModel.getLoggedInUserId())
            .whereField("creationDateTime", isGreaterThanOrEqualTo: fdate)
            .whereField("creationDateTime", isLessThan: tdate)
            .order(by: "creationDateTime", descending: true)
        
        reportsofUserQuery.getDocuments { snapshot, error in
            
            if snapshot != nil && error == nil {
                
                var reports = [RemainingReport]()
                
                for doc in snapshot!.documents {
                    let report = try? doc.data(as: RemainingReport.self)
                    
                    if let remainingReport = report {
                        reports.append(remainingReport)
                    }
                }
                
                // Return the data
                if(reports.isEmpty) {//remaining report has not been created for this date and user
                    completion(
                        RemainingReport(descriptionCompletionStatus: false, questionsandNotesCompletionStatus: false, emojiCompletionStatus: false, description: "", questions: "", notes: "", emojiIconName: "ic-incomplete-red-filled", emojiStateofDay: "", creationDateTime: fromDate!, userId: AuthViewModel.getLoggedInUserId())) //dummy
                }
                else{
                    completion(reports[0])
                }
            }
            else {
                print("Error in database retrieval")
            }
        }
    }
    
    func setRemainingReport(report: RemainingReport, saveFor: String) async{
        
        // Get reference to database
        let db = Firestore.firestore()
        
        // Add document
        if(saveFor=="Description"){
            try? await db.collection("remainingReports")
                .addDocument(data: ["creationDateTime": report.creationDateTime,
                                    "description": report.description,
                                    "descriptionCompletionStatus": report.descriptionCompletionStatus,
                                    "questions": report.questions,
                                    "notes": report.notes,
                                    "questionsandNotesCompletionStatus": report.questionsandNotesCompletionStatus,
                                    "emojiStateofDay": report.emojiStateofDay,
                                    "emojiCompletionStatus": report.emojiCompletionStatus,
                                    "userId" : AuthViewModel.getLoggedInUserId()])
        }
//        else if(saveFor=="QuestionsandNotes"){
//            try? await db.collection("remainingReports")
//                .addDocument(data: ["creationDateTime": Date.now,
//                                    "questions": report.questions,
//                                    "notes": report.notes,
//                                    "questionsandNotesCompletionStatus": report.questionsandNotesCompletionStatus,               "userId" : AuthViewModel.getLoggedInUserId()])
//        }
//        else if(saveFor=="Emoji"){
//            try? await db.collection("remainingReports")
//                .addDocument(data: ["creationDateTime": Date.now,
//                                    "emojiStateofDay": report.emojiStateofDay,
//                                    "emojiCompletionStatus": report.emojiCompletionStatus,
//                                    "userId" : AuthViewModel.getLoggedInUserId()])
//        }
        
    }
    
    func editRemainingReport(report: RemainingReport, saveFor: String) async{
        
        // Get reference to database
        let db = Firestore.firestore()
        if let id=report.id
        {
            let eventRef = db.collection("remainingReports").document(id)
            if(saveFor=="Description"){
                try? await eventRef.updateData(["description": report.description,
                                                "descriptionCompletionStatus": report.descriptionCompletionStatus])
            }
            else if(saveFor=="QuestionsandNotes"){
                try? await eventRef.updateData(["questions": report.questions,
                                                "notes": report.notes,
                                                "questionsandNotesCompletionStatus": report.questionsandNotesCompletionStatus])
            }
            else if(saveFor=="Emoji"){
                try? await eventRef.updateData(["emojiStateofDay": report.emojiStateofDay,
                                                "emojiCompletionStatus": report.emojiCompletionStatus])
            }
        }
    }
    
}
