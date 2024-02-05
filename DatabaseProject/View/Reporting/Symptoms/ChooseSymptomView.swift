//
//  ChooseSymptomView.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-25.
//

import SwiftUI

struct ChooseSymptomView: View {
    @Binding var isSheetVisible: Bool
    @Binding var showThirdView: Bool

    @State var reportedItems:[SymptoPickerItem] = [
        SymptoPickerItem(symptomName: "Nausea"),
        SymptoPickerItem(symptomName: "Fatigue"),
        SymptoPickerItem(symptomName: "Pain")]
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack (){
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
                    Text("""
                     Swipe left on a symptom to delete it from the list.
                    """)
                    .foregroundColor(Color(.black))
                    .font(.regularText)
                    .padding(.bottom, 22.0)
                    Button(action: {}) {
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
                    
                    List(reportedItems) { item in
//                        SymptomPickerRow(item: item, showThirdView: $showThirdView)
//                            .listRowSeparator(.hidden)
//                            .listRowInsets(EdgeInsets())
                        
                        NavigationLink {
                            SetSymptomView(symptomName: item.symptomName)
                                .onAppear(){
                                    showThirdView=true
                                }
                        } label: {
                            SymptomPickerRow(item: item, showThirdView: $showThirdView)
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets())
                        }
                        
                        
                           
                        
                        
                    }
                    
                    .frame(maxWidth: .infinity)
                    .scrollContentBackground(.hidden)
                    .listStyle(.plain)
                    
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
                    .padding()
                    .background(Color(.primary4))
                    .cornerRadius(10)
                    
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
                .padding()
                .cornerRadius(30)
            }
            .presentationDetents([.fraction(0.8), .large])
            //.frame(maxWidth: .infinity, maxHeight: 680)
        }
    }
}

#Preview {
    ChooseSymptomView(isSheetVisible: Binding.constant(true), showThirdView:  Binding.constant(false))//default value)
}
