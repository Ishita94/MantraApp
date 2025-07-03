//
//  Report.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-11-05.
//

import Foundation
import FirebaseFirestoreSwift

struct Report: Identifiable, Hashable, Codable {
    @DocumentID var id: String?
    
    var dayNameofWeek:String = ""
    var monthNameofWeek:String = ""
//    var date:Date
    var dateString:String = ""
    //var rating:Int
    var emojiValue:String = ""
    var emojiStateofDay:String = ""
    var symptomNames:String = ""
    //var symptomComparisonState:String
    var reportCompletionStatus:Bool = false
    var description:String = ""
    var questions:String = ""
    var notes:String = ""
    var symptomCompletionStatus:Bool = false
    var eventCompletionStatus:Bool = false
    var descriptionCompletionStatus:Bool = false
    var questionsandNotesCompletionStatus:Bool = false
    var emojiCompletionStatus:Bool = false
    var creationDateTime: Date
    var lastModifiedDateTime: Date
    var userId: String
    
    var symptomReports: [SymptomReport] = []
    var eventReports: [EventReport] = []

    init(from report: ReportforQuery) {
            self.id = report.id
        self.emojiStateofDay = report.emojiStateofDay
        self.emojiValue = report.emojiValue
        self.emojiCompletionStatus = report.emojiCompletionStatus
//        self.reportCompletionStatus = report.reportCompletionStatus
        self.description = report.description
        self.questions = report.questions
        self.notes = report.notes
        self.eventCompletionStatus = report.eventCompletionStatus
        self.descriptionCompletionStatus = report.descriptionCompletionStatus
        self.questionsandNotesCompletionStatus = report.questionsandNotesCompletionStatus
        self.creationDateTime = report.creationDateTime
        self.lastModifiedDateTime = report.lastModifiedDateTime
        self.userId = report.userId
        }
    init(id: String? = nil,
             dayNameofWeek: String = "",
             monthNameofWeek: String = "",
             dateString: String = "",
             emojiValue: String = "",
             emojiStateofDay: String = "",
             symptomNames: String = "",
             reportCompletionStatus: Bool = false,
             description: String = "",
             questions: String = "",
             notes: String = "",
             symptomCompletionStatus: Bool = false,
             eventCompletionStatus: Bool = false,
             descriptionCompletionStatus: Bool = false,
             questionsandNotesCompletionStatus: Bool = false,
             emojiCompletionStatus: Bool = false,
             creationDateTime: Date = Date(),
             lastModifiedDateTime: Date = Date(),
             userId: String = "",
             symptomReports: [SymptomReport] = [],
            eventReports: [EventReport] = []) {
                self.id = id
                self.dayNameofWeek = dayNameofWeek
                self.monthNameofWeek = monthNameofWeek
                self.dateString = dateString
                self.emojiValue = emojiValue
                self.emojiStateofDay = emojiStateofDay
                self.symptomNames = symptomNames
                self.reportCompletionStatus = reportCompletionStatus
                self.description = description
                self.questions = questions
                self.notes = notes
                self.symptomCompletionStatus = symptomCompletionStatus
                self.eventCompletionStatus = eventCompletionStatus
                self.descriptionCompletionStatus = descriptionCompletionStatus
                self.questionsandNotesCompletionStatus = questionsandNotesCompletionStatus
                self.emojiCompletionStatus = emojiCompletionStatus
                self.creationDateTime = creationDateTime
                self.lastModifiedDateTime = lastModifiedDateTime
                self.userId = userId
                self.symptomReports = symptomReports
                self.eventReports = eventReports
        }
}
