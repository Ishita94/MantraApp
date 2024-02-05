//
//  ReportListRowforNewEntry.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-18.
//

import SwiftUI

struct ReportListRowforNewEntry: View {
    var item: ReportListItem

    var body: some View {
        ZStack{
            Image("ic-report-list-item-bordered")
                .resizable()
                .aspectRatio(contentMode: .fit)
            HStack {
                VStack{
                    Text(item.day)
                        .font(.dayText)
                        .foregroundColor(Color("BlackMediumEmphasis"))
                    Text(item.date)
                        .font(.dateText)
                }
                ZStack{
                    Image("ic-report-list-item-blue-background")
                    
                    HStack{
                        Image(systemName:"plus")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(height: 30)
                            .foregroundColor(.white)
//                            .font(.system(size: 8))
                        
                        Button(action: {
                                print("Add Today's Report")
                            }) {
                                Text("Add Today's Report")
                                    .aspectRatio(contentMode: .fit)
                                    .font(.system(size: 18))
                                    .padding()
                                    .foregroundColor(Color("Primary4tTextOn4"))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(Color.white, lineWidth: 2)
                                )
                            }
                            .background(Color("Primary4")) // If you have this
                            .cornerRadius(10)         // You also need the cornerRadius here
                        
                        }
                        
                    }
                    
                }
            }
        .listRowSeparator(.hidden)
//        .listRowBackground(
//            Color(.brown)
//                .opacity(0.1)
//        )
        //.border(ShapeStyle: )
    }
}


struct ReportListRowforNewEntry_Previews: PreviewProvider {
    static var previews: some View {
        ReportListRowforNewEntry(item: ReportListItem(day: "Thu", date: "Aug 20", emojiIconName: "ic-incomplete-red-filled",
                                           emojiStateofDay: "Nauseous", symptoms: "Nausea, Headache"))
    }
    }

