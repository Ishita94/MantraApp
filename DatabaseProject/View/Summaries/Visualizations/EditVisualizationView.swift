//
//  EditVisualizationView.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-05-06.
//

import SwiftUI

struct EditVisualizationView: View {
    @EnvironmentObject var summariesViewModel : SummariesViewModel
    @Environment(\.dismiss) var dismiss
    @Binding var showEmoji: Bool
    @Binding var showSymptoms: [String]
    @Binding var showEvents: [String]
    @State private var localShowEmoji = false
    @State private var localShowSymptoms: [ShowSymptomArrayItem] = []
    @State private var localShowEvents: [ShowEventArrayItem] = []
    
    
    private func fetchSymptomsAndEvents() {
        // Populate items based on what's already selected
        localShowSymptoms = summariesViewModel.dictionaryofSymptoms.elements.map {
            let wasPreviouslySelected = showSymptoms.contains($0.key)
            return ShowSymptomArrayItem(name: $0.key, isSelected: showSymptoms.isEmpty ? true : wasPreviouslySelected)
        }
        //TODO: Decide and fix
        localShowEvents = summariesViewModel.dictionaryofEvents.elements.map {
            let wasPreviouslySelected = showEvents.contains($0.key)
            return ShowEventArrayItem(name: $0.key, isSelected: showEvents.isEmpty ? false : wasPreviouslySelected) //event array by default false
        }
    }
    
    var body: some View {
        NavigationStack{
            VStack (alignment: .leading){
                Text("Please pick which of the following to visualize. By default, the graph shows all symptoms.")
                    .font(.tabTitleinSummariesPage)
                    .foregroundColor(.black)
                    .multilineTextAlignment(.leading)
                Divider()

                ScrollView{
                    VStack (alignment: .leading, spacing: 15){
                        if(summariesViewModel.reportListforSummary.count>0){
                            Button(action: {
                                showEmoji.toggle()
                            }) {
                                SelectableButton(title: "Show Emojis", toggleState: $showEmoji)
                            }
                            .buttonStyle(.plain)
                        }
                        else
                        {
                            DisabledStateButtonwithTitle(title: "No reports were logged in this period.")
                        }
                        
                        Divider()
                        
                        Text("Symptoms")
                            .font(.actionCompletionTitle)
                            .foregroundColor(.black)
                        VStack{
                            if(localShowSymptoms.count>0)
                            {
                                ForEach(localShowSymptoms.indices, id: \.self) { index in
                                    Button(action: {
                                        localShowSymptoms[index].isSelected.toggle()
                                    }) {
                                        SelectableButton(title: localShowSymptoms[index].name, toggleState: $localShowSymptoms[index].isSelected)
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            else{
                                DisabledStateButtonwithTitle(title: "No symptoms were logged in this period.")
                            }
                        }
                        .frame(maxWidth: .infinity)
                        
                        Divider()
                        
                        
                        Text("Events")
                            .font(.actionCompletionTitle)
                            .foregroundColor(.black)
                        VStack{
                            //TODO: Add code
                            if(localShowEvents.count>0){
                                
                            }
                            else{
                                DisabledStateButtonwithTitle(title: "No events were logged in this period.")
                            }
                        }
                    }
                    .scrollContentBackground(.hidden)
                }
                
                Spacer()
                
                Divider()
                
                Button(action: {
                    showSymptoms = localShowSymptoms
                        .filter { $0.isSelected }
                        .map { $0.name } // Send back selected names
                    dismiss()
                    
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
                    //                    showEmoji = false
                    //                    showSymptoms = []
                    //                    showEvents = []
                    
                    dismiss()
                }) {
                    HStack {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(Color(.warning2))
                        Text("Cancel")
                            .foregroundColor(Color(.warning2))
                            .font(.titleinRowItem)
                    }
                    .frame(maxWidth: .infinity)
                }
                .padding()
                .overlay( /// apply a rounded border
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color(.outlineGrey), lineWidth: 1)
                )
            }
            .onAppear {
                fetchSymptomsAndEvents()
            }
            .onReceive(summariesViewModel.$dictionaryofSymptoms) { _ in
                fetchSymptomsAndEvents()
            }
            .onReceive(summariesViewModel.$dictionaryofEvents) { _ in
                fetchSymptomsAndEvents()
            }
            .padding()
            //            .presentationDetents([.fraction(0.8), .large])
            
        }
    }
}

#Preview {
    let generalViewModel = GeneralViewModel()
    let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
    let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
    let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected
    let summariesViewModel = SummariesViewModel(generalViewModel: generalViewModel)  // Injected
    EditVisualizationView (showEmoji: Binding.constant(false), showSymptoms: Binding.constant([]), showEvents: Binding.constant([]))
        .environmentObject(generalViewModel)
        .environmentObject(symptomViewModel)
        .environmentObject(eventsViewModel)
        .environmentObject(reportingViewModel)
        .environmentObject(summariesViewModel)
}
