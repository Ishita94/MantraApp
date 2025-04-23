//
//  SymptomComparisonListRow.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-10-15.
//

import SwiftUI

struct SymptomComparisonListRow: View {
    @State var imageName = ""
    @State var stateName = ""
    @Binding var symptomComparisonState: String

    
    var body: some View {
        ZStack{
            Button(action: {
                if(symptomComparisonState==stateName){
                    symptomComparisonState = "" //reset selection
                }
                else {
                    symptomComparisonState = stateName //select it
                }
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color(.outlineGrey), lineWidth: 1)
                        .frame(height: 56)
                        .background(stateName==symptomComparisonState ? Color(.secondary2) : Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))  // Clips the background to match rounded corners

                    

                    HStack{
                        Image(imageName)
                        Spacer()
                        Text(stateName)
                            .font(.titleinRowItem)
                            .foregroundColor(stateName==symptomComparisonState ? Color(.primary4TTextOn4) : Color.black)
                        Spacer()
                        if (stateName==symptomComparisonState) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(Color.white)
                                .font(.titleinRowItemEditable)
                        }
                    }.padding()
                    
                }
            }
        }
    }
}

#Preview {
    SymptomComparisonListRow(symptomComparisonState: Binding.constant("Much Better"))
}
