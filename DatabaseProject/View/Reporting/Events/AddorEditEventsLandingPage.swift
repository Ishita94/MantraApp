//
//  AddorEditEventsLandingPage.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-10-30.
//

import SwiftUI

struct AddorEditEventsLandingPage: View {
    @EnvironmentObject var eventViewModel : EventsViewModel
    @EnvironmentObject var generalViewModel : GeneralViewModel
    @State var dateString: String

    @Binding var loggedIn: Bool
    
    var body: some View {
        VStack{
            NavBar(loggedIn: $loggedIn)
            Divider()
            SecondaryNavBar()
            Divider()
//            ScrollView{
                
            if (eventViewModel.suggestedEventsofUserbeforeDate.count>0 || (eventViewModel.dictionaryofEvents[dateString] != nil && eventViewModel.dictionaryofEvents[dateString]!.count>0)
                    ) {
                    AddSymptomwithSuggestionsorReportedSymptomsView(loggedIn: $loggedIn, dateString: dateString)
                }
                else
                {
                    AddorEditEventsContentPage(loggedIn: $loggedIn)
                }
                Divider()
                BackandNextButtonPanel(loggedIn: $loggedIn, dateString: dateString)
            }
//        }
//        .frame(maxWidth: .infinity, maxHeight: .infinity)

//        .sheet(isPresented: $isSheetVisible)
//        {
//            ChooseSymptomView(isSheetVisible: $isSheetVisible, showThirdView: $showThirdView) //default value
//        }
        .padding()
       .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    AddorEditEventsLandingPage(dateString: Date.now.datetoString()!, loggedIn: Binding.constant(true)).environmentObject(SymptomViewModel())
        .environmentObject(GeneralViewModel())
        .environmentObject(EventsViewModel())

}
