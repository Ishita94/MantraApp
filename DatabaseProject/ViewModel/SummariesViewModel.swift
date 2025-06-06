//
//  SummariesViewModel.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-04-23.
//

import Foundation
import Combine
import OrderedCollections
import EmojiPicker

class SummariesViewModel: ObservableObject {
    private var summariesDataService : SummariesDataService
    private let calendar = Calendar.current
    @Published var dateCompontents = DateComponents()
    @Published var weeks: [Week] = []
    @Published var reportListforSummary = [Report]()
    @Published var dictionaryofSymptoms: OrderedDictionary<String , [SymptomReport]> = [:]
    @Published var dictionaryofEvents: OrderedDictionary<String , [Event]> = [:]
    @Published var dictionaryofEmoji: OrderedDictionary<String , Emoji> = [:]
    @Published var selectedWeek: Week? = nil //default value
    var selectedWeekDays: [CustomDateModel] {
        if let selectedWeek = selectedWeek {
            return daysInWeek(start: selectedWeek.start, end: selectedWeek.end)
        }
        else {
            return []
        }
    }

    init(generalViewModel: GeneralViewModel) {
        self.summariesDataService = SummariesDataService(generalViewModel: generalViewModel)
        dateCompontents = calendar.dateComponents( [.year, .month], from: Date())
        Task {
            await getWeeklyBoundaries()
        }
    }
    
    // MARK: - Helpers to set/reset selected week
    func setSelectedWeek (start: Date, end: Date)
    {
        selectedWeek = Week (start: start, end: end)
    }
    
    func resetSelectedWeek ()
    {
        selectedWeek = nil
    }

    // MARK: - Helpers to fetch summary data

    func getReportsinDateRange(fromDate: Date, toDate: Date){
        DispatchQueue.main.async {
            Task{
                await self.summariesDataService.getReportsinDateRange(fromDate: fromDate, toDate: toDate) { reportsofUser in
                    self.reportListforSummary = reportsofUser
                    self.prepareDictionaries(reportsofUser: reportsofUser)
                    self.selectedWeek = Week (start: fromDate, end: toDate)
                    self.setSelectedWeek(start: fromDate, end: toDate)
                }
            }
        }
    }
    
    private func prepareDictionaries(reportsofUser: [Report]){
        let groupedSymptomsByName = OrderedDictionary(grouping: reportsofUser.flatMap { $0.symptomReports }, by: \.symptomName)
            .mapValues { (reports: [SymptomReport]) in
                reports.sorted { $0.creationDateTime < $1.creationDateTime }

            }
        dictionaryofSymptoms = groupedSymptomsByName
        
        let groupedEventsByName = OrderedDictionary(grouping: reportsofUser.flatMap { $0.eventReports }, by: \.title)
            .mapValues { (reports: [Event]) in
                reports.sorted { $0.creationDateTime < $1.creationDateTime }
            }
        dictionaryofEvents = groupedEventsByName
        
        let sortedEmojis: OrderedDictionary<String, Emoji> = OrderedDictionary(
            uniqueKeysWithValues:
                reportsofUser
                    .sorted { $0.creationDateTime < $1.creationDateTime }
                    .map { report in
                        (report.creationDateTime.datetoString() ?? "", Emoji(value: report.emojiValue, name: report.emojiStateofDay))
                    }
        )
        dictionaryofEmoji = sortedEmojis
    }
    
    func getDictionaryofEventsbyDate() -> OrderedDictionary<String, [Event]> {
        let events = reportListforSummary
            .flatMap { $0.eventReports }
            .compactMap { event -> Event? in
                event.creationDateTime.datetoString() != nil ? event : nil
            }

        let groupedEvents = OrderedDictionary(
            grouping: events,
            by: { $0.creationDateTime.datetoString()! } // safe now because nils are filtered
        ).mapValues { $0.sorted { $0.creationDateTime < $1.creationDateTime } }

        return groupedEvents
    }


    // MARK: - Date formatting methods
    
    func monthAndYearFormatted() -> String? {
        guard let date = calendar.date(from: dateCompontents) else { return nil }
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
    func formatStringfromWeek(_ week: Week) -> String {
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d"
            return "\(formatter.string(from: week.start)) - \(formatter.string(from: week.end))"
        }
    func formatStringfromWeekwithYear(_ week: Week) -> String {
        let startYear = Calendar.current.component(.year, from: week.start)
        let endYear = Calendar.current.component(.year, from: week.end)
        
        let dateFormatter = DateFormatter()
        let yearFormatter = DateFormatter()
        yearFormatter.dateFormat = "yyyy"
        if(startYear==endYear)
        {
            dateFormatter.dateFormat = "MMM d"
            return "\(dateFormatter.string(from: week.start)) - \(dateFormatter.string(from: week.end)), \(yearFormatter.string(from: week.start))"
        }
        else
        {
            dateFormatter.dateFormat = "MMM d, yyyy"
            return "\(dateFormatter.string(from: week.start)) - \(dateFormatter.string(from: week.end))"
        }
        }
    
    // MARK: - Month-related methods

    func showingNextMonth() -> Bool {
        let currentMonth = calendar.component(.month, from: Date())
        if let month = dateCompontents.month, month<currentMonth
        {
            return true
        }
        return false
    }
    
    func incrementMonth() -> Bool {
        return updateMonth(by: 1)
    }
    
    func decrementMonth() -> Bool {
        return updateMonth(by: -1)
    }
    private func updateMonth(by offset: Int) -> Bool{
        guard let currentDate = calendar.date(from: dateCompontents),
              let newDate = calendar.date(byAdding: .month, value: offset, to: currentDate) else {
            return false
        }
        
        let todayComponents = calendar.dateComponents([.year, .month], from: Date())
        
        // Don't allow months beyond today's month
        if offset > 0 {
            // Check if new date would be in the future
            let newComponents = calendar.dateComponents([.year, .month], from: newDate)
            if (newComponents.year! > todayComponents.year!) ||
                (newComponents.year == todayComponents.year && newComponents.month! > todayComponents.month!) {
                return false// return nil if it goes beyond today
            }
        }
        
        // Valid month — update
        dateCompontents = calendar.dateComponents(in: TimeZone.current, from: newDate)

//        dateCompontents = calendar.dateComponents([.year, .month, .weekOfYear, .yearForWeekOfYear], from: newDate)
        return true
    }
    
    // MARK: - Week-related methods
    
    func showingNextWeek() -> Bool {
        let currentWeek = calendar.component(.weekOfYear, from: Date())
        let currentYear = calendar.component(.yearForWeekOfYear, from: Date())

        guard
                let week = dateCompontents.weekOfYear,
                let year = dateCompontents.yearForWeekOfYear
            else {
                return false
            }

            if year < currentYear {
                return true // clearly before
            } else if year == currentYear {
                return week < currentWeek // same year,selected week is before current week, so next button should be enabled
            } else {
                return false // future year
            }
    }
    func incrementWeek() -> Bool {
        return updateWeek(by: 1)
    }
    
    func decrementWeek() -> Bool {
        return updateWeek(by: -1)
    }
    private func updateWeek(by offset: Int) -> Bool{
        guard let currentDate = calendar.date(from: dateCompontents),
                 let newDate = calendar.date(byAdding: .weekOfYear, value: offset, to: currentDate) else {
               return false
           }
        
        let todayComponents = calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: Date())
        
        // Don't allow months beyond today's month
        if offset > 0 {
            // Check if new date would be in the future
            let newComponents = calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: newDate)
            if (newComponents.yearForWeekOfYear! > todayComponents.yearForWeekOfYear!) ||
                (newComponents.yearForWeekOfYear == todayComponents.yearForWeekOfYear && newComponents.weekOfYear! > todayComponents.weekOfYear!) {
                return false// return nil if it goes beyond today
            }
        }
        
        // Valid week — update
        dateCompontents = calendar.dateComponents(in: TimeZone.current, from: newDate)
        //TODO: update week variables
        return true
    }
    func daysInWeek(start: Date, end: Date) -> [CustomDateModel] {
        var dates: [CustomDateModel] = []
        var currentDate = start

        while currentDate <= end {
            let dateObject = CustomDateModel(date: currentDate, shortDay: currentDate.dayNameOfWeek(), monthandDate: currentDate.monthandDate(), dateString: currentDate.datetoString() ?? "")
            dates.append(dateObject)
            guard let nextDay = calendar.date(byAdding: .day, value: 1, to: currentDate) else {
                break
            }
            currentDate = nextDay
        }
        return dates
    }
    func getWeeklyBoundaries() async -> () {
        let weekarray = calculateWeeklyBoundaries()
        await MainActor.run {
            self.weeks = weekarray
        }
    }
        
    func calculateWeeklyBoundaries() -> [Week] {
        var placeHolder : DateComponents = dateCompontents

        guard let startOfMonth = calendar.date(from: placeHolder),
              let range = calendar.range(of: .day, in: .month, for: startOfMonth) else {
            return []
        }
        
        // Find the start of the first visible week (safe)
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: startOfMonth)?.start ?? startOfMonth

        // Get end of the month
        placeHolder.day = range.count
        guard let endOfMonth = calendar.date(from: placeHolder) else {
            return []
        }
        
//        let endOfWeek = calendar.nextDate(after: endOfMonth,
//                                          matching: DateComponents(weekday: 7),
//                                          matchingPolicy: .nextTimePreservingSmallerComponents) ?? endOfMonth
        // Find the end of the week containing today/end of that month - whichever one comes earlier
        let endOfMonthWeekEnd = calendar.dateInterval(of: .weekOfYear, for: endOfMonth)?.end ?? endOfMonth
        let todayWeekEnd = calendar.dateInterval(of: .weekOfYear, for: Date())?.end ?? Date()

        let endOfWeek = min(endOfMonthWeekEnd, todayWeekEnd)
        
        // Build full weeks from Sunday to Saturday
        var boundaries: [Week] = []
        var currentStart = startOfWeek
        
        while currentStart < endOfWeek {
            let currentEnd = calendar.date(byAdding: .day, value: 6, to: currentStart)!
            boundaries.append(Week(start: currentStart, end: currentEnd))
            currentStart = calendar.date(byAdding: .day, value: 7, to: currentStart)!
        }
        return boundaries
    }
    
    //MARK: - Reset variables
    
    func resetDateComponents(){
        dateCompontents = calendar.dateComponents(in: TimeZone.current, from: Date())
    }
    
    
}
