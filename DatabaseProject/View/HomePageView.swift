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
            
            //            ReportingView(loggedIn: $loggedIn)
            //                .tabItem {
            ////                    VStack (spacing: 10) {
            //                        Image("ic-test")
            //                            .resizable()
            //                            .aspectRatio(contentMode: .fit)
            ////                            .padding(.bottom, 20)
            //                            .frame(height: 100)
            //                            .padding(.bottom, 10)
            //                        //Spacer().frame(height: 20)
            //                        Text("Reporting")
            //                            .font(.tabTitle)
            //                            .accentColor(Color("Black")).foregroundColor(.black)
            //                            .padding(.top, 80)
            //                            .frame(maxWidth: .infinity, maxHeight: .infinity)
            //                            .baselineOffset(5)
            //                   // }
            //
            //                }
            //
            //            SummariesView()
            //                .tabItem {
            //                 //   VStack (spacing: 10) {
            //                        Image("ic-tab-summaries-not-selected")
            //                            .resizable()
            //                            .aspectRatio(contentMode: .fit)
            //                            .frame(height: 50)
            //                            .padding(.bottom, 10)
            //                        Text("Summaries")
            //                            .font(.tabTitle)
            //                            .padding(.top, 80)
            //                            .frame(maxWidth: .infinity, maxHeight: .infinity)
            //                            .baselineOffset(5)
            //                   // }
            //                }
            //
            //            MoreView()
            //                .tabItem {
            //                    //VStack (spacing: 10){
            //                        Image("ic-tab-more-not-selected")
            //                            .resizable()
            //                            .aspectRatio(contentMode: .fit)
            //                            .frame(height: 50)
            //                            .padding(.bottom, 10)
            //                        Text("More")
            //                            .font(.tabTitle)
            //                            .padding(.top, 80)
            //                            .frame(maxWidth: .infinity, maxHeight: .infinity)
            //                            .baselineOffset(5)
            ////                            .accentColor(Color.clear).foregroundColor(.black)
            //                  //  }
            //                }
            //        }
            
            ReportingView(loggedIn: $loggedIn)
                .tabItem {
                    Label("Reporting", image: "ic-test")
                        .labelStyle(VerticalLabelStyle())
                    //                    TabItemView (imageName: "ic-tab-more-not-selected" , text: "Reporting")
                    
                }
            
            SummariesView()
                .tabItem {
                    Label("Summaries", image: "ic-tab-summaries-not-selected")
                        .labelStyle(VerticalLabelStyle())
                    //                    TabItemView (imageName: "ic-tab-summaries-not-selected" , text: "Summaries")
                    
                }
            
            MoreView()
                .tabItem {
                    Label("More", image: "ic-tab-more-not-selected")
                        .labelStyle(VerticalLabelStyle())
                    //                    TabItemView (imageName: "ic-tab-more-not-selected" , text: "More")
                }
        }
        
    }
}

struct VerticalLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        VStack {  // 👈 Adjust spacing here
            configuration.icon
            
                .scaledToFit()
            //                .frame(width: 10, height: 5) // 👈 Smaller size = more space
            Spacer().frame(height: 10)
            configuration.title
                .font(.tabTitle)
                .padding(.top, 5)
            
        }
    }
}
struct TabItemView: View {
    let imageName: String
    let text: String
    
    var body: some View {
        VStack(spacing: 10) {
            Image(imageName)
                .resizable()
            //                .scaledToFit()
                .frame(width: 10, height: 10)
            
            Text(text)
                .font(.tabTitle)
                .padding(.top, 5)
        }
    }
}

struct HomePageView_Previews: PreviewProvider {
    static var previews: some View {
        let generalViewModel = GeneralViewModel()
        let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
        let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
        let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected
        
        HomePageView(loggedIn: Binding.constant(true))
            .environmentObject(generalViewModel)
            .environmentObject(symptomViewModel)
            .environmentObject(eventsViewModel)
            .environmentObject(reportingViewModel)
            .padding()
    }
}
