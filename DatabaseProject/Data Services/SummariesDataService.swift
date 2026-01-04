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
                
                // Fetch the symptomReport subcollection for each report
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
                
                // Fetch the eventReport subcollection for each report

                let eventSnapshot = try await db.collection("remainingReports")
                    .document(document.documentID)
                    .collection("eventReport")
                    .getDocuments()
                
                let events = eventSnapshot.documents.compactMap { doc in
                    try? doc.data(as: EventReport.self)
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
}
