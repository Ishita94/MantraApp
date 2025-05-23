//
//  ReportedSymptomswithRecommendationContentPage.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-10-05.
//

import SwiftUI

struct SuggestedSymptomsView: View {
    @EnvironmentObject var symptomViewModel : SymptomViewModel
    @State var loggedIn: Bool = AuthViewModel.isUserLoggedIn()
    @State var dateString: String

    //    @Binding var path: NavigationPath
    
    var body: some View {
        VStack(alignment: .leading){
            Text("""
                Suggestions
                """)
            .font(.symptomTitleinReportingPage)
            .foregroundColor(.black)
            .padding(.vertical, 6)
            if(symptomViewModel.dictionaryofSuggestedReports.count>0)
            {
                Text("""
                The options below are some recommended symptoms you can add based on your previous reports.
                """)
                .font(.regularText)
                .foregroundColor(Color(.blackMediumEmphasis))
            }
            else
            {
                Text("""
                You have not made a report today. The options below are some recommended symptoms you can add based on your previous reports.
                """)
                .font(.regularText)
                .foregroundColor(Color(.blackMediumEmphasis))
            }

//            ScrollView{
                ForEach(symptomViewModel.dictionaryofSuggestedReports.keys, id: \.self)
                 {
                     if let item =
                        symptomViewModel.dictionaryofSuggestedReports[$0]{
                         SuggestedSymptomsListRow(item: item, loggedIn: $loggedIn, dateString: dateString)
                     }
                }
            }
//            .frame(maxWidth: .infinity)
//            .scrollContentBackground(.hidden)

            
        //}
    }
}

#Preview {
    SuggestedSymptomsView(dateString: Date.now.datetoString()!)
}
