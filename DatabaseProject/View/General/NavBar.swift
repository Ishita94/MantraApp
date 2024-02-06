//
//  NavBar.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-18.
//

import SwiftUI

struct NavBar: View {
    @Binding var loggedIn: Bool

    var body: some View {
        HStack{
            Text("Report your day")
                .foregroundColor(Color(.greyText))
                .font(.regularText)
                .multilineTextAlignment(.leading)
            Spacer()
            HStack{
                Button {
                    AuthViewModel.logout()
                    loggedIn = false
                } label: {
                    HStack{
                        Image(systemName: "rectangle.portrait.and.arrow.forward")
                            .foregroundColor(Color(.primary4))
                        Text("Sign out")
                            .foregroundColor(Color(.black))
                            .font(.regularText)
                    }
                }
            }
        }
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar(loggedIn: .constant(true))
    }
}
