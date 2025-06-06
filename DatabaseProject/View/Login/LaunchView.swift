//
//  LaunchView.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-10-22.
//

import SwiftUI
import FirebaseAuth

struct LaunchView: View {
    
    @State var loggedIn = false
    @State var loginFormShowing = false
    @State var createFormShowing = false
    @State private var selectedTab = 1

    var body: some View {
        
        // Check the logged in property and show the appropriate view
        NavigationStack{
            if !loggedIn {
                
                VStack (spacing: 20) {
                    HStack{
                        Image("ic-Mantra-Logo")
                        Image("ic-Mantra-Title")
                    }
                    // Sign in button
                    Button {
                        // Show the login form
                        loginFormShowing = true
                    } label: {
                        Text("Sign In")
                            .font(.navMediumTitle)
                            .foregroundColor(Color(.primary4))

                    }
                    .sheet(isPresented: $loginFormShowing, onDismiss: checkLogin) {
                        LoginForm(formShowing: $loginFormShowing)
                    }
                    
                    // Create account button
                    Button {
                        createFormShowing = true
                    } label: {
                        Text("Create Account")
                            .font(.navMediumTitle)
                            .foregroundColor(Color(.primary4))
                    }
                    .sheet(isPresented: $createFormShowing, onDismiss: checkLogin) {
                        CreateForm(formShowing: $createFormShowing)
                    }
                    
                }
                .onAppear {
                    checkLogin()
                }
            }
            else {
                
                // Show logged in view
                Divider ()
                HomePageView(loggedIn: $loggedIn)
//                    .environmentObject(SymptomController())
//                    .environmentObject(MainController())
//                    .environmentObject(EventController())

                //LoginContentView(loggedIn: $loggedIn)
            }
        }
    }
    func checkLogin() {
        
        loggedIn = Auth.auth().currentUser == nil ? false : true
//        loggedIn = AuthViewModel.isUserLoggedIn()
        //print("loggedIn: \(loggedIn)")
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        let generalViewModel = GeneralViewModel()
        let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
        let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
        let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected
        let summariesViewModel = SummariesViewModel(generalViewModel: generalViewModel) // Injected, but not needed for now
        
        LaunchView()
            .environmentObject(generalViewModel)
            .environmentObject(symptomViewModel)
            .environmentObject(eventsViewModel)
            .environmentObject(reportingViewModel)
    }
}
