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
    
    func getSuggestedEventsofUser(completion: @escaping ([Event]) -> Void) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        let reportsofUserQuery = db.collection("events")
            .whereField("userId", isEqualTo: AuthViewModel.getLoggedInUserId())
            .order(by: "creationDateTime", descending: true)
        
        reportsofUserQuery.getDocuments { snapshot, error in
            
            if snapshot != nil && error == nil {
                
                var events = [Event]()
                
                // Loop through all the returned chat docs
                for doc in snapshot!.documents {
                    print("-----------------")
                    print(doc.data())
                    let event = try? doc.data(as: Event.self)
                    
                    if let eventSuggestion = event {
                        events.append(eventSuggestion)
                    }
                }
                
                // Return the data
                completion(events)
            }
            else {
                print("Error in database retrieval")
            }
        }
    }
    
    
    func getReportedEventsbyDateRange(fromDate: Date?, toDate: Date?, completion: @escaping ([EventReport]) -> Void) {
        
        // Get a reference to the database
        let db = Firestore.firestore()
        
        let fdate = Timestamp(date: fromDate!)
        let tdate = Timestamp(date: toDate!)
        var reportsofUserQuery = db.collection("eventReports")
            .whereField("userId", isEqualTo: AuthViewModel.getLoggedInUserId())
            .whereField("creationDateTime", isGreaterThanOrEqualTo: fdate)
            .whereField("creationDateTime", isLessThan: tdate)
            .order(by: "creationDateTime", descending: true)
        
        if(fromDate==nil) { //for getting all events before a date
            reportsofUserQuery = db.collection("eventReports")
                .whereField("userId", isEqualTo: AuthViewModel.getLoggedInUserId())
                .whereField("creationDateTime", isLessThan: Timestamp(date: toDate!))
        }
        
        reportsofUserQuery.getDocuments { snapshot, error in
            
            if snapshot != nil && error == nil {
                
                var events = [EventReport]()
                
                for doc in snapshot!.documents {
                    let event = try? doc.data(as: EventReport.self)
                    
                    if let event = event {
                        events.append(event)
                    }
                }
                
                // Return the data
                completion(events)
            }
            else {
                print("Error in database retrieval")
            }
        }
    }
    
    //TODO: need to update dates for all function below and check if everything works
    func setEventReport(event: Event) async{
        
        // Get reference to database
        let db = Firestore.firestore()
        
        // Add document
        try? await db.collection("eventReports")
            .addDocument(data: ["creationDateTime": Date.now,
                                "title": event.title,
                                "category": event.category,
                                "reportCompletionStatus": false,
                                "userId" : AuthViewModel.getLoggedInUserId()])
    }
    
    func setEvent(event: Event) async{
        
        // Get reference to database
        let db = Firestore.firestore()
        
        // Add document
        
        try? await db.collection("events")
            .addDocument(data: ["creationDateTime": Date.now,
                                "title": event.title,
                                "category": event.category,
                                "tracking": false,
                                "userId" : AuthViewModel.getLoggedInUserId()])
        
    }
    
    func editEventandEventReport(event: Event, eventReport: EventReport) async{
        
        // Get reference to database
        let db = Firestore.firestore()
        if let id=eventReport.id
        {
            let eventRef = db.collection("eventReports").document(id)
            try? await eventRef.updateData(["creationDateTime": Date.now,
                                            "title": event.title,
                                            "category": event.category,
                                            "reportCompletionStatus": false,
                                            "userId" : AuthViewModel.getLoggedInUserId()])
        }
    }
    
    func editEvent(event: Event) async{
        
        // Get reference to database
        let db = Firestore.firestore()
       
        // Edit Event
        let eventQuery = db.collection("events")
            .whereField("title", isEqualTo: event.title)
            .whereField("userId", isEqualTo: AuthViewModel.getLoggedInUserId())
            
        
        eventQuery.getDocuments { snapshot, error in
            
            if snapshot != nil && error == nil {
                for doc in snapshot!.documents {
                    print("-----------------")
                    print(doc.data())
                    //                    let date = doc.get("creationDateTime") as! Timestamp
                    let eventItem = try? doc.data(as: Event.self)
                    
                    // Add the chat into the array
                    if let item = eventItem {
                        Task{
                            let eventRef = db.collection("events").document(item.id!)
                            try? await eventRef.updateData(["creationDateTime": Date.now,
                                                            "title": event.title,
                                                            "category": event.category,
                                                            "tracking": false,
                                                            "userId" : AuthViewModel.getLoggedInUserId()])
                        }
                    }
                }
            }
            else {
                print("Error in database retrieval")
            }
        }
    }
}
