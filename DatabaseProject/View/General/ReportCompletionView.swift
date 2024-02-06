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

    var body: some View {
        NavigationStack (){
            
            VStack (alignment: .center) {
                
                Image("ic-circle-tick-filled-green")
                Text(dateString)
                    .font(.emojiLargeTitleinPicker)
                Text("Daily Report Completed")
                    .font(.actionCompletionTitle)
                Text("""
        You have completed entering your health report for today! You can view your report from the Reporting page.
        """)
                
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
