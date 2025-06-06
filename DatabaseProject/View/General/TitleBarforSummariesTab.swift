//
//  TitleBarforSummariesTab.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-04-28.
//

import SwiftUI

struct TitleBarforSummariesTab: View {
    @EnvironmentObject var summariesViewModel : SummariesViewModel
    @Binding var loggedIn: Bool
//    @State var readytoNavigatetoPreviousMonth: Bool = false
//    @State var readytoNavigatetoNextMonth: Bool = false
    
    var body: some View {
            VStack (alignment: .leading, spacing: 20) {
                HStack{
                    Text("Summaries")
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
                    Button(action: {
//                        readytoNavigatetoPreviousMonth=true
                        summariesViewModel.decrementMonth()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(Color(.blackMediumEmphasis))
                    }
                    Spacer()
                    Text(summariesViewModel.monthAndYearFormatted() ?? "Invalid Month")
                        .font(.navMediumTitle)
                        .foregroundStyle(Color(.black))
                    Spacer()
                    if(summariesViewModel.showingNextMonth())
                    {
                        Button(action: {
//                            readytoNavigatetoNextMonth=true
                            summariesViewModel.incrementMonth()
                        }) {
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color(.blackMediumEmphasis))
                        }
                    }
                    else{
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color(.disabledBackground))
                    }
                }
//                .onChange(of: readytoNavigatetoPreviousMonth) { newValue in
//                    if newValue {
//                        summariesViewModel.decrementMonth()
//                    }
//                }
//                .onChange(of: readytoNavigatetoNextMonth) { newValue in
//                    if newValue {
//                        summariesViewModel.incrementMonth()
//                    }
//                }
                Text("Click on a week to learn more about what you experienced that week.")
                    .font(.regularText)
                    .foregroundStyle(Color(.blackMediumEmphasis))
            }
        }
}

#Preview {
    TitleBarforSummariesTab(loggedIn: Binding.constant(true))
    //        .environmentObject(SummariesViewModel())
}
