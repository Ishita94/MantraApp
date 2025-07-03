//
//  EventDataService.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-12-23.
//

import Foundation
import Firebase
import FirebaseFirestore

struct EventDataService {
    private var generalViewModel : GeneralViewModel

    init(generalViewModel: GeneralViewModel) {
           self.generalViewModel = generalViewModel
       }
    
    func getEventsinReport (report: Report) async -> [Event] {
        
        // Get a reference to the database
        let db = Firestore.firestore()
//        var finalReport = report //keep remaining fields of selectedreport intact and reduces a call to remainingreports table
        var eventsinReport: [Event] = []
        do{
            if let id = report.id {
                //retrieve events in this report, sorted by most recent
                let reportedEventSnapshot = try await db.collection("remainingReports").document(id)
                    .collection("eventReport")
                    .order(by: "lastModifiedDateTime", descending: true)
                    .getDocuments()
                
                //create a dictionary of events in this report
                let mapofEventReports: [String: EventReport] = Dictionary(uniqueKeysWithValues:
                    reportedEventSnapshot.documents.compactMap {
                        guard let report = try? $0.data(as: EventReport.self) else { return nil }
                        return (report.eventId, report)
                    }
                )

                if(!mapofEventReports.isEmpty)
                {
                    let reportedEventIds = Array(mapofEventReports.keys)
                    let chunkedIds = reportedEventIds.chunked(into: 10) //to handle swiftUI restriction of 10 element max in 'in'
                    let userId = report.userId
                    
                    for chunk in chunkedIds {
                        let eventSnapshot = try await db.collection("events") //fetch event details of reported events in this report
                            .whereField("userId", isEqualTo: userId)
                            .whereField(FieldPath.documentID(), in: chunk)//whose document ids match those events reported in this report
                            .getDocuments()
                        
                        var events = eventSnapshot.documents.compactMap { doc in
                            try? doc.data(as: Event.self)
                        }
                        for i in 0..<events.count {
                            let event = events[i]
                            if let matchingReport = mapofEventReports[event.id!] { //create a complete, detailed array of events in this report
                                events[i].creationDateTime = matchingReport.creationDateTime
                                events[i].lastModifiedDateTime = matchingReport.lastModifiedDateTime
                                events[i].eventId = events[i].id //set the id as eventId
                                events[i].id = matchingReport.id //set id to eventReport id
                            }
                        }
                        eventsinReport += events
                    }
                }
            }
        } catch {
            print("❌ Error fetching events in the report with id \(String(describing: report.id)): \(error.localizedDescription)")
        }
        return eventsinReport
    }
    
    func getSuggestedEventsofUser() async -> [Event] {
        
        
        // Get a reference to the database
        let db = Firestore.firestore()
        var eventsofUser: [Event] = []
        do{
            let eventSnapshot = try await db.collection("events") //fetch all events
                .whereField("userId", isEqualTo: AuthViewModel.getLoggedInUserId())
                .order(by: "creationDateTime", descending: true)
                .getDocuments()
            
            eventsofUser = eventSnapshot.documents.compactMap { doc in
                try? doc.data(as: Event.self)
            }
        
        } catch {
            print("❌ Error fetching suggested events: \(error.localizedDescription)")
        }
        return eventsofUser
    }
    
    func setEventReport(events: [EventReport]) async{
        // Get reference to database
        let db = Firestore.firestore()
        
        // Add document in eventReport subcollection
        do{
            let batch = db.batch()
            let reportId = generalViewModel.selectedReport.id!
            let reportRef = db.collection("remainingReports").document(reportId)

            for var event in events {
                let eventRef = reportRef.collection("eventReport").document()
                event.id = eventRef.documentID // store the auto-ID in the model if needed
                try batch.setData(from: event, forDocument: eventRef)
            }
            try await batch.commit()
        } catch {
            print("❌ Error adding events to a report: \(error.localizedDescription)")
        }
    }
    
    
    func editEvent(event: Event) async{
        
        // Get reference to database
        let db = Firestore.firestore()
        do{
            if let id=event.id
            {
                let reportId = generalViewModel.selectedReport.id!
                let eventReportRef = db.collection("remainingReports").document(reportId).collection("eventReport").document(id)
                try? await eventReportRef.updateData(["lastModifiedDateTime": Date.now])
                
                if let eventId = event.eventId{
                    let eventRef = db.collection("events").document(eventId)
                    try? await eventRef.updateData(["lastModifiedDateTime": Date.now,
                                                    "title": event.title,
                                                    "category": event.category
                                                    ])
                }
            }
        } catch {
            print("❌ Error editing event: \(error.localizedDescription)")
        }
    }
    
    func setEvent(event: Event) async{
        // Get reference to database
        let db = Firestore.firestore()
        
        // Add document
        do{
            try? await db.collection("events")
                .addDocument(data: ["creationDateTime": event.creationDateTime,
                                    "lastModifiedDateTime": event.lastModifiedDateTime,
                                    "title": event.title,
                                    "category": event.category,
                                    "tracking": false,
                                    "userId" : event.userId])
        }
        catch {
            print("❌ Error adding events to a report: \(error.localizedDescription)")
        }
    }
    
//    func editEvent(event: Event) async{
//        
//        // Get reference to database
//        let db = Firestore.firestore()
//       
//        // Edit Event
//        let eventQuery = db.collection("events")
//            .whereField("title", isEqualTo: event.title)
//            .whereField("userId", isEqualTo: AuthViewModel.getLoggedInUserId())
//            
//        
//        eventQuery.getDocuments { snapshot, error in
//            
//            if snapshot != nil && error == nil {
//                for doc in snapshot!.documents {
//                    print("-----------------")
//                    print(doc.data())
//                    //                    let date = doc.get("creationDateTime") as! Timestamp
//                    let eventItem = try? doc.data(as: Event.self)
//                    
//                    // Add the chat into the array
//                    if let item = eventItem {
//                        Task{
//                            let eventRef = db.collection("events").document(item.id!)
//                            try? await eventRef.updateData(["creationDateTime": Date.now,
//                                                            "title": event.title,
//                                                            "category": event.category,
//                                                            "tracking": false,
//                                                            "userId" : AuthViewModel.getLoggedInUserId()])
//                        }
//                    }
//                }
//            }
//            else {
//                print("Error in database retrieval")
//            }
//        }
//    }
    
}
