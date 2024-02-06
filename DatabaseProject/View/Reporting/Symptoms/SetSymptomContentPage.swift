//
//  SetSymptomContentPage.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-10-01.
//

import SwiftUI

struct SetSymptomContentPage: View {
    @State var item: Symptom
    @State var symptomName: String

//    @Binding var path: NavigationPath
    @Binding var loggedIn: Bool
    @State var selectedSegment: Int = 0
    @EnvironmentObject var generalViewModel : GeneralViewModel
    @EnvironmentObject var symptomViewModel : SymptomViewModel

    @State private var readyToNavigate = false

    
    var body: some View {
        NavigationStack{
            VStack (alignment: .leading){
                Text("Symptom Report")
                .foregroundColor(.white)
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
                    Please rate it on a scale of 0 to 10, with 0 being an absence of symptom and 10 being very severe.
                    """)
                .foregroundColor(Color(.blackMediumEmphasis))
                .font(.regularText)
                .padding(.bottom, 9.0)
                
                Divider()
                
                SetSymptomRatingView()
                
                Divider()
                
                Button(action: {
                    if(item.id==nil){
                        symptomViewModel.saveSymptomReport(symptomReport: SymptomReport(creationDateTime: item.creationDateTime, rating: generalViewModel.selectedSegment, symptomName: symptomName, symptomComparisonState: "", reportCompletionStatus: false, recentStatus: "New", userId: ""))
                    }
                    else
                    {
                        symptomViewModel.editSymptomReport(symptomReport: SymptomReport( id:item.id,  creationDateTime: item.creationDateTime, rating: generalViewModel.selectedSegment, symptomName: symptomName, symptomComparisonState: "", reportCompletionStatus: false, recentStatus: "New", userId: ""))
                    }
                    readyToNavigate = true
                }) {
                    HStack {
                        Image(systemName: "checkmark.circle.fill")
                            .foregroundColor(.white)
                        Text("Confirm")
                            .foregroundColor(.white)
                            .font(.smallTitle)
                            .frame(maxWidth: .infinity)
                    }
                    .padding()
                    .background(Color(.primary4))
                    .cornerRadius(10)
                }
                
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
            .navigationDestination(isPresented: $readyToNavigate) {
                    AddorEditSymptomsLandingPage(loggedIn: $loggedIn, dateString: item.creationDateTime.datetoString()!,
                        showAfterCreatingNewSymptomReport: true)
            }
            .presentationDetents([.fraction(0.8), .large])
        }
    }
}

#Preview {
    SetSymptomContentPage(item: Symptom(symptomName: "Nausea", rating: 0, recentStatus: "", creationDateTime: Date.now, tracking: true, userId: ""), symptomName: "Nausea", loggedIn: Binding.constant(true))
        .environmentObject(GeneralViewModel())
        .environmentObject(SymptomViewModel())

}
