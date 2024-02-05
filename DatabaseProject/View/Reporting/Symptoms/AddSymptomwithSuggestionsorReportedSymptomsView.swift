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
    
    var body: some View {
        NavigationStack{
            VStack (){
                ReportedSymptomsContentPage()
                ReportedSymptomswithRecommendationContentPage()
            }
            
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
//        .background(
//            NavigationLink(destination: SetSymptomView(symptomName: ""), isActive: $showThirdView) {
//                EmptyView()
//            }
//        )
    }
}

#Preview {
    AddSymptomwithSuggestionsorReportedSymptomsView()
}
