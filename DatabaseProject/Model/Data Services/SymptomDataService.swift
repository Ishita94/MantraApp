//
//  ReportingDataService.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-18.
//

import Foundation
import Firebase
import FirebaseFirestore


struct SymptomDataService {
    func getData() -> [SymptomReport] {
        
        return [
            SymptomReport(
                dateFormatted: "Aug 20, 2023", creationDateTime: Date.now, rating: 0, emojiIconName: "ic-incomplete-red-filled", symptomName: "Nausea", symptomComparisonState: "Much Better", reportCompletionStatus: false, recentStatus: "N/A", symptomId: "1", userId: ""),
            SymptomReport(
                dateFormatted: "Aug 20, 2023", creationDateTime: Date.now, rating: 0, emojiIconName: "ic-incomplete-red-filled", symptomName: "Fatigue", symptomComparisonState: "Somewhat Worse", reportCompletionStatus: false, recentStatus: "N/A", symptomId: "1", userId: ""),
            SymptomReport(
                dateFormatted: "Aug 20, 2023", creationDateTime: Date.now, rating: 0, emojiIconName: "ic-incomplete-red-filled", symptomName: "Pain", symptomComparisonState: "Worse", reportCompletionStatus: false, recentStatus: "N/A", symptomId: "1", userId: "")
        ]
    }
    
    
    func getReportsofUser(completion: @escaping ([SymptomReport]) -> Void) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        let reportsofUserQuery = db.collection("symptomReports")
            .whereField("userId", isEqualTo: AuthViewModel.getLoggedInUserId())
            .order(by: "creationDateTime", descending: true)

        reportsofUserQuery.getDocuments { snapshot, error in
            
            if snapshot != nil && error == nil {
                
                var symptomReports = [SymptomReport]()
                                for doc in snapshot!.documents {
                    print("-----------------")
                    print(doc.data())
//                    let date = doc.get("creationDateTime") as! Timestamp
                    let symptomReport = try? doc.data(as: SymptomReport.self)
                    
                    // Add the chat into the array
                    if var symptomReport = symptomReport {
                        symptomReport.dateString = symptomReport.creationDateTime.datetoString()
                        symptomReports.append(symptomReport)
                    }
                }
                
                // Return the data
                completion(symptomReports)
            }
            else {
                print("Error in database retrieval")
            }
        }
    }


    func getTrackedSymptomsofUser(completion: @escaping ([Symptom]) -> Void) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        // Perform a query against the chat collection for any chats where the user is a participant
        let symptomsTrackedbyUserQuery = db.collection("symptoms")
            .whereField("userId",
                        isEqualTo: AuthViewModel.getLoggedInUserId())
            .whereField("tracking",
                        isEqualTo: true)
            .order(by: "creationDateTime", descending: false)

        
        symptomsTrackedbyUserQuery.getDocuments { snapshot, error in
            
            if snapshot != nil && error == nil {
                
                var trackedSymptoms = [Symptom]()
                
                // Loop through all the returned chat docs
                for doc in snapshot!.documents {
                    
                    // Parse the data into Chat structs
                    let symptom = try? doc.data(as: Symptom.self)
                    let id = doc.documentID
                    // Add the chat into the array
                    if let symptom = symptom {
                        var report = symptom
                        report.id = id
                        trackedSymptoms.append(report)
                    }
                }
                
                // Return the data
                completion(trackedSymptoms)
            }
            else {
                print("Error in database retrieval")
            }
        }
    }
    
    func getReportedSymptomsbyDate(fromDate: Date, toDate: Date, completion: @escaping ([SymptomReport]) -> Void) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        let fdate = Timestamp(date: fromDate)
        let tdate = Timestamp(date: toDate)
        
        let reportsofUserQuery = db.collection("symptomReports")
            .whereField("userId", isEqualTo: AuthViewModel.getLoggedInUserId())
            .whereField("creationDateTime", isGreaterThanOrEqualTo: fdate)
            .whereField("creationDateTime", isLessThan: tdate)
        
        reportsofUserQuery.getDocuments { snapshot, error in
            
            if snapshot != nil && error == nil {
                
                var symptomReports = [SymptomReport]()
                
                // Loop through all the returned chat docs
                for doc in snapshot!.documents {
//                    let date = doc.get("creationDateTime") as! Timestamp
//                    let rating = doc.get("rating") as! Int
//                    let symptomId = doc.get("symptomId") as! String
//                    let symptomComparisonState=doc.get("symptomComparisonState") as! String
//                    let reportCompletionStatus=doc.get("reportCompletionStatus") as! Bool
//                    let recentStatus=doc.get("recentStatus") as! String
                    // Parse the data into Chat structs
                    let symptomReport = try? doc.data(as: SymptomReport.self)
                    
                    // Add the chat into the array
                    if let symptomReport = symptomReport {
                        symptomReports.append(symptomReport)
                    }
                }
                
                // Return the data
                completion(symptomReports)
            }
            else {
                print("Error in database retrieval")
            }
        }
    }

    func setNewSymptomofUser(symptomReport: SymptomReport) async {
        let db = Firestore.firestore()
        
        // Create a new symptom
        let newSymptomAdded = try? await db.collection("symptoms")
            .addDocument(data: ["creationDateTime": symptomReport.creationDateTime,
                                "symptomName": symptomReport.symptomName,
                                "tracking": true, //auto-set to track when created
                                "userId" : AuthViewModel.getLoggedInUserId()])
       
        // Create a new symptom report for this symptom
        Task{
            await self.setNewSymptomReportofUser(symptomReport: symptomReport, newSymptomAdded: newSymptomAdded!)
        }
    }
    
    func setNewSymptomReportofUser(symptomReport: SymptomReport, newSymptomAdded: DocumentReference?) async {
        let db = Firestore.firestore()
       
        let newRef = db.collection("symptomReports")
                .document()     // generates a new reference with a unique ID
        try? await newRef.setData([
                                    "creationDateTime": symptomReport.creationDateTime,
                                         "rating": symptomReport.rating,
                                         "recentStatus": symptomReport.recentStatus,
                                         "reportCompletionStatus": symptomReport.reportCompletionStatus,
                                         "symptomComparisonState" : symptomReport.symptomComparisonState,
                                         "symptomId" : newSymptomAdded!.documentID,
                                         "symptomName": symptomReport.symptomName,
                                         "userId" : AuthViewModel.getLoggedInUserId()])
    }
    
    func setSymptomReportofTrackedSymptom(symptomReport: SymptomReport) async{
        
        // Get reference to database
        let db = Firestore.firestore()
        
        // Add document
        try? await db.collection("symptomReports")
            .addDocument(data: ["creationDateTime": symptomReport.creationDateTime,
                                "rating": symptomReport.rating,
                                "recentStatus": symptomReport.recentStatus,
                                "reportCompletionStatus": symptomReport.reportCompletionStatus,
                                "symptomComparisonState" : symptomReport.symptomComparisonState,
                                "symptomId" : symptomReport.symptomId, 
                                "symptomName" : symptomReport.symptomName,
                                "userId" : AuthViewModel.getLoggedInUserId()])
    }
    
    func editSymptomReport(symptomReport: SymptomReport) async{
        
        // Get reference to database
        let db = Firestore.firestore()
        
        if let id=symptomReport.id
        {
            let symptomReportRef = db.collection("symptomReports").document(id)
            try? await symptomReportRef.updateData(["creationDateTime": symptomReport.creationDateTime,
                                                    "rating": symptomReport.rating,
                                                    "recentStatus": symptomReport.recentStatus,
                                                    "reportCompletionStatus": symptomReport.reportCompletionStatus,
                                                    "symptomComparisonState" : symptomReport.symptomComparisonState,
                                                    "symptomId" : symptomReport.symptomId,
                                                    "symptomName" : symptomReport.symptomName,
                                                    "userId" : AuthViewModel.getLoggedInUserId()])
        }
    }
    
    func getSuggestedSymptomsofUser(symptomId: String, date: Date, completion: @escaping (SymptomReport) -> Void) {
        let db = Firestore.firestore()
        let tdate = Timestamp(date: date)

        let reportsofUserQuery = db.collection("symptomReports")
            .whereField("userId", isEqualTo: AuthViewModel.getLoggedInUserId())
            .whereField("symptomId", isEqualTo: symptomId)
            .whereField("creationDateTime", isLessThan: tdate)
            .order(by: "creationDateTime", descending: false)
            .limit(toLast: 1)
        ;
        
        reportsofUserQuery.getDocuments { snapshot, error in
            
            if snapshot != nil && error == nil {
                
                var symptomReports = [SymptomReport]()
                
                // Loop through all the returned chat docs
                for doc in snapshot!.documents {
                    print("-----------------")
                    print(doc.data())
//                    let date = doc.get("creationDateTime") as! Timestamp
//                    let rating = doc.get("rating") as! Int
//                    let symptomId = doc.get("symptomId") as! String
//                    let symptomComparisonState=doc.get("symptomComparisonState") as! String
//                    let reportCompletionStatus=doc.get("reportCompletionStatus") as! Bool
//                    let recentStatus=doc.get("recentStatus") as! String
                    // Parse the data into Chat structs
                    let symptomReport = try? doc.data(as: SymptomReport.self)
                    
                    if var symptomReport = symptomReport {
                        symptomReport.dateString = symptomReport.creationDateTime.datetoString()
                        symptomReports.append(symptomReport)
                    }
                }
                
                // Return the data
                if(symptomReports.isEmpty) {
                    completion(SymptomReport(
                        id:"", dateFormatted: "Aug 20, 2023", creationDateTime: Date.now, rating: 0, emojiIconName: "ic-incomplete-red-filled", symptomName: "Nausea", symptomComparisonState: "Much Better", reportCompletionStatus: false, recentStatus: "N/A", symptomId: "", userId: "")) //dummy
                }
                    else{
                    completion(symptomReports[0])
                }
            }
            else {
                print("Error in database retrieval")
            }
        }
    }

}

