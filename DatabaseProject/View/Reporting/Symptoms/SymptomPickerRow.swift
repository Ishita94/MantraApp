//
//  SymptomRowIteminPicker.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-25.
//

import SwiftUI

struct SymptomPickerRow: View {
    var item: Symptom
    @State var readyToNavigate: Bool = false
    @Binding var loggedIn: Bool

//    @Binding var showThirdView: Bool

    var body: some View {
            ZStack{
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.primary0))
                    .frame(maxWidth: .infinity, maxHeight: 62)
                
                HStack{
                    Text(item.symptomName)
                        .font(.symptomTitleinReportingPage)
                        .foregroundColor(Color("Primary0tTextOn0"))
                    if(item.tracking){
                        if(item.status=="Resolved"){
                            Text(item.status)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color(.secondary2))
                                .foregroundStyle(Color(.white))
                                .font(.symptomSmallTitleinReportedSymptomsPage)
                                .cornerRadius(6)
                                .frame(minHeight: 20)
                        }
                        else if (item.status=="Tracked"){
                            Text(item.status)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color(.primary4EElementsOn4))
                                .foregroundStyle(Color(.white))
                                .font(.symptomSmallTitleinReportedSymptomsPage)
                                .cornerRadius(6)
                                .frame(minHeight: 20)
                        }
                    }
                    else{
                        Text("Suggestion")
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color(.warning1))
                            .foregroundStyle(Color(.white))
                            .font(.symptomSmallTitleinReportedSymptomsPage)
                            .cornerRadius(6)
                            .frame(minHeight: 20)
                    }
                    Spacer()
                    if(!item.tracking){
                        NavigationLink {
                            SetSymptomView(item: item, loggedIn: $loggedIn)
                            
                        } label: {
//                            SymptomPickerRow(item: item)
                            Image("ic-play-blue")
//                                    .padding(.vertical, 5)
                        }
                        
                        //                    Button(action: {showThirdView=true}){
                        //                        Image("ic-play-blue")
                        //                    }
                        //.padding(10)
                    }
                }
                .padding()
        }
    }
    
}

#Preview {
    SymptomPickerRow(item: Symptom(symptomName: "Nausea", rating: 0, status: "", creationDateTime: Date.now, lastModifiedDateTime: Date.now, tracking: true,  userId: ""), loggedIn: Binding.constant(true))//default value))
}
