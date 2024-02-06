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
    func dayNameOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        return dateFormatter.string(from: self)
    }
    func monthandDate() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"
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
}
func stringtoDate(dateString: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    dateFormatter.locale = Locale.init(identifier: "en_GB")
    return dateFormatter.date(from: dateString)
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

