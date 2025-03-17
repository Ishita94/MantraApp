//
//  ReportingDataService.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-18.
//

import Foundation
import Firebase
import FirebaseFirestore
import SwiftUICore


struct SymptomDataService {
    private var generalViewModel : GeneralViewModel
    
    var lastUsedReportRef: DocumentReference?
    
//    var remainingReportbyDate = RemainingReport(id: "", symptomCompletionStatus: false, eventCompletionStatus: false, descriptionCompletionStatus: false, questionsandNotesCompletionStatus: false, emojiCompletionStatus: false, description: "",questions: "", notes: "", emojiValue: "ic-incomplete-red-filled", emojiStateofDay: "", creationDateTime: Date.now, userId:  AuthViewModel.getLoggedInUserId(), dayNameofWeek: "", monthNameofWeek: "", dateString: "", symptomNames: "", reportCompletionStatus: false)
    
    
    init(generalViewModel: GeneralViewModel) {
           self.generalViewModel = generalViewModel
       }
    
    func getData() -> [SymptomReport] {
        
        return [
            SymptomReport(
                dateFormatted: "Aug 20, 2023", creationDateTime: Date.now, lastModifiedDateTime: Date.now, rating: 0, emojiIconName: "ic-incomplete-red-filled", symptomName: "Nausea", symptomComparisonState: "Much Better", reportCompletionStatus: false, recentStatus: "N/A", symptomId: "1", userId: ""),
            SymptomReport(
                dateFormatted: "Aug 20, 2023", creationDateTime: Date.now, lastModifiedDateTime: Date.now, rating: 0, emojiIconName: "ic-incomplete-red-filled", symptomName: "Fatigue", symptomComparisonState: "Somewhat Worse", reportCompletionStatus: false, recentStatus: "N/A", symptomId: "1", userId: ""),
            SymptomReport(
                dateFormatted: "Aug 20, 2023", creationDateTime: Date.now, lastModifiedDateTime: Date.now, rating: 0, emojiIconName: "ic-incomplete-red-filled", symptomName: "Pain", symptomComparisonState: "Worse", reportCompletionStatus: false, recentStatus: "N/A", symptomId: "1", userId: "")
        ]
    }
    
    func getReportsofUser(completion: @escaping ([Report]) -> Void) async {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        do{
            let userId = AuthViewModel.getLoggedInUserId()
            
            let reportSnapshot = try await db.collection("remainingReports")
                .whereField("userId", isEqualTo: userId)
                .order(by: "creationDateTime", descending: true)
                .getDocuments()
            
            var reportsArray: [Report] = []
            
            for document in reportSnapshot.documents {
                var reportQuery = try document.data(as: ReportforQuery.self) // Convert Firestore document to Report
                
                // 🔹 Step 2: Fetch the symptomReport subcollection for each report
                let symptomSnapshot = try await db.collection("remainingReports")
                    .document(document.documentID)
                    .collection("symptomReport")
                    .getDocuments()
                
                var symptoms = try symptomSnapshot.documents.compactMap { doc in
                    try doc.data(as: SymptomReport.self)
                }
                var report = Report(from: reportQuery)
                report.symptomNames = symptoms.compactMap { $0.symptomName }.joined(separator: " , ")
                report.symptomReports = symptoms // Attach symptoms to the report
                report.dayNameofWeek = report.creationDateTime.dayNameOfWeek() ?? ""
                report.monthNameofWeek = report.creationDateTime.monthandDate() ?? ""
                report.dateString = report.creationDateTime.datetoString() ?? ""
                reportsArray.append(report) // Add the report to the array
            }
            
            DispatchQueue.main.async {
                completion( reportsArray)
            }
            
            print("✅ Successfully fetched reports with symptoms!")
        } catch {
            print("❌ Error fetching reports: \(error.localizedDescription)")
        }
        
        //
        //        reportsofUserQuery.getDocuments { snapshot, error in
        //
        //            if snapshot != nil && error == nil {
        //
        //                var symptomReports = [SymptomReport]()
        //                                for doc in snapshot!.documents {
        //                    print("-----------------")
        //                    print(doc.data())
        ////                    let date = doc.get("creationDateTime") as! Timestamp
        //                    let symptomReport = try? doc.data(as: SymptomReport.self)
        //
        //                    // Add the chat into the array
        //                    if var symptomReport = symptomReport {
        //                        symptomReport.dateString = symptomReport.creationDateTime.datetoString()
        //                        symptomReports.append(symptomReport)
        //                    }
        //                }
        //
        //                // Return the data
        //                completion(symptomReports)
        //            }
        //            else {
        //                print("Error in database retrieval")
        //            }
        //        }
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
    
    //    func getReportedSymptomsbyDate(fromDate: Date, toDate: Date, completion: @escaping ([SymptomReport]) -> Void) {
    //
    //        // Get a reference to the database
    //        let db = Firestore.firestore()
    //        let fdate = Timestamp(date: fromDate)
    //        let tdate = Timestamp(date: toDate)
    //
    //        let reportsofUserQuery = db.collection("symptomReports")
    //            .whereField("userId", isEqualTo: AuthViewModel.getLoggedInUserId())
    //            .whereField("creationDateTime", isGreaterThanOrEqualTo: fdate)
    //            .whereField("creationDateTime", isLessThan: tdate)
    //
    //        reportsofUserQuery.getDocuments { snapshot, error in
    //
    //            if snapshot != nil && error == nil {
    //
    //                var symptomReports = [SymptomReport]()
    //
    //                // Loop through all the returned chat docs
    //                for doc in snapshot!.documents {
    ////                    let date = doc.get("creationDateTime") as! Timestamp
    ////                    let rating = doc.get("rating") as! Int
    ////                    let symptomId = doc.get("symptomId") as! String
    ////                    let symptomComparisonState=doc.get("symptomComparisonState") as! String
    ////                    let reportCompletionStatus=doc.get("reportCompletionStatus") as! Bool
    ////                    let recentStatus=doc.get("recentStatus") as! String
    //                    // Parse the data into Chat structs
    //                    let symptomReport = try? doc.data(as: SymptomReport.self)
    //
    //                    // Add the chat into the array
    //                    if let symptomReport = symptomReport {
    //                        symptomReports.append(symptomReport)
    //                    }
    //                }
    //
    //                // Return the data
    //                completion(symptomReports)
    //            }
    //            else {
    //                print("Error in database retrieval")
    //            }
    //        }
    //    }
    
    mutating func setNewSymptomofUser(symptomReport: SymptomReport) async {
        let db = Firestore.firestore()
        
        // Create a new symptom
        let newSymptomAdded = try? await db.collection("symptoms")
            .addDocument(data: ["creationDateTime": symptomReport.creationDateTime,
                                "symptomName": symptomReport.symptomName,
                                "tracking": true, //auto-set to track when created
                                "userId" : AuthViewModel.getLoggedInUserId()])
        
        guard let symptomId = newSymptomAdded!.documentID as String? else {
            print("❌ Error: Failed to retrieve new symptom document ID")
            return
        }
        
        // Create a new symptom report for this symptom
        var placeholder = symptomReport
        placeholder.symptomId = symptomId
        await setSymptomReportofTrackedSymptom (symptomReport: placeholder)
        
        //            await self.setNewSymptomReportofUser(symptomReport: symptomReport, newSymptomAdded: newSymptomAdded!)
        
    }
    
    //    func setNewSymptomReportofUser(symptomReport: SymptomReport, newSymptomAdded: DocumentReference?) async {
    //        let db = Firestore.firestore()
    //
    //        let newRef = db.collection("symptomReports")
    //                .document()     // generates a new reference with a unique ID
    //        try? await newRef.setData([
    //                                    "creationDateTime": symptomReport.creationDateTime,
    //                                         "rating": symptomReport.rating,
    //                                         "recentStatus": symptomReport.recentStatus,
    //                                         "reportCompletionStatus": symptomReport.reportCompletionStatus,
    //                                         "symptomComparisonState" : symptomReport.symptomComparisonState,
    //                                         "symptomId" : newSymptomAdded!.documentID,
    //                                         "symptomName": symptomReport.symptomName,
    //                                         "userId" : AuthViewModel.getLoggedInUserId()])
    //    }
    
    mutating func setSymptomReportofTrackedSymptom(symptomReport: SymptomReport) async{
        
        // Get reference to database
        let db = Firestore.firestore()
//        let formattedFromDate: Date? = prepareDatefromDate(date: symptomReport.creationDateTime)
//        let formattedToDate: Date? = prepareNextDate(date: formattedFromDate!)
        
        
        //                let reportSnapshot = try await db.collection("remainingReports")
        //                    .whereField("userId", isEqualTo: AuthViewModel.getLoggedInUserId())
        //                    .whereField("creationDateTime", isGreaterThanOrEqualTo: formattedFromDate!)
        //                    .whereField("creationDateTime", isLessThan: formattedToDate!)
        //                    .order(by: "creationDateTime", descending: true)
        //                    .limit(to: 1) // Optimize to fetch only 1 document
        //                    .getDocuments()
        
        var reportRef: DocumentReference
        
        //                if let document = reportSnapshot.documents.first { //Report exists for that date
        //                    reportRef = document.reference
        //                }
        //                else //No report exist, so need to create new Report document first
        //                {
        //                    reportRef = db.collection("remainingReports").document() // Auto-generated document ID
        //                }
        
        if let reportId = generalViewModel.selectedReport.id { //Report exists for that date
            reportRef = db.collection("remainingReports").document(reportId)
        }
        else //No report exist, so need to create new Report document first
        {
            reportRef = db.collection("remainingReports").document() // Auto-generated document ID
        }
        do {
            
            try await reportRef.collection("symptomReport").addDocument(from: symptomReport)
            //                    try await ReportingDataService().setRemainingReport(report: remainingReportbyDate, saveFor: "")
            
            
            //                let newSymptomReportRef = reportRef.collection("symptomReport").document()
            
            //            try await reportRef.collection("symptomReport")
            //                .addDocument(data:
            //                        ["creationDateTime": symptomReport.creationDateTime,
            //                        "rating": symptomReport.rating,
            //                        "recentStatus": symptomReport.recentStatus,
            //                        "reportCompletionStatus": symptomReport.reportCompletionStatus,
            //                        "symptomComparisonState": symptomReport.symptomComparisonState,
            //                        "symptomId": symptomReport.symptomId,
            //                        "symptomName": symptomReport.symptomName,
            //                        "userId": AuthViewModel.getLoggedInUserId()
            //                    ])
            
            //            lastUsedReportRef = reportRef
            
        } catch {
            print("Error adding symptom report: \(error.localizedDescription)")
        }
    }
    
    //        // Add document
    //        if let document = reportRef.documents.first { // If a document exists
    //                    let documentID = document.documentID
    //            try? await reportRef.collection("symptomReport")
    //                .addDocument(data: ["creationDateTime": symptomReport.creationDateTime,
    //                                    "rating": symptomReport.rating,
    //                                    "recentStatus": symptomReport.recentStatus,
    //                                    "reportCompletionStatus": symptomReport.reportCompletionStatus,
    //                                    "symptomComparisonState" : symptomReport.symptomComparisonState,
    //                                    "symptomId" : symptomReport.symptomId,
    //                                    "symptomName" : symptomReport.symptomName,
    //                                    "userId" : AuthViewModel.getLoggedInUserId()])
    //                }
    //        else {
    //                    try? await db.collection("symptomReports")
    //                        .addDocument(data: ["creationDateTime": symptomReport.creationDateTime,
    //                                            "rating": symptomReport.rating,
    //                                            "recentStatus": symptomReport.recentStatus,
    //                                            "reportCompletionStatus": symptomReport.reportCompletionStatus,
    //                                            "symptomComparisonState" : symptomReport.symptomComparisonState,
    //                                            "symptomId" : symptomReport.symptomId,
    //                                            "symptomName" : symptomReport.symptomName,
    //                                            "userId" : AuthViewModel.getLoggedInUserId()])
    //                }
    
    
    
    
    // }
    
    func editSymptomReport(symptomReport: SymptomReport) async{
        
        // Get reference to database
        let db = Firestore.firestore()
        
        
        if let id=symptomReport.id, let reportId = generalViewModel.selectedReport.id { //Report exists and the symptomreport exists in it
            //            let symptomReportRef = db.collection("symptomReports").document(id)
            //            try? await symptomReportRef.updateData(["creationDateTime": symptomReport.creationDateTime,
            //                                                    "rating": symptomReport.rating,
            //                                                    "recentStatus": symptomReport.recentStatus,
            //                                                    "reportCompletionStatus": symptomReport.reportCompletionStatus,
            //                                                    "symptomComparisonState" : symptomReport.symptomComparisonState,
            //                                                    "symptomId" : symptomReport.symptomId,
            //                                                    "symptomName" : symptomReport.symptomName,
            //                                                    "userId" : AuthViewModel.getLoggedInUserId()])
            //TODO: check if change needed
            
            let symptomReportRef = db.collection("remainingReports").document(reportId)
                .collection("symptomReport")
                .document(id)
            do{
                try await symptomReportRef.updateData([
                    "lastModifiedDateTime": symptomReport.lastModifiedDateTime,
                    "rating": symptomReport.rating,
                    "recentStatus": symptomReport.recentStatus,
                    "reportCompletionStatus": symptomReport.reportCompletionStatus,
                    "symptomComparisonState" : symptomReport.symptomComparisonState,
                    //                                                       "symptomId" : symptomReport.symptomId,
                    "symptomName" : symptomReport.symptomName,
                    //"userId" : AuthViewModel.getLoggedInUserId()
                ])
            }
            catch {
                print("Error editing symptom report: \(error.localizedDescription)")
            }
            //            try? await db.collection("remainingReports").document(AuthViewModel.getLoggedInUserId()).collection("symptomReport")
            //                .addDocument(data: ["creationDateTime": symptomReport.creationDateTime,
            //                                    "rating": symptomReport.rating,
            //                                    "recentStatus": symptomReport.recentStatus,
            //                                    "reportCompletionStatus": symptomReport.reportCompletionStatus,
            //                                    "symptomComparisonState" : symptomReport.symptomComparisonState,
            //                                    "symptomId" : symptomReport.symptomId,
            //                                    "symptomName" : symptomReport.symptomName,
            //                                    //"userId" : AuthViewModel.getLoggedInUserId()
            //                                   ])
            
        }
    }
    
    //TODO: Change structure
    func getSuggestedSymptomsofUser(trackedSymptomIds: [String], symptomId: String, date: Date, completion: @escaping (SymptomReport) -> Void) {
        //TODO: get all symptomreports of this user before today that has same symptomid of tracked symptoms

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
                            id:"", dateFormatted: "Aug 20, 2023", creationDateTime: Date.now, lastModifiedDateTime: Date.now, rating: 0, emojiIconName: "ic-incomplete-red-filled", symptomName: "Nausea", symptomComparisonState: "Much Better", reportCompletionStatus: false, recentStatus: "N/A", symptomId: "", userId: "")) //dummy
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

