//
//  ReportListRow.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-18.
//

import SwiftUI

struct ReportListRow: View {
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
                        Image(item.emojiIconName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxHeight: 40)
//                            .font(.system(size: 14))
                        //                    .cornerRadius(10)
                        VStack{
                            Text(item.emojiStateofDay)
                                .font(.symptomTitleinReportingPage)
                                .foregroundColor(Color("Primary0tTextOn0"))
                            Text(item.symptoms)
                                .font(.symptomSmallTitleinReportingPage)
                        }
                        Image("ic-play-blue")
                        
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

    struct ReportListRow_Previews: PreviewProvider {
        static var previews: some View {
            ReportListRow(item: ReportListItem(day: "Thu", date: "Aug 20", emojiIconName: "ic-incomplete-red-filled",
                                               emojiStateofDay: "Nauseous", symptoms: "Nausea, Headache"))
        }
    }
}
