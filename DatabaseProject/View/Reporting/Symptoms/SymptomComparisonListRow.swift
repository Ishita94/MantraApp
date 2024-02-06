//
//  SymptomComparisonListRow.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-10-15.
//

import SwiftUI

struct SymptomComparisonListRow: View {
    @State var pressed = false
    @State var imageName = "much-better"
    @State var stateName = "Much Better"
    @Binding var symptomComparisonState: String

    var body: some View {
        ZStack{
            
            Button(action: {
                self.pressed.toggle()
                if(self.pressed){
                    symptomComparisonState = stateName
                }
                else {
                    symptomComparisonState = ""
                }
            }) {
                ZStack {
                    RoundedRectangle(cornerRadius: 10)
                        .strokeBorder(Color(.outlineGrey), lineWidth: 1)
                        .frame(height: 56)
                        .background(self.pressed ? Color(.secondary2) : Color.white)
                    
                    HStack{
                        Image(imageName)
                        Spacer()
                        Text(stateName)
                            .font(.titleinRowItem)
                            .foregroundColor(self.pressed ? Color(.primary4TTextOn4) : Color.black)
                        Spacer()
                        if self.pressed {
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
