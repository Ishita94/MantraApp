//
//  ReportedEventRow.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-12-23.
//

import SwiftUI

struct ReportedEventRow: View {
    @State var item: Event
    @Binding var loggedIn: Bool
    @State var readyToNavigate: Bool = false
    @EnvironmentObject var generalViewModel : GeneralViewModel
    @State var dateString: String

    var body: some View {
        NavigationStack (){
            
            ZStack{
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.primary0))
                    .frame(maxWidth: .infinity, maxHeight: 100)
                HStack{
                    VStack(alignment: .leading){
                        Text(item.title)
                            .font(.symptomTitleinReportingPage)
                            .foregroundColor(Color(.primary0TTextOn0))
                        
                        Text(item.category)
                            .padding(.horizontal, 4)
                            .padding(.vertical, 4)
                            .background(Color(.secondary2))
                            .foregroundStyle(Color(.white))
                            .font(.symptomSmallTitleinReportedSymptomsPage)
                            .cornerRadius(6)
                            .frame(maxHeight: 20)
                    }
                    //.padding(.top, 10)
                    Spacer()
                    Button(action: {
                        readyToNavigate=true
                    }) {
                        Image("ic-edit")
                        
                    }
                }
                .padding()
            }
            .sheet(isPresented: $readyToNavigate){
                SetEventView(item: item,  title: item.title,  loggedIn: $loggedIn, isSheetVisible: true, selection: item.category, dateString: dateString)
            }
//            .navigationDestination(isPresented: $readyToNavigate) {
//                
//                SetEventView(item: item,  title: item.title,  loggedIn: $loggedIn, isSheetVisible: true, selection: item.category, dateString: dateString)
//                
//            }
        }
    }
    
}

#Preview {
    ReportedEventRow(item: Event(title: "Went on a walk", category: "Physical Well-Being", creationDateTime: Date.now, lastModifiedDateTime: Date.now,  userId: "", tracking: true)
                     , loggedIn: Binding.constant(true), dateString: Date.now.datetoString()!).environmentObject(GeneralViewModel())
}
