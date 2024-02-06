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
            VStack (){
                ReportedSymptomsView(loggedIn: $loggedIn
                                            , dateString: dateString)
                            .frame(maxWidth: .infinity, maxHeight: 200)

                Divider()
                SuggestedSymptomsView(dateString: dateString)
                            .frame(maxWidth: .infinity, maxHeight: 200)

            }
        }
//        .onAppear {
//            // Call for the data
//            symptomViewModel.getReportedSymptomsofUserbyDate(date: dateString, showAfterCreatingNewSymptomReport: false)
//        }
    }
}

#Preview {
    AddSymptomwithSuggestionsorReportedSymptomsView(loggedIn: Binding.constant(true), dateString: Date.now.datetoString()!).environmentObject(SymptomViewModel())
        .environmentObject(GeneralViewModel())
}
