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
    @State private var questionsText: String
    @State private var notesText: String
    @FocusState private var isQuestionsTextEditorFocused: Bool  // Track focus state
    @FocusState private var isNotesTextEditorFocused: Bool  // Track focus state
    
    init(loggedIn: Binding<Bool>, dateString: String, report: Report) {
        _loggedIn = loggedIn
        _dateString = State(initialValue: dateString)
        _questionsText = State(initialValue:  report.questions)
        _notesText = State(initialValue:  report.notes)
        }

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
                
                ZStack  (alignment: .leading){
                    if $questionsText.wrappedValue.isEmpty && !isQuestionsTextEditorFocused {

                    Text("2500 characters remaining")
                        .foregroundStyle(.secondary)
                        .font(.regularText)
                        .lineSpacing(10)
                        .autocapitalization(.words)
                        .disableAutocorrection(true)
                        .padding()
                }
                    TextEditor(text: $questionsText)
                        .focused($isQuestionsTextEditorFocused)  // Attach focus state
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
                
                ZStack (alignment: .leading){
                    if $notesText.wrappedValue.isEmpty && !isNotesTextEditorFocused {
                        Text("2500 characters remaining")
                            .foregroundStyle(.secondary)
                            .font(.regularText)
                            .lineSpacing(10)
                            .autocapitalization(.words)
                            .disableAutocorrection(true)
                            .padding()
                    }
                    TextEditor(text: $notesText)
                        .focused($isNotesTextEditorFocused)  // Attach focus state
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
            Divider()
            BackandNextButtonPanelforQuestionsandNotes(loggedIn: $loggedIn, dateString: dateString, questionsText: $questionsText, notesText: $notesText)
            }
        }
    
}


#Preview {
    QuestionsandNotesContentPage(loggedIn: Binding.constant(true), dateString: Date.now.datetoString()!, report: Report())
}
