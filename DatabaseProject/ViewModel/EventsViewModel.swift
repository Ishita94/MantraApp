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
    
    @Published var reportedEventsofUserbyDate = [EventReport]()
    @Published var reportedEvents = [EventReport]()
    @Published var dictionaryofEvents: OrderedDictionary<String , [EventReport]> = [:]
    
    var definedEventList: [Event] = [
        Event(title: "Went on a walk", category: "Physical Well-Being", creationDateTime: Date.now, userId: "", tracking: false),
        Event(title: "Yoga", category: "Physical Well-Being", creationDateTime: Date.now, userId: "", tracking: false),
        Event(title: "Took heart medication", category: "Physical Well-Being", creationDateTime: Date.now, userId: "", tracking: false),
        Event(title: "Visited friends", category: "Emotional Well-Being", creationDateTime: Date.now, userId: "", tracking: false),
        Event(title: "Watched a funny movie", category: "Emotional Well-Being", creationDateTime: Date.now, userId: "", tracking: false),
        Event(title: "Gloomy weather", category: "Miscellaneous", creationDateTime: Date.now, userId: "", tracking: false)
    ]
    
    @Published var suggestedEvents: [Event] = []
    
    init() {
    }
    
    
    func getEventsReportedonDate(date: Date){
        let formattedFromDate: Date? = prepareDatefromDate(date: date)
        let formattedToDate: Date? = prepareNextDate(date: formattedFromDate!)
        
                DispatchQueue.main.async {
                    EventDataService().getReportedEventsbyDateRange(fromDate: formattedFromDate!, toDate: formattedToDate!) { events in
                        
                        // Update the UI in the main thread
                            self.reportedEventsofUserbyDate = events
                        
                    }
                    
                }
            }

    //TODO: to be used in Summaries pages
    func getEventsReportedonDateRange(fromDate: Date?, toDate: Date){
        DispatchQueue.main.async {
            var preparedFromDate:Date? = nil;
            if(fromDate!==nil)
            {
                preparedFromDate = prepareDatefromDate(date: fromDate!)
            }
            let preparedToDate:Date? = prepareDatefromDate(date: toDate)

            EventDataService().getReportedEventsbyDateRange(fromDate: preparedFromDate, toDate: preparedToDate) { events in
                self.reportedEvents = events
            }
        }
    }
    
    func saveEventReport(events: [Event]){
        DispatchQueue.main.async {
            for event in events{
                Task{
                    await EventDataService().setEventReport(event: event)
                }
            }
        }
    }
    
    func saveEvent(event: Event, eventReport: EventReport?){
        DispatchQueue.main.async {
                Task{
                    if let report = eventReport{//edit
                        await EventDataService().editEventandEventReport(event: event, eventReport: report)
                        await EventDataService().editEvent(event: event)
                    }
                    else //new event
                    {
                        await EventDataService().setEvent(event: event)
                    }
                }
        }
    }
    
    //TODO: get suggested events
    
    func getSuggestedEvents(){
        DispatchQueue.main.async {
            EventDataService().getSuggestedEventsofUser() { [self] events in
                var list = [Event]()
                for item in events
                {
                    if(!reportedEventsofUserbyDate.contains(where: { $0.id == item.id})) { //event is not already reported in this date
                        list.append(item)
                    }
                    else
                    {
                        
                    }
                }
                self.suggestedEvents = list
            }
        }
    }
}
