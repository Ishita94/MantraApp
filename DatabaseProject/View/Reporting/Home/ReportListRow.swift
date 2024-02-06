//
//  ReportListRow.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-18.
//

import SwiftUI

struct ReportListRow: View {
    var item: Report
    
    var body: some View {
        ZStack{
            Image("ic-report-list-item-bordered")
                .resizable()
                .aspectRatio(contentMode: .fit)
            HStack {
                VStack{
                    Text(item.dayNameofWeek)
                        .font(.dayText)
                        .foregroundColor(Color("BlackMediumEmphasis"))
                    Text(item.monthNameofWeek)
                        .font(.dateText)
                }
                Spacer()
                ZStack{
                    Image("ic-report-list-item-blue-background")
                    
                    HStack{
                            Image(item.emojiIconName ?? "ic-incomplete-red-filled")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxHeight: 40)
                            //                            .font(.system(size: 14))
                            //                    .cornerRadius(10)
                        Spacer()
                        VStack{
                            Text(item.emojiStateofDay)
                                .font(.symptomTitleinReportingPage)
                                .foregroundColor(Color("Primary0tTextOn0"))
                            Text(item.symptomNames)
                                .font(.symptomSmallTitleinReportingPage)
                                .frame(maxWidth: 150, maxHeight: 20, alignment: .center)
                                .truncationMode(.tail)
                        }
                        Spacer()
                        Image("ic-play-blue")
                        
                    }
                    .padding(.horizontal)
                    
                }
            }
            .padding()
        
    }
}

    struct ReportListRow_Previews: PreviewProvider {
        static var previews: some View {
            ReportListRow(item: Report(dayNameofWeek: "Thu", monthNameofWeek: "Aug 20", dateString: Date.now.datetoString() ?? "", emojiIconName: "ic-incomplete-red-filled", emojiStateofDay: "Nauseous", symptomNames: "Nausea, Headache", reportCompletionStatus: false))
                .environmentObject(SymptomViewModel())
                .environmentObject(GeneralViewModel())
                .environmentObject(EventsViewModel())

        }
    }
}
