//
//  ChooseSymptomView.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-25.
//

import SwiftUI

struct ChooseSymptomView: View {
    @Binding var isSheetVisible: Bool
    @State var readyToNavigate: Bool = false
    @State private var path = NavigationPath()
    @Binding var loggedIn: Bool
    @EnvironmentObject var symptomViewModel : SymptomViewModel
    @Environment(\.dismiss) var dismiss
    @State var dateString: String
    
    var body: some View {
        NavigationStack (path: $path){
            ZStack{
                VStack (alignment: .leading)
                {
                    Text("""
                     Please choose up to 5 symptoms to understand more about your health.
                     """)
                    .foregroundColor(Color(.black))
                    .font(.titleinRowItem)
                    Divider()
                    Text("""
                If a symptom is not listed, click Add a new  symptom.
                """)
                    .foregroundColor(Color(.black))
                    .font(.regularText)
                    .padding(.bottom, 8.0)
                    
                    Button(action: {
                        readyToNavigate=true
                    }) {
                        HStack {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.white)
                            Text("Add new symptom")
                                .foregroundColor(.white)
                                .font(.titleinRowItem)
                                .frame(maxWidth: .infinity)
                        }
                    }
                    .padding()
                    .background(Color(.primary4))
                    .cornerRadius(10)
                    
                    Divider()
                
                    ScrollView{
                        ForEach(symptomViewModel.trackedSymptomsofUser, id: \.self) { item in
                            SymptomPickerRow(item: item, loggedIn: $loggedIn)
                        }
                        if(!symptomViewModel.trackedSymptomsofUser.contains(where: { $0.symptomName.lowercased() == "nausea" }))
                        {
                            SymptomPickerRow(item: Symptom(symptomName: "Nausea", rating: 0, status: "Tracked", creationDateTime: Date.now, lastModifiedDateTime: Date.now, tracking: false, userId: ""), loggedIn: $loggedIn)
                        }
                        if(!symptomViewModel.trackedSymptomsofUser.contains(where: { $0.symptomName.lowercased() == "fatigue" }))
                        {
                            SymptomPickerRow(item: Symptom(symptomName: "Fatigue", rating: 0, status: "Tracked", creationDateTime: Date.now, lastModifiedDateTime: Date.now, tracking: false, userId: ""),loggedIn: $loggedIn)
                        }
                        if(!symptomViewModel.trackedSymptomsofUser.contains(where: { $0.symptomName.lowercased() == "pain" }))
                        {
                            SymptomPickerRow(item: Symptom(symptomName: "Pain", rating: 0, status: "Tracked", creationDateTime: Date.now, lastModifiedDateTime: Date.now, tracking: false, userId: ""), loggedIn: $loggedIn)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .scrollContentBackground(.hidden)
                    
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
                
                .padding()
                .cornerRadius(30)
                .presentationDetents([.fraction(0.8), .large])
                //.frame(maxWidth: .infinity, maxHeight: 680)
                //                .navigationDestination(for: String.self) { symptomName in
                //
                //                    SetSymptomView(symptomName: symptomName)
                //
                //                }
                
                
            }
            .navigationDestination(isPresented: $readyToNavigate) {
                SetSymptomView(item: Symptom(symptomName: "", rating: 0, status: "", creationDateTime: Date.now,  lastModifiedDateTime: Date.now, tracking: true, userId: ""), loggedIn: $loggedIn)
                //create symptom on that specified date, instead of current date
            }
        }
        .onAppear()
        {
            symptomViewModel.getTrackedSymptomsofUser()
        }
    }
}

#Preview {
    let generalViewModel = GeneralViewModel()
    let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
    let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
    let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected
    
    
    ChooseSymptomView(isSheetVisible: Binding.constant(true), loggedIn: Binding.constant(true), dateString: Date.now.datetoString()!)
        .environmentObject(generalViewModel)
        .environmentObject(symptomViewModel)
        .environmentObject(eventsViewModel)
        .environmentObject(reportingViewModel)
}
