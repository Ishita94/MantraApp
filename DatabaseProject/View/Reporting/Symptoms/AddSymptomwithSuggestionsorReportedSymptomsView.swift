//
//  AddSymtomwithSuggestionsorReportedSymtomsView.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-10-16.
//

import SwiftUI

struct AddSymptomwithSuggestionsorReportedSymptomsView: View {
    @State var isSheetVisible: Bool = false
//    @State var showThirdView: Bool = true
    @Binding var loggedIn: Bool
    @EnvironmentObject var symptomViewModel : SymptomViewModel
    @State var dateString: String


    var body: some View {
        NavigationStack{
//            ScrollView {
                
            VStack (spacing: 16){
                    ReportedSymptomsView(loggedIn: $loggedIn
                                         , dateString: dateString)
                    Divider()
                    SuggestedSymptomsView(dateString: dateString)
                }
            }
        //}
    }
}

#Preview {
    let generalViewModel = GeneralViewModel()
    let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
    let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
    let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected
    
    
    AddSymptomwithSuggestionsorReportedSymptomsView(loggedIn: Binding.constant(true), dateString: Date.now.datetoString()!)
        .environmentObject(generalViewModel)
        .environmentObject(symptomViewModel)
        .environmentObject(eventsViewModel)
        .environmentObject(reportingViewModel)
}
