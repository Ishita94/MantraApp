//
//  AddorEditEventButtonPanel.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-12-28.
//

import SwiftUI

struct AddorEditEventButtonPanel: View {
    @State var isSheetVisible: Bool = false
    @Binding var loggedIn: Bool
    @State var dateString: String

//    @Binding var path: NavigationPath

    var body: some View {
        VStack(alignment: .leading){
            Text("""
             What events today might have affected your symptoms?
             """)
                .font(.titleinRowItem)
                .foregroundColor(.black)
            Button(action: {
                isSheetVisible = true
            }) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.white)
                    Text("Add or edit list of events")
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
            SuggestedEventsView(isSheetVisible: $isSheetVisible, loggedIn: $loggedIn, dateString: dateString) /*.frame(maxWidth: .infinity, maxHeight: 680)*/
        }
        
    }
}

#Preview {
    AddorEditEventButtonPanel(loggedIn: Binding.constant(true), dateString: Date.now.datetoString()!)
}
