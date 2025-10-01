
//
//  SymptomTrendModel.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-08-13.
//

import Foundation

// MARK: - Enums

enum TrendType {
    case improving     // Getting better
    case worsening     // Getting worse
    case stable        // No significant change
    case mixed         // Complex patterns (worse→better)
    case inconsistent  // Multiple direction changes
}

enum TrendStrength {
    case strong        // Major state changes (2.0+ points)
    case moderate      // Moderate changes (1.0+ points)
    case slight        // Minor changes (0.5+ points)
}

// MARK: - Models for calculating trends for symptoms

struct SymptomDataPoint {
    var rating: Int
    var date: Date
    var symptomComparisonState: String
    var recentStatus: String = ""
}

struct SymptomTrendModel: Identifiable {
    let id = UUID()
    var symptomName: String
    var symptomDataPoints: [SymptomDataPoint]
    var completeTrendString: String
//    var trendType: TrendType
    var trendStrength: TrendStrength
}

// MARK: - Enhanced Segment Structure

struct SymptomSegment {
    let stateValue: Int      // e.g, 1, 2, 3...
    let days: Int           // consecutive no. of days in this segment
    let stateName: String   // Comparison state, e.g., Much Better, Much Worse...
    let startDateofSegment: Date     // When this segment started
    let endDateofSegment: Date       // When this segment ended
    let isResolved: Bool    // Is this segment resolved (rating 0)?
}

struct TrendAnalysisResult {
    let trendString: String //
    //let trendType: TrendType //improving, worsening, stable...
    let strength: TrendStrength //intensity - moderate, slight, strong
}

class SymptomTrendGenerator {
    let symptomStates : [SymptomComparisonState]
    init(symptomStates: [SymptomComparisonState]) {
        self.symptomStates = symptomStates
    }
    
    //    private let dayNames = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    
    func analyzeTrend(for dataPoints: [SymptomDataPoint]) -> TrendAnalysisResult {
        // Check for first-time logging first
        let firstTimeDay = checkForFirstTimeLogging(dataPoints: dataPoints)
        
        // Handle insufficient data. Trend only possible with atleast 2 datapoints
        guard dataPoints.count > 1 else {
            return handleInsufficientData(dataPoints: dataPoints, firstTimeDay: firstTimeDay)
        }
        
        // Create segments
        let segments = createSegments(from: dataPoints)
        
        // Determine trend strength
        let trendStrength = determineTrendStrength(from: dataPoints)
        
        // Generate trend description
        let completeTrend = generateTrendDescription(segments: segments, strength: trendStrength, firstTimeDay: firstTimeDay)
        
        // No separate resolution info - kept clean
        
        return TrendAnalysisResult(
            trendString: completeTrend,
            strength: trendStrength
        )
    }
    
    // MARK: - Enhanced Segment Creation
    
    private func createSegments(from dataPoints: [SymptomDataPoint]) -> [SymptomSegment] {
        guard dataPoints.count > 1 else { return [] }
        
        var segments: [SymptomSegment] = []
        var currentRating = dataPoints[0].rating
        var currentState = dataPoints[0].symptomComparisonState
        var currentStartDate = dataPoints[0].date
        var currentDays = 1
        
        for i in 1..<dataPoints.count {
            if dataPoints[i].rating == currentRating && dataPoints[i].symptomComparisonState == currentState {
                currentDays += 1
            } else {
                // End current segment
                segments.append(SymptomSegment(
                    stateValue: currentRating,
                    days: currentDays,
                    stateName: currentState,
                    startDateofSegment: currentStartDate,
                    endDateofSegment: dataPoints[i-1].date,
                    isResolved: currentRating == 0
                ))
                
                // Start new segment
                currentRating = dataPoints[i].rating
                currentState = dataPoints[i].symptomComparisonState
                currentStartDate = dataPoints[i].date
                currentDays = 1
            }
        }
        
        // Add final segment
        segments.append(SymptomSegment(
            stateValue: currentRating,
            days: currentDays,
            stateName: currentState,
            startDateofSegment: currentStartDate,
            endDateofSegment: dataPoints.last!.date,
            isResolved: currentRating == 0
        ))
        
        return segments
    }
    
    // MARK: - Trend Description Generation
    
    private func generateTrendDescription(segments: [SymptomSegment], strength: TrendStrength, firstTimeDay: String? = nil) -> String {
        guard !segments.isEmpty else {
            return "No symptom data recorded this week"
        }
        
        switch segments.count {
        case 1:
            return generateSingleSegmentTrend(segment: segments[0], isFirstReport: firstTimeDay != nil, firstTimeDay: firstTimeDay)
        case 2:
            return generateTwoSegmentTrend(segments: segments, strength: strength, isFirstReport: firstTimeDay != nil, firstTimeDay: firstTimeDay)
        case 3:
            return generateThreeSegmentTrend(segments: segments, strength: strength, isFirstReport: firstTimeDay != nil, firstTimeDay: firstTimeDay)
        default:
            if firstTimeDay != nil {
                return "Logged for the first time: \(segments[0].stateValue)/10 on \(firstTimeDay!), then symptom went up and down during the week"
            }
            return "Symptom went up and down during the week"
        }
    }
    
    // MARK: - Helper Functions for First-Time Trends
    
    private func generateFirstTimeTrend(segments: [SymptomSegment], strength: TrendStrength, firstTimeDay: String) -> String {
        let first = segments[0]
        let prefix = "Logged for the first time: \(first.stateValue)/10 on \(firstTimeDay), then "
        
        switch segments.count {
        case 2:
            return generateFirstTimeTwoSegment(segments: segments, strength: strength, prefix: prefix)
        case 3:
            return generateFirstTimeThreeSegment(segments: segments, strength: strength, prefix: prefix)
        default:
            return "\(prefix)symptom went up and down during the week"
        }
    }
    
    private func generateFirstTimeTwoSegment(segments: [SymptomSegment], strength: TrendStrength, prefix: String) -> String {
        let first = segments[0]
        let second = segments[1]
        
        // Special case: ending with "No Change" AND rating = 0
        if second.stateName == "No Change" && second.stateValue == 0 {
            return "\(prefix)stayed resolved for the rest of the week"
        }
        
        // Special case: ending with "No Change" but rating > 0
        if second.stateName == "No Change" {
            return "\(prefix)stayed the same for the rest of the week"
        }
        
        // Progressive patterns for first reports
        var strengthModifier = getProgressiveStrengthModifier(strength: strength, isImproving: false)
        if second.stateValue < first.stateValue {
            strengthModifier = getProgressiveStrengthModifier(strength: strength, isImproving: true)
        }
        if second.isResolved {
            return "\(prefix)\(strengthModifier)" //avoid duplication of showing resolved dates
        }
        else {
            return "\(prefix)\(strengthModifier) to a \(second.stateName.lowercased()) level"
        }
    }
    
    private func generateFirstTimeThreeSegment(segments: [SymptomSegment], strength: TrendStrength, prefix: String) -> String {
        let first = segments[0]
        let second = segments[1]
        let third = segments[2]
        
        // Return to baseline for first reports
        if first.stateValue == third.stateValue {
            let changeDirection = second.stateValue > first.stateValue ? "got" : "improved to"
            return "\(prefix)\(changeDirection) \(second.stateName.lowercased()), then returned to the initial level"
        }
        
        // Special case: ending with "No Change" AND rating = 0 (remained resolved)
        if third.stateName == "No Change" && third.stateValue == 0 { //TODO: need checking
            let changeDirection = second.stateValue > first.stateValue ? "got" : "improved to"
            return "\(prefix)\(changeDirection) \(second.stateName.lowercased()) and stayed resolved"
        }
        
        // Ending with "No Change" for first reports
        if third.stateName == "No Change" {
            let changeDirection = second.stateValue > first.stateValue ? "got" : "improved to"
            return "\(prefix)\(changeDirection) \(second.stateName.lowercased()) and stayed that way"
        }
        
        // Progressive patterns for first reports
        if isProgressivePattern(first: first.stateValue, second: second.stateValue, third: third.stateValue) {
            let isImproving = third.stateValue < first.stateValue
            let strengthModifier = getProgressiveStrengthModifier(strength: strength, isImproving: isImproving)
            if third.isResolved {
                return "\(prefix)\(strengthModifier)"
            }
            else {
                return "\(prefix)\(strengthModifier) to a \(third.stateName.lowercased()) level"
            }
        }
        
        return "\(prefix)symptom went up and down during the week"
    }
    
    // MARK: - Single Segment Trend
    
    private func generateSingleSegmentTrend(segment: SymptomSegment, isFirstReport: Bool = false, firstTimeDay: String? = nil) -> String {
        if isFirstReport && firstTimeDay != nil {
            // For single segments, no "then" since there's no change/progression
            if segment.stateName == "No Change" {
                return "Logged for the first time: \(segment.stateValue)/10 on \(firstTimeDay!) and stayed the same all week"
            }
            return "Logged for the first time: \(segment.stateValue)/10 on \(firstTimeDay!) and stayed \(segment.stateName.lowercased()) all week"
        }
        
        // Regular single segment logic
        if segment.stateName == "No Change" {
            return "No change all week"
        }
        return "Stayed \(segment.stateName.lowercased()) all week"
    }
    
    // MARK: - Two Segment Trend with Strength
    
    private func generateTwoSegmentTrend(segments: [SymptomSegment], strength: TrendStrength, isFirstReport: Bool = false, firstTimeDay: String? = nil) -> String {
        
        // Handle first report cases
        if isFirstReport && firstTimeDay != nil {
            return generateFirstTimeTrend(segments: segments, strength: strength, firstTimeDay: firstTimeDay!)
        }
        
        // Regular 2-segment logic (existing code)
        let first = segments[0]
        let second = segments[1]
        
        // Special case: ending with "No Change" AND resolved
        if second.stateName == "No Change" && second.isResolved {
            return "\(getStartPhrase(stateName: first.stateName)), then stayed resolved for the rest of the week"
        }
        
        // Special case: ending with "No Change" but not resolved (stayed unchanged)
        if second.stateName == "No Change" {
            return "\(getStartPhrase(stateName: first.stateName)), then stayed the same for the rest of the week"
        }
        
        // Progressive patterns with strength modifiers, same logic as three segment trend
        var strengthModifier = getProgressiveStrengthModifier(strength: strength, isImproving: false)
        if second.stateValue < first.stateValue {
            strengthModifier = getProgressiveStrengthModifier(strength: strength, isImproving: true)
        }
        
        if second.isResolved {
            return "\(getStartPhrase(stateName: first.stateName)), then \(strengthModifier)"
        } else {
            return "\(getStartPhrase(stateName: first.stateName)), then \(strengthModifier) to a \(second.stateName.lowercased()) level"
        }
    }
    
    // MARK: - Three Segment Trend with Strength
    
    private func generateThreeSegmentTrend(segments: [SymptomSegment], strength: TrendStrength, isFirstReport: Bool = false, firstTimeDay: String? = nil) -> String {
        // Handle first report cases
        if isFirstReport && firstTimeDay != nil {
            return generateFirstTimeTrend(segments: segments, strength: strength, firstTimeDay: firstTimeDay!)
        }
        
        let first = segments[0]
        let second = segments[1]
        let third = segments[2]
        
        // Check for return to baseline patterns - first and end state same (NO strength modifier, to reduce complexity)
        if first.stateValue == third.stateValue {
            return generateReturnToBaselineTrend(segments: segments)
        }
        
        // Special case: ending with "No Change" AND resolved
        if third.stateName == "No Change" && third.isResolved {
            let changeDirection = second.stateValue > first.stateValue ? "got" : "improved to"
            return "\(getStartPhrase(stateName: first.stateName)), then \(changeDirection) \(second.stateName.lowercased()) and stayed resolved"
        }
        
        // Check for "stayed that way" patterns - ending with No Change (NO strength modifier)
        //Pro
        if third.stateName == "No Change" {
            let changeDirection = second.stateValue > first.stateValue ? "got" : "improved to" //got much worse/somewhat worse / improved
            return "\(getStartPhrase(stateName: first.stateName)), then \(changeDirection) \(second.stateName.lowercased()) and stayed the same"
        }
        
        // Check for progressive patterns - SHOW STRENGTH HERE also
        //Progressing means there's an linear slope in trend. So trend is unidirectional
        // If progressive pattern, second state can be kept unmentioned, and progress and strength can be focused on
        if isProgressivePattern(first: first.stateValue, second: second.stateValue, third: third.stateValue) {
            //isImproving = true when the end state is better than initial state
            let isImproving = third.stateValue < first.stateValue
            
            //Decide whether improved/worsened
            let strengthModifier = getProgressiveStrengthModifier(strength: strength, isImproving: isImproving)
            
            if third.isResolved {
                return "\(getStartPhrase(stateName: first.stateName)), then \(strengthModifier)"
            } else {
                return "\(getStartPhrase(stateName: first.stateName)), then \(strengthModifier) to a \(third.stateName.lowercased()) level"
            }
        }
        
        // Complex inconsistent patterns - not unidirectional (NO strength modifier)
        return "Symptoms went up and down during the week"
    }
    
    // MARK: - Helper Functions
    
    private func getStartPhrase(stateName: String) -> String {
        if stateName == "No Change" {
            return "Stayed the same at first"
        }
        return "Started \(stateName.lowercased())"
    }
    
    private func getProgressiveStrengthModifier(strength: TrendStrength, isImproving: Bool) -> String {
        switch strength {
        case .strong:
            return isImproving ? "improved a lot" : "worsened a lot"
        case .moderate:
            return isImproving ? "moderately improved" : "moderately worsened"
        case .slight:
            return isImproving ? "improved a bit" : "worsened a bit"
        }
    }
    
    private func isProgressivePattern(first: Int, second: Int, third: Int) -> Bool {
        let firstToSecond = second - first
        let secondToThird = third - second
        
        // Same direction (both positive or both negative)
        return (firstToSecond > 0 && secondToThird > 0) ||
        (firstToSecond < 0 && secondToThird < 0)
    }
    
    // MARK: - Return to Baseline Helper
    
    private func generateReturnToBaselineTrend(segments: [SymptomSegment]) -> String {
        let first = segments[0]
        let second = segments[1]
        
        if second.stateValue > first.stateValue {
            // Got worse then returned
            return "Started \(first.stateName.lowercased()), got \(second.stateName.lowercased()), then went back to \(first.stateName.lowercased())"
        } else {
            // Got better then returned
            return "Started \(first.stateName.lowercased()), improved to \(second.stateName.lowercased()), then went back to \(first.stateName.lowercased())"
        }
    }
    
    // MARK: - Trend Type & Strength Determination
    
    private func determineTrendType(from segments: [SymptomSegment], dataPoints: [SymptomDataPoint]) -> TrendType {
        guard segments.count > 1 else { return .stable }
        
        let firstState = segments.first?.stateValue ?? 0
        let lastState = segments.last?.stateValue ?? 0
        
        switch segments.count {
        case 1:
            return .stable
        case 2:
            if lastState < firstState {
                return .improving
            } else if lastState > firstState {
                return .worsening
            } else {
                return .stable
            }
        case 3:
            // Check for mixed patterns
            if firstState == lastState {
                return .mixed
            } else if isProgressivePattern(first: segments[0].stateValue, second: segments[1].stateValue, third: segments[2].stateValue) {
                return lastState < firstState ? .improving : .worsening
            } else {
                return .mixed
            }
        default:
            return .inconsistent
        }
    }
    
    private func determineTrendStrength(from dataPoints: [SymptomDataPoint]) -> TrendStrength {
        guard dataPoints.count > 1 else { return .slight }
        
        let ratings = dataPoints.map { $0.rating }
        let minRating = ratings.min() ?? 0
        let maxRating = ratings.max() ?? 0
        let totalChange = abs(maxRating - minRating)
        
        if totalChange >= 2 {
            return .strong
        } else if totalChange >= 1 {
            return .moderate
        } else {
            return .slight
        }
    }
    
    // MARK: - Special Conditions
    
    private func handleInsufficientData(dataPoints: [SymptomDataPoint], firstTimeDay: String? ) -> TrendAnalysisResult {
        var baseTrend = "No symptom data recorded this week"
        
        if dataPoints.count == 1 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d"  // "Sep 7"
            
            // Check if this is a first-time report using recentStatus
            if dataPoints[0].recentStatus == "New" {
                // First-time single report
                if dataPoints[0].rating == 0 {
                    baseTrend = "Logged for the first time as resolved on \(dateFormatter.string(from: dataPoints[0].date))"
                } else {
                    baseTrend = "Logged for the first and only time this week: \(dataPoints[0].rating)/10 on \(dateFormatter.string(from: dataPoints[0].date))"
                }
            } else {
                // Regular single report (not first time)
                if dataPoints[0].rating == 0 {
                    baseTrend = "Only logged once this week: resolved on \(dateFormatter.string(from: dataPoints[0].date))"
                } else {
                    baseTrend = "Only logged once this week: \(dataPoints[0].rating)/10 on \(dateFormatter.string(from: dataPoints[0].date))"
                    if dataPoints[0].symptomComparisonState != "" {
                        baseTrend += ", noted as \(dataPoints[0].symptomComparisonState.lowercased())"
                    }
                }
            }
        }
        
        return TrendAnalysisResult(
            trendString: baseTrend,
            //trendType: .stable,
            strength: .slight
        )
    }
    
    private func checkForFirstTimeLogging(dataPoints: [SymptomDataPoint]) -> String? { //return dateString or nil
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d"  // "Sep 7"
        
        for dataPoint in dataPoints {
            if dataPoint.recentStatus == "New" { //TODO: add setting this for the first report and check fetching it
                return dateFormatter.string(from: dataPoint.date)
            }
        }
        return nil
    }
}
