//
//  QuestionsandNotesContentPage.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2024-01-23.
//

import SwiftUI

struct QuestionsandNotesContentPage: View {
    @Binding var loggedIn: Bool
    @State var dateString: String
    @EnvironmentObject var reportingViewModel : ReportingViewModel
//    @State var readyToNavigate: Bool = false
    @Binding var questionsText: String
    @Binding var notesText: String


    var body: some View {
        NavigationStack{
            VStack (){
                Button(action: {
                    //TODO: Add functionality to this button
                }) {
                    
                        Text("View all questions and notes")
                            .foregroundColor(.white)
                            .font(.titleinRowItem)
                            .frame(maxWidth: .infinity)
                }
                .padding()
                .buttonStyle(PlainButtonStyle())
                .background(Color(.primary4))
                .cornerRadius(10)
                
                Text("""
                What questions do you have for your health care provider?
                """)
                .foregroundColor(.black)
                .font(.titleinRowItem)
                
                VStack{
                    TextEditor(text: $questionsText)
                        .foregroundStyle(.secondary)
                        .font(.regularText)
                        .lineSpacing(10)
                        .autocapitalization(.words)
                        .disableAutocorrection(true)
                        .padding()
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color(.outlineDarker), lineWidth: 1)
                )
                
                Text("""
                What notes do you have from talking with your health care provider?
                """)
                .foregroundColor(.black)
                .font(.titleinRowItem)
                
                VStack{
                    TextEditor(text: $notesText)
                        .foregroundStyle(.secondary)
                        .font(.regularText)
                        .lineSpacing(10)
                        .autocapitalization(.words)
                        .disableAutocorrection(true)
                        .padding()
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color(.outlineDarker), lineWidth: 1)
                )
            }
            }
        }
    
}


#Preview {
    QuestionsandNotesContentPage(loggedIn: Binding.constant(true), dateString: Date.now.datetoString()!, questionsText: Binding.constant(""), notesText: Binding.constant(""))
}
