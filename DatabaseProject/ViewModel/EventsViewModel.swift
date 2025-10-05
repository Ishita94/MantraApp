//
//  EventController.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-10-30.
//

import Foundation
import Combine
import OrderedCollections

class EventsViewModel: ObservableObject {
    
    @Published var reportedEvents = [Event]()
//    @Published var dictionaryofEvents: OrderedDictionary<String , [EventReport]> = [:]
    @Published var reportedEventsofUserbyDate = [EventReport]()
    private var eventDataService : EventDataService
    
    
    init(generalViewModel: GeneralViewModel) {
        self.eventDataService = EventDataService(generalViewModel: generalViewModel)
    }
    
    @Published var suggestedEvents: [Event] = []
    
    func getEventsinReport(report: Report){
        DispatchQueue.main.async {
            Task{
                self.reportedEvents = await self.eventDataService.getEventsinReport(report: report)
            }
        }
    }
    
    func getSuggestedEvents(){
        DispatchQueue.main.async {
            Task{
                let eventsofUser = await self.eventDataService.getSuggestedEventsofUser()
                let reportedEventIds  = Set(self.reportedEvents.map { $0.eventId })
                let suggestedEvents = eventsofUser.filter { !reportedEventIds.contains($0.id) }
                self.suggestedEvents = suggestedEvents
            }
        }
    }
    
    func saveEventReport(events: [EventReport]){
        DispatchQueue.main.async {
            Task{
                await self.eventDataService.setEventReport(events: events)

            }
        }
    }
    
    func saveEvent(event: Event){
        DispatchQueue.main.async {
            Task{
                if let id = event.id{//edit event report
                    await self.eventDataService.editEvent(event: event)
                }
                else //new event
                {
                    await self.eventDataService.setEvent(event: event)
                }
            }
        }
    }
    
//    func getEventsReportedonDate(date: Date){
//        let formattedFromDate: Date? = prepareDatefromDate(date: date)
//        let formattedToDate: Date? = prepareNextDate(date: formattedFromDate!)
//        
//        DispatchQueue.main.async {
//            self.eventDataService.getReportedEventsbyDateRange(fromDate: formattedFromDate!, toDate: formattedToDate!) { events in
//                
//                // Update the UI in the main thread
//                self.reportedEventsofUserbyDate = events
//                
//            }
//            
//        }
//    }    
   
}
