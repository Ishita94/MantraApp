//
//  ReportListRowforNewEntry.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-18.
//

import SwiftUI

struct ReportListRowforNewEntry: View {
    var item: Report
    @EnvironmentObject var symptomController : SymptomViewModel
    @EnvironmentObject var eventController : EventsViewModel
    @Binding var loggedIn: Bool
    
    var body: some View {
//        NavigationStack{
            ZStack{
                Image("ic-report-list-item-bordered")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                HStack {
                        VStack{
                            Text(Date.now.dayNameOfWeek()!)
                            //item.date.dayNameOfWeek()!
                                .font(.dateText)
                                .foregroundColor(Color("BlackMediumEmphasis"))
                            
                            Text(Date.now.monthandDate()!)
                                .font(.dateText)
                        
                        }
                    Spacer()
                    ZStack{
                        Image("ic-report-list-item-blue-background")
                        
                        HStack{
                            Image(systemName:"plus")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 30)
                                .foregroundColor(Color(.primary4))
                            //                            .font(.system(size: 8))
                            NavigationLink {
                                AddorEditSymptomsLandingPage(loggedIn: $loggedIn, date: Date.now, dateString: Date.now.datetoString()!)
//                                    .environmentObject(GeneralViewModel())
//                                    .environmentObject(EventsViewModel())
                                
                            } label: {
                                Text("Add Today's Report")
                                    .aspectRatio(contentMode: .fit)
                                    .font(.system(size: 18))
                                    .padding()
                                    .foregroundColor(Color("Primary4tTextOn4"))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.white, lineWidth: 2)
                                    ).background(Color("Primary4")) // If you have this
                                    .cornerRadius(10)         // You also need the cornerRadius here
                            }
                            
                        }
                        
                    }
                    
                }
                .padding()
            }
        }
}


struct ReportListRowforNewEntry_Previews: PreviewProvider {
    static var previews: some View {
        ReportListRowforNewEntry(item: Report(dayNameofWeek: "Thu", monthNameofWeek: "2023-09-09", dateString: Date.now.datetoString() ?? "", emojiIconName: "ic-incomplete-red-filled", emojiStateofDay: "Nauseous", symptomNames: "Nausea, Headache", reportCompletionStatus: false), loggedIn: Binding.constant(true))
            .environmentObject(SymptomViewModel())
            .environmentObject(GeneralViewModel())
            .environmentObject(EventsViewModel())

    }
    }

