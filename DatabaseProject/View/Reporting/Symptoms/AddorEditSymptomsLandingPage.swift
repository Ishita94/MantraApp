//
//  AddorEditSymptomsLandingPage.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-24.
//

import SwiftUI

struct AddorEditSymptomsLandingPage: View {
    @State var isSheetVisible: Bool = false
    @EnvironmentObject var symptomController : SymptomViewModel
    @EnvironmentObject var generalViewModel : GeneralViewModel
    //    @State var showThirdView: Bool = false
    @Binding var loggedIn: Bool
//    @State var report: Report
    @State var date: Date?
    @State var dateString: String
    @State var showAfterCreatingNewSymptomReport: Bool = false
    @State var createNewReport: Bool = false

    
    var body: some View {
        VStack {
            NavBar(loggedIn: $loggedIn, titleText: "Report your day", subtitleText: generalViewModel.dateStringofCurrentReport)
            Divider()
            SecondaryNavBar()
            Divider()
            if(symptomController.dictionaryofSuggestedReports.count>0 || generalViewModel.selectedReport.symptomReports.count>0 ) {
                ScrollView{
                    AddorEditSymptomButtonPanel(loggedIn: $loggedIn, dateString: dateString)
                    Divider()
                    AddSymptomwithSuggestionsorReportedSymptomsView(loggedIn: $loggedIn, dateString: dateString)
                }
//                .frame(maxWidth: .infinity, alignment: .topLeading)
            }
            else
            {
                AddorEditSymptomsContentView(loggedIn: $loggedIn, dateString: dateString)
            }
            Divider()
            BackandNextButtonPanel(loggedIn: $loggedIn, dateString: dateString)
        }
        
        .onAppear()
        {
            if(createNewReport) //For creating a new report today
            {
                symptomController.saveNewReport()
            }
            symptomController.getSuggestedSymptomsofUserbeforeDate(date: prepareDate(dateString: dateString)!)
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    let generalViewModel = GeneralViewModel()
    let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
    let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
    let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected
    
    AddorEditSymptomsLandingPage(loggedIn: Binding.constant(true), dateString: Date.now.datetoString()!)
        .environmentObject(generalViewModel)
        .environmentObject(symptomViewModel)
        .environmentObject(eventsViewModel)
        .environmentObject(reportingViewModel)
}
