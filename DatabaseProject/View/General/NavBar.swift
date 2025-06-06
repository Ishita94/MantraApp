//
//  NavBar.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-18.
//

import SwiftUI

struct NavBar: View {
    @Binding var loggedIn: Bool
    @EnvironmentObject var generalViewModel : GeneralViewModel
    @State var titleText: String
    @State var subtitleText: String
    var body: some View {
        HStack{
            VStack (alignment: .leading, spacing: 4) {
                Text(titleText)
                    .foregroundColor(Color(.blackMediumEmphasis))
                    .font(.regularText)
                
                Text(subtitleText)
                    .foregroundColor(Color(.black))
                    .font(.sectionTitleinSymptomsPage)
            }
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
        NavBar(loggedIn: .constant(true), titleText: "", subtitleText: "")
    }
}
