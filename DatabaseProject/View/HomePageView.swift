//
//  HomePageView.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-18.
//

import SwiftUI

struct HomePageView: View {
    
    init(){
            
    }
    var body: some View {
        
        TabView {
            
            ReportingView()
                .tabItem {
                    VStack {
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
                    VStack {
                        Image("ic-tab-summaries-not-selected")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Text("Summaries")
                            .font(.tabTitle)
//                            .accentColor(Color.clear).foregroundColor(.black)
                            
                    }
                }
            
            MoreView()
                .tabItem {
                    VStack {
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
        HomePageView()
            .padding()
    }
}
