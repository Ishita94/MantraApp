//
//  LoginContentView.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-10-22.
//

import SwiftUI
import FirebaseAuth

struct LoginContentView: View {
        @Binding var loggedIn: Bool
        
        var body: some View {
            
            VStack {
                Text("Welcome!")
                Button {
                    try! Auth.auth().signOut()
                    loggedIn = false
                } label: {
                    Text("Sign Out")
                }

            }
        }
    }
struct LoginContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginContentView(loggedIn: .constant(true))
    }
}
