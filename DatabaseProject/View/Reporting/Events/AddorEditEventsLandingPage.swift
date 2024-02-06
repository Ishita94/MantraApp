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
                .environmentObject(generalViewModel)
            Divider()
            //            ScrollView{
            
            if (eventViewModel.suggestedEvents.count>0 || eventViewModel.reportedEventsofUserbyDate.count>0)
            {
                AddorEditEventButtonPanel(loggedIn: $loggedIn, dateString: dateString)
                ReportedEventsView(loggedIn: $loggedIn
                                     , dateString: dateString)
                
                Spacer()
            }
            else
            {
                AddorEditEventsContentPage(loggedIn: $loggedIn, dateString: dateString)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)

            }
            Divider()
            BackandNextButtonPanel(loggedIn: $loggedIn, dateString: dateString)
        }
        .onAppear {
            // Call for the data
            eventViewModel.getEventsReportedonDate(date: prepareDate(dateString: dateString)!)
        }
        .padding()
//        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    AddorEditEventsLandingPage(dateString: Date.now.datetoString()!, loggedIn: Binding.constant(true)).environmentObject(SymptomViewModel())
        .environmentObject(GeneralViewModel())
        .environmentObject(EventsViewModel())
    
}
