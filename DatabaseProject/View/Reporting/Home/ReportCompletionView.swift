//
//  ReportCompletionView.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2024-01-31.
//

import SwiftUI

struct ReportCompletionView: View {
    @Binding var isSheetVisible: Bool
    @Environment(\.dismiss) var dismiss
    @Binding var loggedIn: Bool
    @State var dateString: String
    @State var readyToNavigate: Bool = false
    @State var selectedTab: Int = 0

    var body: some View {
        NavigationStack (){
            
            VStack (alignment: .center) {
                
                Image("ic-circle-tick-filled-green")
                
                Text(stringtoFormalDate(dateString: dateString))
                    .font(.symptomTitleinReportingPage)
                    .padding()

                Text("Daily Report Completed")
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(.secondary2))
                    .foregroundStyle(Color(.white))
                    .font(.actionCompletionTitle)
                    .cornerRadius(6)
                    .frame(maxHeight: 20)
                    .padding()
                
                (Text("""
        You have completed entering your health report for today! You can view your report from the
 """ ) +  Text(" Reporting").bold() + Text(" page."))
                .multilineTextAlignment(.center)
                    
                
                Divider()
                
                Button(action: {
                    readyToNavigate = true
                }) {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.white)
                        Text("Okay")
                            .foregroundColor(.white)
                            .font(.smallTitle)
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background(Color(.primary4))
                    .cornerRadius(10)
                }
                .padding()
                
                
            }
            .padding()
//            .presentationDetents([.fraction(0.6), .medium])
            .navigationDestination(isPresented: $readyToNavigate) {
                HomePageView(loggedIn: $loggedIn)
            }
        }
        
    }
}

#Preview {
    ReportCompletionView(isSheetVisible: Binding.constant(true), loggedIn: Binding.constant(true), dateString: Date.now.datetoString()!)
}
