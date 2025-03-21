//
//  AddorEditSymptomButtonPanel.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-10-16.
//

import SwiftUI

struct AddorEditSymptomButtonPanel: View {
    @State var isSheetVisible: Bool = false
    @Binding var loggedIn: Bool
    @State var dateString: String

//    @Binding var path: NavigationPath

    var body: some View {
        VStack(alignment: .leading){
            Text("""
                How have you felt today compared to yesterday?
                """)
                .font(.titleinRowItem)
                .foregroundColor(.black)
            Button(action: {
                isSheetVisible = true
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.white)
                    Text("Add or edit list of symptoms")
                        .foregroundColor(.white)
                        .font(.titleinRowItem)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
                }
            }
            .padding()
            .buttonStyle(PlainButtonStyle())
            .background(Color(.primary4))
            .cornerRadius(10)
        
        
        
        }
        .sheet(isPresented: $isSheetVisible){
            ChooseSymptomView(isSheetVisible: $isSheetVisible, loggedIn: $loggedIn, dateString: dateString) /*.frame(maxWidth: .infinity, maxHeight: 680)*/
        }
        
    }
}

#Preview {
    AddorEditSymptomButtonPanel(loggedIn: Binding.constant(true), dateString: Date.now.datetoString()!)
}
