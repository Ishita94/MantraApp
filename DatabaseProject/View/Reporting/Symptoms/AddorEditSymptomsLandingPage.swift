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
    //    @State var showThirdView: Bool = false
    @Binding var loggedIn: Bool
    @State var date: Date?
    @State var dateString: String
    @State var showAfterCreatingNewSymptomReport: Bool = false
    
    
    var body: some View {
        VStack{
            
            NavBar(loggedIn: $loggedIn)
            Divider()
            SecondaryNavBar()
            Divider()
            //            ScrollView{
            if(symptomController.dictionaryofSuggestedReports.count>0 || symptomController.reportedSymptomsofUserbyDate.count>0 ) {
                AddorEditSymptomButtonPanel(loggedIn: $loggedIn, dateString: dateString)
                AddSymptomwithSuggestionsorReportedSymptomsView(loggedIn: $loggedIn, dateString: dateString)
            }
            //}
            else
            {
                AddorEditSymptomsContentView(loggedIn: $loggedIn, dateString: dateString)
            }
            Divider()
            BackandNextButtonPanel(loggedIn: $loggedIn, dateString: dateString)
        }
        
        .onAppear()
        {
            symptomController.getReportedSymptomsofUserbyDate(date: dateString, showAfterCreatingNewSymptomReport: false)
            symptomController.getSuggestedSymptomsofUserbeforeDate(date: prepareDate(dateString: dateString)!)
        }
        //        }
        //        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    AddorEditSymptomsLandingPage(loggedIn: Binding.constant(true), dateString: Date.now.datetoString()!)
        .environmentObject(SymptomViewModel())
        .environmentObject(GeneralViewModel())
        .environmentObject(EventsViewModel())
}
