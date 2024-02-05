//
//  SwiftUIView.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-24.
//

import SwiftUI

struct AddorEditSymptomsContentView: View {
    @State var isSheetVisible: Bool = false
    @State var showThirdView: Bool = false

    var body: some View {
        VStack (){
            
            
            Text("How have you felt today compared to yesterday?")
                .foregroundColor(Color(.black))
                .font(.bigTitle)
                .padding(12)
            
            Text("You have not been tracking any symptoms yet. Click the button below to add or edit symptoms.")
                .foregroundColor(Color(.blackMediumEmphasis))
                .font(.regularText)
                .multilineTextAlignment(.center)
                .frame(maxWidth: 275)
                .padding(.bottom, 23)
            
            Button(action: {
                isSheetVisible = true
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.white)
                    Text("Add or edit list of symptoms")
                        .foregroundColor(.white)
                        .font(.titleinRowItem)
                }
            }
            .padding()
            .buttonStyle(PlainButtonStyle())
            .background(Color(.primary4))
            .cornerRadius(10)
        }
        .sheet(isPresented: $isSheetVisible){
            ChooseSymptomView(isSheetVisible: $isSheetVisible, showThirdView: $showThirdView) /*.frame(maxWidth: .infinity, maxHeight: 680)*/
        }
        .background(
            NavigationLink(destination: SetSymptomView(symptomName: ""), isActive: $showThirdView) {
                            EmptyView()
                      }
                )
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    AddorEditSymptomsContentView()
}
