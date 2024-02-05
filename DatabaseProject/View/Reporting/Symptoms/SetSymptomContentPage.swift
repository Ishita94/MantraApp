//
//  SetSymptomContentPage.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-10-01.
//

import SwiftUI

struct SetSymptomContentPage: View {
    //    @State var pastReportedSymptoms:[SymptoPickerItem] = [
    //     SymptoPickerItem(symptomName: "Nausea"),
    //     SymptoPickerItem(symptomName: "Fatigue"),
    //     SymptoPickerItem(symptomName: "Pain")]
    
    @State var symptomName: String
    
    var body: some View {
        NavigationStack{
            VStack (alignment: .leading){
                Text("""
                     New Symptom Report
                     """)
                .foregroundColor(Color(.white))
                .background(Color(.primary4))
                .font(.smallTitle)
                .cornerRadius(6)
                .padding(.bottom, 16.0)
                
                Text("Title")
                    .foregroundColor(Color(.blackMediumEmphasis))
                    .font(.regularText)
                    .padding(.bottom, 11.0)
                              
            TextEditor(text: $symptomName)
                                    .padding(4)
                                    .background(Color.clear)
                                    .foregroundColor(Color(.blackMediumEmphasis))
                                    .font(.titleinRowItemEditable)
                                    .overlay( /// apply a rounded border
                                        RoundedRectangle(cornerRadius: 10)
                                            .strokeBorder(Color(.outlineGrey), lineWidth: 1)
                                    )
                                    .frame(height: 56)
//                            }
//                            .frame(height: 100)
                
                Text("""
                    As this is a new symptom, you will need to make an initial severity report. Please rate it on a scale of 0 to 10, with 0 being an absence of symptom and 10 being very severe.
                    """)
                .foregroundColor(Color(.blackMediumEmphasis))
                .font(.regularText)
                .padding(.bottom, 9.0)
                
                Divider()
                
                SetSymptomRatingView()
                
                Divider()

                    NavigationLink {
                        ReportedSymptomsView()
                    } label: {
                        VStack{
                            Button(action: {}) {
                                HStack {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(Color(.white))
                                    Text("Confirm")
                                        .foregroundColor(.white)
                                        .font(.titleinRowItem)
                                        .frame(maxWidth: .infinity)
                                }
                            }
                        }
                        .padding()
                        .background(Color(.primary4))
                        .cornerRadius(10)
                    }
                                
//                Button(action: {}) {
//                    HStack {
//                        Image(systemName: "checkmark.circle.fill")
//                            .foregroundColor(Color(.white))
//                        Text("Confirm")
//                            .foregroundColor(.white)
//                            .font(.titleinRowItem)
//                            .frame(maxWidth: .infinity)
//                    }
//                }
//                .padding()
//                .background(Color(.primary4))
//                .cornerRadius(10)
                
                Button(action: {}) {
                    HStack {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color(.warning2))
                        Text("Cancel")
                            .foregroundColor(Color(.warning2))
                            .font(.titleinRowItem)
                            .frame(maxWidth: .infinity)
                    }
                }
                .padding()
                .overlay( /// apply a rounded border
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color(.outlineGrey), lineWidth: 1)
                )
            }
            
        }
    }
}

#Preview {
    SetSymptomContentPage(symptomName: "N/A")
}
