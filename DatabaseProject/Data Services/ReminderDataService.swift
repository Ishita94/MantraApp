//
//  ReminderDataService.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-10-06.
//

import Foundation
import Firebase
import FirebaseFirestore
import SwiftUICore
import OrderedCollections

class ReminderDataService {
    private var generalViewModel : GeneralViewModel
    init(generalViewModel: GeneralViewModel) {
        self.generalViewModel = generalViewModel
    }
    func getAllReminders() async -> [Reminder] {
        // Get a reference to the database
        let db = Firestore.firestore()
        var remindersofUser: [Reminder] = []
        do{
            let reminderSnapshot = try await db.collection("reminders") //fetch all reminders
                .whereField("userId", isEqualTo: AuthViewModel.getLoggedInUserId())
                .order(by: "creationDateTime", descending: true)
                .getDocuments()
            
            remindersofUser = reminderSnapshot.documents.compactMap { doc in
                try? doc.data(as: Reminder.self)
            }
        
        } catch {
            print("❌ Error fetching all reminders: \(error.localizedDescription)")
        }
        return remindersofUser
    }
}
