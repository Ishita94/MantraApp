//
//  ReminderViewModel.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-10-06.
//

import Foundation
import Combine
import OrderedCollections

class ReminderViewModel: ObservableObject {
    private var reminderDataService : ReminderDataService
    @Published var reminders = [Reminder]()
    @Published var isLoading = false

    init(generalViewModel: GeneralViewModel) {
        self.reminderDataService = ReminderDataService(generalViewModel: generalViewModel)
    }
    
    @MainActor
    func getAllReminders(){
        DispatchQueue.main.async {
            Task{
                self.isLoading = true
                self.reminders = await self.reminderDataService.getAllReminders()
                self.isLoading = false
            }
        }
    }
}
