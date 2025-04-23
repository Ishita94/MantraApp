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
import OrderedCollections


class SymptomDataService {
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
    
    
    func getTrackedSymptomsofUser () async -> [Symptom] {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        var trackedSymptoms = [Symptom]()
        
        do{
            // Perform a query against the chat collection for any chats where the user is a participant
            let symptomSnapshot = try await db.collection("symptoms")
                .whereField("userId",
                            isEqualTo: AuthViewModel.getLoggedInUserId())
                .whereField("tracking",
                            isEqualTo: true)
                .order(by: "creationDateTime", descending: false)
                .getDocuments()
            
            
            trackedSymptoms = symptomSnapshot.documents.compactMap { doc in
                try? doc.data(as: Symptom.self)
            }
        } catch {
            print("❌ Error fetching tracked symptoms: \(error.localizedDescription)")
        }
        return trackedSymptoms
    }
    
    func getSymptomsinReport (report: Report) async -> Report {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        var finalReport = report //keep remaining fields of selectedreport intact and reduces a call to remainingreports table
        
        do{
            // Perform a query against the chat collection for any chats where the user is a participant
            if let id = report.id {
                let symptomSnapshot = try await db.collection("remainingReports").document(id)
                    .collection("symptomReport")
                    .order(by: "lastModifiedDateTime", descending: true)
                    .getDocuments()
                
                finalReport.symptomReports = symptomSnapshot.documents.compactMap { doc in
                    try? doc.data(as: SymptomReport.self)
                }
            }
        } catch {
            print("❌ Error fetching symptoms in the report with id \(String(describing: report.id)): \(error.localizedDescription)")
        }
        return finalReport
    }
    
    func createNewReport(existingReport: Report?) async{
        // Get reference to database
        let db = Firestore.firestore()
        
        Task{
            if let existingReport = existingReport{
                await MainActor.run{
                    self.generalViewModel.selectedReport = existingReport //the existing report will get loaded
                }
            }
            else{
                var report : Report = Report()
                var reportRef: DocumentReference = db.collection("remainingReports").document() // Auto-generated document ID
                report.id = reportRef.documentID
                report.userId = AuthViewModel.getLoggedInUserId()
                do
                {
                    try await reportRef.setData(from: report)
                    await MainActor.run{
                        self.generalViewModel.selectedReport = report //so that there will always be a selected report
                    }
                }
                catch {
                    print("Error creating new report: \(error.localizedDescription)")
                }
            }
        }
    }
    
    func setNewSymptomofUser(symptomReport: SymptomReport) async {
        let db = Firestore.firestore()
        
        // Create a new symptom
        let status = symptomReport.rating==0 ? "Resolved" : "Tracked"
        let newSymptomAdded = try? await db.collection("symptoms")
            .addDocument(data: ["creationDateTime": symptomReport.creationDateTime,
                                "lastModifiedDateTime": symptomReport.lastModifiedDateTime,
                                "symptomName": symptomReport.symptomName,
                                "status": status, //set to 'tracked' when created with a rating!=0
                                "tracking": true, //set to track when created
                                "userId" : AuthViewModel.getLoggedInUserId()])
        
        guard let symptomId = newSymptomAdded!.documentID as String? else {
            print("❌ Error: Failed to retrieve new symptom document ID")
            return
        }
        
        // Create a new symptom report for this symptom
        var placeholder = symptomReport
        placeholder.symptomId = symptomId
        await setSymptomReportofTrackedSymptom (symptomReport: placeholder, firstreportofSymptom: true)
        
        //            await self.setNewSymptomReportofUser(symptomReport: symptomReport, newSymptomAdded: newSymptomAdded!)
        
    }
    
    func resolveSymptom(id: String) async {
        let db = Firestore.firestore()
        do{
            let symptomRef = db.collection("symptoms").document(id)
            
            try await symptomRef.updateData([
                "lastModifiedDateTime": Date.now,
                "status": "Resolved"
            ])
        }
        catch {
            print("Error editing symptom: \(error.localizedDescription)")
        }
    }
    
    func changeStatusofSymptom(id: String, rating: Int) async {
        let db = Firestore.firestore()
            let symptomRef = try await db.collection("symptoms").document(id)
        do{
            let symptom = try await symptomRef.getDocument(as: Symptom.self)
            let newStatus: String? = {
                        if rating == 0 && symptom.status != "Resolved" {
                            return "Resolved"
                        } else if rating != 0 && symptom.status == "Resolved" {
                            return "Tracked"
                        } else {
                            return nil
                        }
                    }()
            
            if let status = newStatus {
                       try await symptomRef.updateData([
                        "lastModifiedDateTime": Date.now,
                           "status": status
                       ])
                   }
        }
        catch {
            print("Error editing symptom: \(error.localizedDescription)")
        }
    }
    
    func setSymptomReportofTrackedSymptom(symptomReport: SymptomReport, firstreportofSymptom: Bool) async{
        
        // Get reference to database
        let db = Firestore.firestore()
      
        Task{
            var reportRef: DocumentReference
            var symptomPlaceholder = symptomReport
            do {
                if let reportId = generalViewModel.selectedReport.id { //Report exists for that date
                    reportRef = db.collection("remainingReports").document(reportId)
                    let symptomRef = reportRef.collection("symptomReport").document()
                    symptomPlaceholder.id = symptomRef.documentID
                    try await symptomRef.setData(from: symptomPlaceholder)
                    //                self.generalViewModel.addSymptomReporttoSelectedReport(symptomReport: symptomPlaceholder)
                    if symptomReport.rating==0, firstreportofSymptom==false{ //this symptom report originates from a symptom suggestion, so need to resolve the symptom in Symptoms table if needed
                        try await resolveSymptom(id: symptomReport.symptomId!)
                    }
                    let updatedReport = await getSymptomsinReport(report: self.generalViewModel.selectedReport)
                    await MainActor.run{
                        self.generalViewModel.selectedReport = updatedReport
                    }
                }
            }
            catch {
                print("Error adding report or new symptom report: \(error.localizedDescription)")
            }
        }
    }
    
    func editSymptomReport(symptomReport: SymptomReport) async{
        // Get reference to database
        let db = Firestore.firestore()
        
        
        if let id=symptomReport.id, let reportId = generalViewModel.selectedReport.id { //Report exists and the symptomreport exists in it
            let symptomReportRef = db.collection("remainingReports").document(reportId)
                .collection("symptomReport")
                .document(id)
            do{
                //TODO: Update lastmodifieddatetime of report
                try await symptomReportRef.updateData([
                    "lastModifiedDateTime": symptomReport.lastModifiedDateTime,
                    "rating": symptomReport.rating,
                    "recentStatus": symptomReport.recentStatus,
                    "reportCompletionStatus": symptomReport.reportCompletionStatus,
                    "symptomComparisonState" : symptomReport.symptomComparisonState,
                    "symptomName" : symptomReport.symptomName,
                ])
                try await changeStatusofSymptom(id: symptomReport.symptomId!, rating: symptomReport.rating)
                Task{
                    let updatedReport = await getSymptomsinReport(report: self.generalViewModel.selectedReport)
                    await MainActor.run{
                        self.generalViewModel.selectedReport = updatedReport
                    }
                }
            }
            catch {
                print("Error editing symptom report: \(error.localizedDescription)")
            }
        }
    }
    
    func getSuggestedSymptomsofUser(trackedSymptomIds: [String], reportList: [Report], date: Date) async -> (OrderedDictionary<Date , SymptomReport>){
        let db = Firestore.firestore()
//        let tdate = Timestamp(date: date)
        let reportsPriorthisDate = reportList.filter { $0.creationDateTime < date }

        var symptomReportsPriorthisDate: [SymptomReport] = []
        var dictionaryofSuggestedReports: OrderedDictionary<Date , SymptomReport> = [:]
        let symptomReportsinSelectedReport = generalViewModel.selectedReport.symptomReports

        do{
            for report in reportsPriorthisDate {
                // 🔹 Step 2: Fetch the symptomReport subcollection for each report
                if let unwrappedReportId = report.id{
                    let symptomSnapshot = try await db.collection("remainingReports")
                        .document(unwrappedReportId)
                        .collection("symptomReport")
                        .whereField("symptomId", in: trackedSymptomIds)
                        .getDocuments()
                    
                    let symptoms = symptomSnapshot.documents.compactMap { doc in
                        try? doc.data(as: SymptomReport.self)
                    }
                    symptomReportsPriorthisDate.append(contentsOf: symptoms)
                }
            }
            //Create a dictionary of symptoms prior that date by symtom ids and sort each group
            let groupedAndSortedSymptomReportDictionary = Dictionary(grouping: symptomReportsPriorthisDate, by: { $0.symptomId })
                .mapValues { reports in
                    reports.sorted(by: { $0.creationDateTime > $1.creationDateTime })  // Newest symptomreport first in a group
                }

            //create Dictionary and exclude reports of sympmtoms already reported that day
            for group in groupedAndSortedSymptomReportDictionary{
                let alreadyReported = symptomReportsinSelectedReport.contains{$0.symptomId == group.key}
                if !alreadyReported, let firstReport = group.value.first
                {
                    dictionaryofSuggestedReports[firstReport.lastModifiedDateTime] = firstReport //include newest report in suggestion
                }
            }
            
            //final sort of suggestions by date
            dictionaryofSuggestedReports = OrderedDictionary(
                uniqueKeysWithValues: dictionaryofSuggestedReports.sorted(by: { $0.key > $1.key })
            )
        } catch {
            print("❌ Error fetching symptomReports of the prior reports: \(error.localizedDescription)")
        }
        return dictionaryofSuggestedReports
    }
 
                
        
        //        let reportsofUserQuery = db.collection("symptomReports")
        //                .whereField("userId", isEqualTo: AuthViewModel.getLoggedInUserId())
        //                .whereField("symptomId", isEqualTo: symptomId)
        //                .whereField("creationDateTime", isLessThan: tdate)
        //                .order(by: "creationDateTime", descending: false)
        //                .limit(toLast: 1)
        //            ;
        //
        //            reportsofUserQuery.getDocuments { snapshot, error in
        //
        //                if snapshot != nil && error == nil {
        //
        //                    var symptomReports = [SymptomReport]()
        //
        //                    // Loop through all the returned chat docs
        //                    for doc in snapshot!.documents {
        //                        print("-----------------")
        //                        print(doc.data())
        //                        //                    let date = doc.get("creationDateTime") as! Timestamp
        //                        //                    let rating = doc.get("rating") as! Int
        //                        //                    let symptomId = doc.get("symptomId") as! String
        //                        //                    let symptomComparisonState=doc.get("symptomComparisonState") as! String
        //                        //                    let reportCompletionStatus=doc.get("reportCompletionStatus") as! Bool
        //                        //                    let recentStatus=doc.get("recentStatus") as! String
        //                        // Parse the data into Chat structs
        //                        let symptomReport = try? doc.data(as: SymptomReport.self)
        //
        //                        if var symptomReport = symptomReport {
        //                            symptomReport.dateString = symptomReport.creationDateTime.datetoString()
        //                            symptomReports.append(symptomReport)
        //                        }
        //                    }
        //
        //                    // Return the data
        //                    if(symptomReports.isEmpty) {
        //                        completion(SymptomReport(
        //                            id:"", dateFormatted: "Aug 20, 2023", creationDateTime: Date.now, lastModifiedDateTime: Date.now, rating: 0, emojiIconName: "ic-incomplete-red-filled", symptomName: "Nausea", symptomComparisonState: "Much Better", reportCompletionStatus: false, recentStatus: "N/A", symptomId: "", userId: "")) //dummy
        //                    }
        //                    else{
        //                        completion(symptomReports[0])
        //                    }
        //                }
        //                else {
        //                    print("Error in database retrieval")
        //                }
        //            }
        //        }
        //
        
    }
    
