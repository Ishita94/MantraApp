//
//  SecondaryNavBar.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-24.
//

import SwiftUI

struct SecondaryNavBar: View {
    @State private var stepNumber: String = "1"
    @State private var stepTitle: String = "Report your symptoms"
    @State var currentStateIndex: Int = 0
    @EnvironmentObject var generalViewModel : GeneralViewModel

    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            TopProgressBarView()
                .environmentObject(generalViewModel)

            Text("Step "+"\(generalViewModel.currentState)")
                .foregroundColor(Color(.greyText))
                .font(.regularText)
            //TODO: update the title
            Text(generalViewModel.currentTitle)
                .foregroundColor(.black)
                .font(.symptomTitleinReportingPage)
            //Spacer()
        }
//        .padding()
        
        .frame(maxWidth: .infinity, minHeight: 100)
    }
}

#Preview {
    let generalViewModel = GeneralViewModel()
    let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
    let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
    let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected
    
    
    SecondaryNavBar()
        .environmentObject(generalViewModel)
        .environmentObject(symptomViewModel)
        .environmentObject(eventsViewModel)
        .environmentObject(reportingViewModel)
}
