//
//  TitleBarforTabs.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-10-29.
//

import SwiftUI

struct TitleBarforTabs: View {    
    @EnvironmentObject var mainController : GeneralViewModel
    @Binding var loggedIn: Bool
    
    func getTitle() ->String {
        if(mainController.currentState==1) {
            return "Reporting";
        }
        else if (mainController.currentState==2) {
            return "Summaries";
        }
        else if(mainController.currentState==3) {
            return "More Options"
        }
        else {
            return "";
        }
        }
    
    
    var body: some View {
        VStack (alignment: .leading, spacing: 20) {
            HStack{
                Text(getTitle())
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
            HStack{
                Image(systemName: "chevron.left")
                    .foregroundColor(Color(.blackMediumEmphasis))
                Spacer()
                Text(Date.now.monthandYear()!)
                    .font(.navMediumTitle)
                    .foregroundStyle(Color(.black))
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(Color(.disabledBackground))
            }
            Text("Click on a date card below to learn more about what you experienced that day.")
                .font(.regularText)
                .foregroundStyle(Color(.blackMediumEmphasis))
        }
    }
}

#Preview {
    TitleBarforTabs(loggedIn: Binding.constant(true))        .environmentObject(GeneralViewModel())
}
