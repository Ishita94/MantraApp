//
//  ChooseSymptomComparisonView.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-10-05.
//

import SwiftUI

struct ChooseSymptomComparisonView: View {
    @Binding var isSheetVisible: Bool
    @State var symptomComparisonState : String
    @State var readyToNavigate: Bool = false
    @State var item: SymptomReport
    @EnvironmentObject var symptomController : SymptomViewModel
    @EnvironmentObject var generalViewModel : GeneralViewModel
    @Environment(\.dismiss) var dismiss
    @Binding var loggedIn: Bool
    @State var dateString: String
    @State var edit: Bool
    @State var selectedSegment: Int

    var body: some View {
        NavigationStack{
            ZStack{
                VStack (alignment: .leading){
                    Divider()
                    VStack {
                        Text("Title")
                            .foregroundColor(Color(.blackMediumEmphasis))
                            .font(.regularText)
                            .padding(.bottom, 11.0)
                    }
                    
                    TextEditor(text: $item.symptomName)
                        .padding(4)
                        .background(Color.clear)
                        .foregroundColor(Color(.blackMediumEmphasis))
                        .font(.titleinRowItemEditable)
                        .overlay( /// apply a rounded border
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color(.outlineGrey), lineWidth: 1)
                        )
                        .frame(height: 56)
                    
                    Text("""
                        You rated your symptom \(item.rating)/10 last time. Please rate today on a scale of 0 to 10, with 0 being an absence of symptom and 10 being very severe.
                        """)
                    .foregroundColor(Color(.blackMediumEmphasis))
                    .font(.regularText)
                    .padding(.bottom, 9.0)
                    
                    Divider()
                    
                    SetSymptomRatingView(selectedSegment: $selectedSegment)
                    
                    Text("""
                        How have you felt today compared to last time?
                        """)
                    .foregroundColor(Color(.blackMediumEmphasis))
                    .font(.regularText)
                    .padding(.bottom, 9.0)
                    
                    Divider()
                    
                    ScrollView{
                        ForEach(symptomController.symptomStatesforComparison, id: \.self) { state in
                            SymptomComparisonListRow( imageName: state.imageName, stateName: state.stateName, symptomComparisonState: $symptomComparisonState)
                        }
                    }
                    Divider()
                    
                    
                    Button(action: {
                        if(!edit){ //create new symptom report
                            symptomController.setSymptomReportofTrackedSymptom(symptomReport: SymptomReport(creationDateTime: prepareDate(dateString: dateString)!, lastModifiedDateTime: Date.now, rating: selectedSegment,
                                                                                                            symptomName: item.symptomName,  symptomComparisonState: symptomComparisonState, reportCompletionStatus: false, recentStatus: "New", symptomId: item.symptomId,
                                                                                                            userId: item.userId))
                        }
                        else
                        {
                            symptomController.editSymptomReport(symptomReport: SymptomReport(id: item.id, creationDateTime: prepareDate(dateString: dateString)!, lastModifiedDateTime: Date.now, rating: selectedSegment,
                                                                                                            symptomName: item.symptomName,  symptomComparisonState: symptomComparisonState, reportCompletionStatus: false, recentStatus: "New", symptomId: item.symptomId,
                                                                                             userId: item.userId))
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
                                    .font(.smallTitle)
                                    .frame(maxWidth: .infinity)
                            }
                        }
                        .padding()
                        .overlay( /// apply a rounded border
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color(.outlineGrey), lineWidth: 1)
                        )
                        
//                        Button(action: {}) {
//                            HStack {
//                                Image(systemName: "xmark.bin.fill")
//                                    .foregroundColor(.white)
//                                Text("Remove symptom")
//                                    .foregroundColor(.white)
//                                    .font(.smallTitle)
//                                    .frame(maxWidth: .infinity)
//                            }
//                        }
//                        .padding()
//                        .background(Color(.warning2))
//                        .cornerRadius(10)
                    }
                    .padding()
                    .cornerRadius(30)
                
                
            }
            .navigationDestination(isPresented: $readyToNavigate) {
                    AddorEditSymptomsLandingPage(loggedIn: $loggedIn, dateString: dateString,
                        showAfterCreatingNewSymptomReport: true)
            }
            .presentationDetents([.fraction(0.8), .large])
            //.frame(maxWidth: .infinity, maxHeight: 680)
        }
    }
}


#Preview {
    let generalViewModel = GeneralViewModel()
    let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
    let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
    let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected
    
    ChooseSymptomComparisonView(isSheetVisible: Binding.constant(true), symptomComparisonState: "Much Better", item: SymptomReport(
        dateFormatted: "Aug 20, 2023", creationDateTime: Date.now, lastModifiedDateTime: Date.now, rating: 0, emojiIconName: "ic-incomplete-red-filled", symptomName: "", symptomComparisonState: "Much Better", reportCompletionStatus: false, recentStatus: "N/A", symptomId: "", userId: ""), loggedIn: Binding.constant(true), dateString: Date.now.datetoString()!, edit: false, selectedSegment: 0)//default value)
        .environmentObject(generalViewModel)
        .environmentObject(symptomViewModel)
        .environmentObject(eventsViewModel)
        .environmentObject(reportingViewModel)
}
