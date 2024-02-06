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
    private func registerCustomFonts() {
        let fonts = Bundle.main.urls(forResourcesWithExtension: "ttf", subdirectory: nil)
        fonts?.forEach { url in
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }
    init() {
        registerCustomFonts()
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
        FirebaseApp.configure()

    }
    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(SymptomViewModel())
                .environmentObject(GeneralViewModel())
                .environmentObject(EventsViewModel())
                .environmentObject(ReportingViewModel())
        }
    }
}
