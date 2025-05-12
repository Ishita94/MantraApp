//
//  VisualizationsLandingPage.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-05-03.
//

import SwiftUI

struct VisualizationsPage: View {
    @Binding var loggedIn: Bool
    @EnvironmentObject var summariesViewModel : SummariesViewModel
    @State var week: Week

    var body: some View {
        VStack (alignment:.leading){
            KeyBar()
            
            HStack{
                Button(action: {
//                    summariesViewModel.decrementMonth()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color(.blackMediumEmphasis))
                }
                Spacer()
                Text(summariesViewModel.formatStringfromWeek(week))
                    .font(.navMediumTitle)
                    .foregroundStyle(Color(.black))
                Spacer()
                if(summariesViewModel.showingNextWeek())
                {
                    Button(action: {
//                        summariesViewModel.incrementMonth()
                    }) {
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color(.blackMediumEmphasis))
                    }
                }
                else{
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color(.disabledBackground))
                }
            }
            .padding(.top, 24)
            
            
            }
       
    }
}

#Preview {
    
let generalViewModel = GeneralViewModel()
let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected

    VisualizationsPage(loggedIn: Binding.constant(true)) .environmentObject(generalViewModel)
    .environmentObject(symptomViewModel)
    .environmentObject(eventsViewModel)
    .environmentObject(reportingViewModel)
}
