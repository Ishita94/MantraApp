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
    @State var selectedSegment: Int 
    @EnvironmentObject var generalViewModel : GeneralViewModel
    @EnvironmentObject var symptomViewModel : SymptomViewModel
    @Environment(\.dismiss) var dismiss
    @State private var readyToNavigate = false
    
    
    var body: some View {
        NavigationStack{
            VStack (alignment: .leading){
                Text("New Symptom Report")
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(.primary4))
                    .foregroundStyle(Color(.white))
                    .font(.smallTitle)
                    .cornerRadius(6)
                    .frame(minHeight: 27)
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
                
                SetSymptomRatingView(selectedSegment: $selectedSegment)
                
                Divider()
                
                Button(action: {
                    if(item.id==nil){ //this is the first report for this new symtom
                        symptomViewModel.saveSymptomReport(symptomReport: SymptomReport(creationDateTime: item.creationDateTime, lastModifiedDateTime: Date.now, rating: selectedSegment, symptomName: symptomName, symptomComparisonState: "", reportCompletionStatus: false, recentStatus: "New", symptomId: item.id, userId: AuthViewModel.getLoggedInUserId()))
                    }
                    else
                    {
                        symptomViewModel.editSymptomReport(symptomReport: SymptomReport( id:item.id,  creationDateTime: item.creationDateTime,
                            lastModifiedDateTime: Date.now,
                                                                            rating: selectedSegment, symptomName: symptomName, symptomComparisonState: "", reportCompletionStatus: false, recentStatus: "New", symptomId: item.id, userId: AuthViewModel.getLoggedInUserId()))
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
                
                Button(action: {
                    dismiss()
                }) {
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
    let generalViewModel = GeneralViewModel()
    let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
    let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
    let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected
    
    SetSymptomContentPage(item: Symptom(symptomName: "Nausea", rating: 0, status: "", creationDateTime: Date.now, lastModifiedDateTime: Date.now, tracking: true, userId: ""), symptomName: "Nausea", loggedIn: Binding.constant(true), selectedSegment: 0)
        .environmentObject(generalViewModel)
        .environmentObject(symptomViewModel)
        .environmentObject(eventsViewModel)
        .environmentObject(reportingViewModel)
    
}
