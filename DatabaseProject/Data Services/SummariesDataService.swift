//
//  SummariesDataService.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-04-23.
//

import Foundation
import Firebase
import FirebaseFirestore
import SwiftUICore
import OrderedCollections

class SummariesDataService {
    private var generalViewModel : GeneralViewModel
    init(generalViewModel: GeneralViewModel) {
        self.generalViewModel = generalViewModel
    }

    func getReportsinDateRange(fromDate: Date, toDate: Date, completion: @escaping ([Report]) -> Void) async {
        // Get a reference to the database
        let db = Firestore.firestore()
        let fdate = Timestamp(date: fromDate)
        let tdate = Timestamp(date: toDate)
        let userId = AuthViewModel.getLoggedInUserId()

        do{
            
            let reportSnapshot = try await db.collection("remainingReports")
                .whereField("userId", isEqualTo: userId)
                .whereField("creationDateTime", isGreaterThanOrEqualTo: fdate)
                .whereField("creationDateTime", isLessThan: tdate)
                .order(by: "creationDateTime", descending: true)
                .getDocuments()
            
            var reportsArray: [Report] = []
            
            //TODO: break down this function into reusable functions after incorporating error management
            
            for document in reportSnapshot.documents {
                let reportQuery = try document.data(as: ReportforQuery.self) // Convert Firestore document to Report
                
                // 🔹 Step 2: Fetch the symptomReport subcollection for each report
                let symptomSnapshot = try await db.collection("remainingReports")
                    .document(document.documentID)
                    .collection("symptomReport")
                    .getDocuments()
                
                let symptoms = symptomSnapshot.documents.compactMap { doc in
                    try? doc.data(as: SymptomReport.self)
                }
                var report = Report(from: reportQuery)
//                report.symptomNames = symptoms.compactMap { $0.symptomName }.joined(separator: " , ")
                report.symptomReports = symptoms // Attach symptoms to the report
                report.dayNameofWeek = report.creationDateTime.dayNameOfWeek()
                report.monthNameofWeek = report.creationDateTime.monthandDate()
                report.dateString = report.creationDateTime.datetoString() ?? ""
                
                let eventSnapshot = try await db.collection("remainingReports")
                    .document(document.documentID)
                    .collection("eventReport")
                    .getDocuments()
                
                let events = eventSnapshot.documents.compactMap { doc in
                    try? doc.data(as: Event.self)
                }
                
                report.eventReports = events // Attach events to the report
                
                reportsArray.append(report) // Add the report to the array
            }
            
            DispatchQueue.main.async {
                completion(reportsArray)
            }
            
            print("✅ Successfully fetched reports with symptoms!")
        } catch {
            print("❌ Error fetching reports: \(error.localizedDescription)")
        }
    }
    
    
    
    
    
//
//    func getReportsinDateRange(fromDate: Date, toDate: Date, completion: @escaping ([Report]) -> Void) {
//        // Get a reference to the database
//        let db = Firestore.firestore()
//        
//        let fdate = Timestamp(date: fromDate!)
//        let tdate = Timestamp(date: toDate!)
//        var reportsofUserQuery = db.collection("eventReports")
//            .whereField("userId", isEqualTo: AuthViewModel.getLoggedInUserId())
//            .whereField("creationDateTime", isGreaterThanOrEqualTo: fdate)
//            .whereField("creationDateTime", isLessThan: tdate)
//            .order(by: "creationDateTime", descending: true)
//        
//        if(fromDate==nil) { //for getting all events before a date
//            reportsofUserQuery = db.collection("eventReports")
//                .whereField("userId", isEqualTo: AuthViewModel.getLoggedInUserId())
//                .whereField("creationDateTime", isLessThan: Timestamp(date: toDate!))
//        }
//        
//        reportsofUserQuery.getDocuments { snapshot, error in
//            
//            if snapshot != nil && error == nil {
//                
//                var events = [EventReport]()
//                
//                for doc in snapshot!.documents {
//                    let event = try? doc.data(as: EventReport.self)
//                    
//                    if let event = event {
//                        events.append(event)
//                    }
//                }
//                
//                // Return the data
//                completion(events)
//            }
//            else {
//                print("Error in database retrieval")
//            }
//        }
//    }
//    
}
