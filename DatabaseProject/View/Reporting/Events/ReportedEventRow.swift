//
//  ReportedEventRow.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-12-23.
//

import SwiftUI

struct ReportedEventRow: View {
    @State var item: EventReport
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
                            .background(Color(.secondary2))
                            .foregroundStyle(Color(.white))
                            .font(.symptomSmallTitleinReportedSymptomsPage)
                            .cornerRadius(4)
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
                .navigationDestination(isPresented: $readyToNavigate) {
                    
                    //TODO: edit Event
                    SetEventView(item: Event(title: item.title, category: item.category, creationDateTime: item.creationDateTime, userId: item.userId, tracking: false),  title: item.title,  loggedIn: $loggedIn, isSheetVisible: true, selection: item.category, dateString: dateString, eventReportItem: item)
                    
                }
            }
        }
    }
    
}

#Preview {
    ReportedEventRow(item: EventReport(title: "Went on a walk", category: "Physical Well-Being", creationDateTime: Date.now, userId: "", reportCompletionStatus: false)
                     , loggedIn: Binding.constant(true), dateString: Date.now.datetoString()!).environmentObject(GeneralViewModel())
}
