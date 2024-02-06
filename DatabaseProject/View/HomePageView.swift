//
//  HomePageView.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-18.
//

import SwiftUI

struct HomePageView: View {
    @EnvironmentObject var symptomController : SymptomViewModel
    @Binding var loggedIn: Bool
    
    var body: some View {
        
        TabView {
            
            ReportingView(loggedIn: $loggedIn)
                .tabItem {
                    VStack (spacing: 10) {
                        Image("ic-test")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            //.frame(height: 50)
                        Text("Reporting")
                            .font(.tabTitle)
                            .accentColor(Color("Black")).foregroundColor(.black)
                            
                    }
                
                }
                
            SummariesView()
                .tabItem {
                    VStack (spacing: 10) {
                        Image("ic-tab-summaries-not-selected")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("Summaries")
                            .font(.tabTitle)
                    }
                }
            
            MoreView()
                .tabItem {
                    VStack (spacing: 10){
                        Image("ic-tab-more-not-selected")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("More")
                            .font(.tabTitle)
//                            .accentColor(Color.clear).foregroundColor(.black)
                    }
                }
        }
        
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        HomePageView(loggedIn: Binding.constant(true))
            .environmentObject(SymptomViewModel())
            .environmentObject(GeneralViewModel())
            .environmentObject(EventsViewModel())
            .environmentObject(ReportingViewModel())
            .padding()
    }
}
