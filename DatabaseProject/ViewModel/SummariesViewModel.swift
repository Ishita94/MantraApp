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
    @Published var dictionaryofEvents: OrderedDictionary<String , [EventReport]> = [:]
    @Published var dictionaryofEventsbyDate: OrderedDictionary<String , [EventReport]> = [:]
    @Published var dictionaryofEmoji: OrderedDictionary<String , Emoji> = [:]
    @Published var selectedWeek: Week? = nil //default value
    
    //create array of all days in a week
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
            .mapValues { (reports: [EventReport]) in
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
    
    func setDictionaryofEventsbyDate(showEvents: [String]) -> () {
        let events = self.reportListforSummary
            .flatMap { $0.eventReports }
            .compactMap { event -> EventReport? in
                if event.creationDateTime.datetoString() != nil, showEvents.contains(event.title)
                {
                    return event
                }
                else {
                    return nil
                }
            }

        let groupedEvents = OrderedDictionary(
            grouping: events,
            by: { $0.creationDateTime.datetoString()! } // safe now because nils are filtered
        ).mapValues { $0.sorted { $0.creationDateTime < $1.creationDateTime } }

        dictionaryofEventsbyDate = groupedEvents ?? [:]
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
        let startYear = calendar.component(.year, from: week.start)
        let endYear = calendar.component(.year, from: week.end)
        
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
        let currentYear = calendar.component(.year, from: Date())
        guard
                let month = dateCompontents.month,
                let year = dateCompontents.year
            else {
                return false
            }
        
        return (year < currentYear) || (year == currentYear && month < currentMonth)
    }
    
    func incrementMonth() -> Bool {
        return updateMonth(by: 1)
    }
    
    func decrementMonth() -> Bool {
        return updateMonth(by: -1)
    }
    private func updateMonth(by offset: Int) -> Bool {
        guard let currentDate = calendar.date(from: dateCompontents),
              let currentMonthInterval = calendar.dateInterval(of: .month, for: currentDate) else {
            return false
        }

        let alignedCurrentDate = currentMonthInterval.start

        guard let newDate = calendar.date(byAdding: .month, value: offset, to: alignedCurrentDate),
              let newMonthInterval = calendar.dateInterval(of: .month, for: newDate) else {
            return false
        }

        let todayComponents = calendar.dateComponents([.year, .month], from: Date())
        let newStart = newMonthInterval.start
        let newComponents = calendar.dateComponents(in: TimeZone.current, from: newStart)

        // Don't allow months beyond today's month
        if offset > 0 {
            if let newYear = newComponents.year,
               let newMonth = newComponents.month,
               let todayYear = todayComponents.year,
               let todayMonth = todayComponents.month,
               (newYear > todayYear || (newYear == todayYear && newMonth > todayMonth)) {
                return false
            }
        }

        // Valid month — update
        dateCompontents = newComponents
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
    private func updateWeek(by offset: Int) -> Bool {
        guard let selectedWeek = selectedWeek else { return false }

        let rawDate = (offset < 0) ? selectedWeek.start : selectedWeek.end

        guard let currentWeekInterval = calendar.dateInterval(of: .weekOfYear, for: rawDate),
              let newDate = calendar.date(byAdding: .weekOfYear, value: offset, to: currentWeekInterval.start),
              let newWeekInterval = calendar.dateInterval(of: .weekOfYear, for: newDate) else {
            return false
        }

        let newStart = newWeekInterval.start
        let newComponents = calendar.dateComponents(in: TimeZone.current, from: newStart)
        let todayComponents = calendar.dateComponents([.weekOfYear, .yearForWeekOfYear], from: Date())

        if offset > 0 {
            if let newYear = newComponents.yearForWeekOfYear,
               let newWeek = newComponents.weekOfYear,
               let todayYear = todayComponents.yearForWeekOfYear,
               let todayWeek = todayComponents.weekOfYear,
               (newYear > todayYear || (newYear == todayYear && newWeek > todayWeek)) {
                return false
            }
        }

        self.dateCompontents = newComponents
        self.setSelectedWeek(start: newWeekInterval.start, end: newWeekInterval.end.addingTimeInterval(-1))
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
        placeHolder.day = 1 //start of that month
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
        Task {
            await getWeeklyBoundaries()
        }
    }
}
