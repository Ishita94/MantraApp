//
//  ExtensionDate.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-11-04.
//

import Foundation
import Combine
import OrderedCollections

extension Date {
    func dayNameOfWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: self)
    }
    func monthandDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
        return dateFormatter.string(from: self)
    }
    func fullMonthandDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        return dateFormatter.string(from: self)
    }
    func monthandYear() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: self)
    }
    func datetoString() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.init(identifier: "en_GB")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    static var currentTimeStamp: Int64{
        return Int64(Date().timeIntervalSince1970 * 1000)
    }
    func datetoFormalDatewithDayString() -> String {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = "EEEE, MMMM d"
        inputDateFormatter.locale = Locale(identifier: "en_GB")
        return inputDateFormatter.string(from: self)
    }
}
func stringtoDate(dateString: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.locale = Locale.init(identifier: "en_GB")
    return dateFormatter.date(from: dateString)
}

func stringtoFormalDate(dateString: String) -> String {
    let inputDateFormatter = DateFormatter()
    inputDateFormatter.dateFormat = "yyyy-MM-dd"
    inputDateFormatter.locale = Locale.init(identifier: "en_GB")
    if let date = inputDateFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMMM dd, yyyy"
            return outputFormatter.string(from: date)
        } else {
            return "Invalid Date"
        }
}

func stringtoFormalShortDate(dateString: String) -> String {
    let inputDateFormatter = DateFormatter()
    inputDateFormatter.dateFormat = "yyyy-MM-dd"
    inputDateFormatter.locale = Locale.init(identifier: "en_GB")
    if let date = inputDateFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "MMM dd"
            return outputFormatter.string(from: date)
        } else {
            return "Invalid Date"
        }
}

func datetoFormalDateString(date: Date) -> String {
    let inputDateFormatter = DateFormatter()
    inputDateFormatter.dateFormat = "MMMM dd, yyyy"  // Example: "March 05, 2024"
    inputDateFormatter.locale = Locale(identifier: "en_GB")
    return inputDateFormatter.string(from: date)
}




func prepareDatefromDate(date:Date) -> Date? {

    
    let calendar = Calendar.current

    let currentDateComponents = DateComponents(
      calendar: calendar,
      year: calendar.component(.year, from: date),
      month: calendar.component(.month, from: date),
      day: calendar.component(.day, from: date),
      hour: 0,
      minute: 0)

    guard let currentDate = calendar.date(from: currentDateComponents) else {
      print("error");
      return nil
    }

    let now = Calendar.current.dateComponents(in: .current, from: date)

    // Create the start of the day in `DateComponents` by leaving off the time.
    let today = DateComponents(year: now.year, month: now.month, day: now.day)
    let dateToday = Calendar.current.date(from: today)!
    return dateToday
}

func prepareDate(dateString: String) -> Date? {
//    let dateString = date.datetoString()!
    let datevar = stringtoDate(dateString: dateString)
    return datevar;
    
    
//    let calendar = Calendar.current
//
//    let currentDateComponents = DateComponents(
//      calendar: calendar,
//      year: calendar.component(.year, from: date),
//      month: calendar.component(.month, from: date),
//      day: calendar.component(.day, from: date),
//      hour: 0,
//      minute: 0)
//
//    guard let currentDate = calendar.date(from: currentDateComponents) else {
//      print("error");
//      return nil
//    }

//    let now = Calendar.current.dateComponents(in: .current, from: date)
//
//    // Create the start of the day in `DateComponents` by leaving off the time.
//    let today = DateComponents(year: now.year, month: now.month, day: now.day)
//    let dateToday = Calendar.current.date(from: today)!
//    return dateToday
}

func prepareNextDate(date: Date) -> Date? {
//    let datevar = stringtoDate(dateString: date.datetoString()!)
//    return datevar;
//    let now = Calendar.current.dateComponents(in: .current, from: date)
//
//    let tomorrow = DateComponents(year: now.year, month: now.month, day: now.day! + 1)
//    let dateTomorrow = Calendar.current.date(from: tomorrow)!
    
    let dateTomorrow = Calendar.current.date(byAdding: .day, value: 1, to: date)
    return dateTomorrow
}


extension Week {
    static var current: Week {
        let calendar = Calendar.current
        let now = Date()

        // Start of week (Monday)
        let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: now))!

        // End of week (Sunday)
        let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek)!

        return Week(start: startOfWeek, end: endOfWeek)
    }
}
