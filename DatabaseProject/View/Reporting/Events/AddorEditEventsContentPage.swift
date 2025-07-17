//
//  AddorEditEventsContentPage.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-10-30.
//

import SwiftUI

struct AddorEditEventsContentPage: View {
    @State var isSheetVisible: Bool = false
//    @State var showThirdView: Bool = true
    @Binding var loggedIn: Bool
    @State var dateString: String
    @State var creationDateTime: Date

    var body: some View {
        NavigationStack{
            VStack (){
                Text("""
                What events today might have affected your symptoms?
                """)
                    .foregroundColor(.black)
                    .font(.bigTitle)
                    .padding(12)
                
                Text("""
                You have not reported any new events today. Click the button below to add or edit events.
                """)
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
                        Text("Add or edit list of events")
                            .foregroundColor(.white)
                            .font(.titleinRowItem)
//                            .frame(maxWidth: .infinity)
                    }
                }
                .padding()
                .buttonStyle(PlainButtonStyle())
                .background(Color(.primary4))
                .cornerRadius(10)
            }
            .sheet(isPresented: $isSheetVisible){
                SuggestedEventsView(isSheetVisible: $isSheetVisible, loggedIn: $loggedIn, dateString: dateString, creationDateTime: creationDateTime) /*.frame(maxWidth: .infinity, maxHeight: 680)*/
            }
            
        }
//        .background(
//            NavigationLink(destination: SetSymptomView(symptomName: ""), isActive: $showThirdView) {
//                EmptyView()
//            }
//        )
    }
}

#Preview {
    AddorEditEventsContentPage(loggedIn: Binding.constant(true), dateString: Date.now.datetoString()!, creationDateTime: Date.now)
}
