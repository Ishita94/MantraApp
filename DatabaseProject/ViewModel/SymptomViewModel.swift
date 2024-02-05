//
//  SymptomController.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-10-21.
//

import Foundation
import Combine
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
}

class SymptomViewModel: ObservableObject {
    
    //MARK: - Properties
    @Published var definedSymptoms: [Symptom] = [
        Symptom(symptomName: "Nausea", rating: 0, recentStatus: ""),
        Symptom(symptomName: "Nausea", rating: 0, recentStatus: ""),
        Symptom(symptomName: "Nausea", rating: 0, recentStatus: "")

    ]
    @Published var symptomsReportedToday: [Symptom] = [
        Symptom(symptomName: "Nausea", rating: 6, recentStatus: "New")]
    @Published var suggestedSymptoms: [Symptom] = [
        Symptom(symptomName: "Nausea", rating: 6, recentStatus: "Yesterday")]
    @Published var reportedSymptoms: [SymptomReport] = [
        SymptomReport(
            dateFormatted: "Aug 20, 2023", creationDateTime: Date.now, rating: 0, emojiIconName: "ic-incomplete-red-filled", symptomName: "Nausea", symptomComparisonState: "Much Better", reportCompletionStatus: false, recentStatus: "N/A", symptomId: "1"),
        SymptomReport(
            dateFormatted: "Aug 20, 2023", creationDateTime: Date.now, rating: 0, emojiIconName: "ic-incomplete-red-filled", symptomName: "Fatigue", symptomComparisonState: "Somewhat Worse", reportCompletionStatus: false, recentStatus: "N/A", symptomId: "1"),
        SymptomReport(
            dateFormatted: "Aug 20, 2023", creationDateTime: Date.now, rating: 0, emojiIconName: "ic-incomplete-red-filled", symptomName: "Pain", symptomComparisonState: "Worse", reportCompletionStatus: false, recentStatus: "N/A", symptomId: "1")
                ]
    @Published var symptomStatesforComparison : [SymptomComparisonState] = [
            SymptomComparisonState(stateName: "Much Better", imageName: "much-better"),
            SymptomComparisonState(stateName: "Somewhat Better", imageName: "somewhat-better"),
            SymptomComparisonState(stateName: "No Change", imageName: "no-change"),
            SymptomComparisonState(stateName: "Somewhat Worse", imageName: "much-worse"),
            SymptomComparisonState(stateName: "Much Worse", imageName: "much-worse")
        ]
    @Published var reports: [Report] = [
        Report(formattedDay: "Thu", formattedDate: "Aug 20", date: Date.now, emojiIconName: "ic-incomplete-red-filled", emojiStateofDay: "Nauseous", symptomNames: "Nausea, Headache", reportCompletionStatus: false),
        Report(formattedDay: "Thu", formattedDate: "Aug 20", date: Date.now, emojiIconName: "ic-incomplete-red-filled", emojiStateofDay: "Nauseous", symptomNames: "Nausea, Headache", reportCompletionStatus: false),
        Report(formattedDay: "Thu", formattedDate: "Aug 20", date: Date.now, emojiIconName: "ic-incomplete-red-filled", emojiStateofDay: "Nauseous", symptomNames: "Nausea, Headache", reportCompletionStatus: false)
                ]
    
    init() {
    }
    
    @Published var reportList = [Report]()
    private var reportsofUser = [SymptomReport]()
    @Published var reportedSymptomsofUserbyDate = [SymptomReport]()

    func getReportsofUser() {
        
        // Perform the contact store method asynchronously so it doesn't block the UI
        DispatchQueue.main.async {
                // See which local contacts are actually users of this app
                ReportingDataService().getReportsofUser() { reportsofUser in
                    
                    // Update the UI in the main thread
                    DispatchQueue.main.async {
                        
                        // Set the fetched users to the published users property
                        self.reportsofUser = reportsofUser
                        // Set the filtered list
                        self.prepareReportsforReportList()
                        
                    }
                }
                
            }
        }
    
    func prepareReportsforReportList() {
        for report in self.reportsofUser{
            
            let date = report.creationDateTime
            let formattedDay = date.dayNameOfWeek() ?? ""
            let formattedDate = date.monthandDate() ?? ""
//            let dateFormatter = DateFormatter()
//            dateFormatter.setLocalizedDateFormatFromTemplate("MMMMd") // set template after setting locale
//            formattedDate = dateFormatter.string(from: date)
//            var emojiIconName:String
//            var emojiStateofDay:String
            let symptomNames = ""
            let reportCompletionStatus = report.reportCompletionStatus
            reportList.append(Report(formattedDay: formattedDay, formattedDate: formattedDate, date: date, emojiStateofDay: "Nauseous", symptomNames: "Nausea, Fatigue", reportCompletionStatus: reportCompletionStatus))
            
        }
        
    }

    func getReportedSymptomsofUserbyDate(date: Date) {
        reportedSymptomsofUserbyDate = []
        for reportedSymptom in reportsofUser {
            if reportedSymptom.creationDateTime == date {
                reportedSymptomsofUserbyDate.append(reportedSymptom)
            }
        }
        
    }
    
    
    
    
    
//    //MARK: - CRUD Functions
//    func createMood(emotion: Emotion, comment: String?, date: Date) {
//
//        let newMood = Mood(emotion: emotion, comment: comment, date: date)
//        
//        moods.append(newMood)
//        saveToPersistentStore()
//    
//    }
//    
//    func deleteMood(at offset: IndexSet) {
//        
//        guard let index = Array(offset).first else { return }
//     print("INDEX: \(index)")
//        moods.remove(at: index)
//        
//        saveToPersistentStore()
//    }
//    
//    
//    func updateMoodComment(mood: Mood, comment: String) {
//        if let index = moods.firstIndex(of: mood) {
//            var mood = moods[index]
//            mood.comment = comment
//            
//            moods[index] = mood
//            saveToPersistentStore()
//        }
//    }
//    
//    // MARK: Save, Load from Persistent
//    private var persistentFileURL: URL? {
//      let fileManager = FileManager.default
//      guard let documents = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
//        else { return nil }
//       
//      return documents.appendingPathComponent("mood.plist")
//    }
//    
//    func saveToPersistentStore() {
//        
//        // Stars -> Data -> Plist
//        guard let url = persistentFileURL else { return }
//        
//        do {
//            let encoder = PropertyListEncoder()
//            let data = try encoder.encode(moods)
//            try data.write(to: url)
//        } catch {
//            print("Error saving stars data: \(error)")
//        }
//    }
//    
//    func loadFromPersistentStore() {
//        
//        // Plist -> Data -> Stars
////        let fileManager = FileManager.default
////        guard let url = persistentFileURL, fileManager.fileExists(atPath: url.path) else { return }
////        
////        do {
////            let data = try Data(contentsOf: url)
////            let decoder = PropertyListDecoder()
////            moods = try decoder.decode([Mood].self, from: data)
////        } catch {
////            print("error loading stars data: \(error)")
////        }
//    }
}

