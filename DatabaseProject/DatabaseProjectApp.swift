//
//  DatabaseProjectApp.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-04.
//

import SwiftUI
import FirebaseCore
import FirebaseFirestore
import FirebaseAppCheck


@main
struct DatabaseProjectApp: App {
    @StateObject var generalViewModel = GeneralViewModel()
    @StateObject var symptomViewModel : SymptomViewModel
    @StateObject var eventViewModel : EventsViewModel
    @StateObject var reportingViewModel : ReportingViewModel

    private func registerCustomFonts() {
        let fonts = Bundle.main.urls(forResourcesWithExtension: "ttf", subdirectory: nil)
        fonts?.forEach { url in
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }
    init() {
        let generalViewModel = GeneralViewModel()  // Create local instance first
                _generalViewModel = StateObject(wrappedValue: generalViewModel)
                _symptomViewModel = StateObject(wrappedValue: SymptomViewModel(generalViewModel: generalViewModel))
                _eventViewModel = StateObject(wrappedValue: EventsViewModel(generalViewModel: generalViewModel))
        _reportingViewModel = StateObject(wrappedValue: ReportingViewModel(generalViewModel: generalViewModel))
        
        registerCustomFonts()
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
        FirebaseApp.configure()

    }
    var body: some Scene {
        WindowGroup {
           

            LaunchView()
                .environmentObject(generalViewModel)
                .environmentObject(symptomViewModel)
                .environmentObject(eventViewModel)
                .environmentObject(reportingViewModel)
        }
    }
}
