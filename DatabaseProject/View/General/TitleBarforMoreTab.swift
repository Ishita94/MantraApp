//
//  TitleBarforMoreTab.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-09-24.
//


import SwiftUI

struct TitleBarforMoreTab: View {
    @EnvironmentObject var generalViewModel : GeneralViewModel
    @Binding var loggedIn: Bool
    
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            HStack{
                Text("More Options")
                    .font(.navLargeTitle)
                    .foregroundStyle(Color(.black))
                Spacer()
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

#Preview {
    TitleBarforMoreTab(loggedIn: Binding.constant(true))
        .environmentObject(GeneralViewModel())
}
