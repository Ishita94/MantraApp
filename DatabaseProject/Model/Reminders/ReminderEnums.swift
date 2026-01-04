//
//  RepeatFrequencyEnum.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-10-14.
//

enum RepeatFrequencyEnum: String, CaseIterable, Codable  {
    case once = "Once"
    case daily = "Daily"
    case weekly = "Weekly"
    case monthly = "Monthly"
    case everyOtherDay = "Every other day"
}

enum AlertEnum: String, CaseIterable, Codable  {
    case fiveMinBefore =  "Five minutes before"
    case thirtyMinBefore   =   "Thirty minutes before"
    case oneHourBefore =    "One hour before"
    case oneDayBefore =      "One day before"
    case custom =            "Custom" //can select minute, hour, days
}
