//
//  ReportListRow.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-18.
//

import SwiftUI
import EmojiPicker

struct ReportListRow: View {
    var item: Report
    let emojis: [Emoji] = DefaultEmojiProvider().getAll()

    var body: some View {
        ZStack{
            Image("ic-report-list-item-bordered")
                .resizable()
//                .aspectRatio(contentMode: .fit)
            HStack {
                VStack (alignment:.trailing){
                    Text(item.dayNameofWeek)
                        .font(.dayText)
                        .foregroundColor(Color("BlackMediumEmphasis"))
                    Text(item.monthNameofWeek)
                        .font(.dateText)
                        .foregroundColor(Color("BlackMediumEmphasis"))
                }
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .fill(Color(.primary0))
                        .frame(width: 265, height: 72)
                    HStack{
                        if item.emojiValue.isEmpty
                        {
                            Image("ic-incomplete-red-filled")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxHeight: 40)
                            //                            .font(.system(size: 14))
                            //                    .cornerRadius(10)
                        }
                        else
                        {
                            Text(item.emojiValue)
                                .font(.navLargeTitle)
                        }
//                        Spacer()
                        VStack (alignment: .leading, spacing: 4){
                            if item.emojiStateofDay.isEmpty
                            {
                                Text("Incomplete\nReport")
                                    .font(.regularText)
                                    .foregroundColor(Color("Primary0tTextOn0"))
                                    .multilineTextAlignment(.leading)
                            }
                            else
                            {
                                Text( item.emojiStateofDay )
                                    .font(.symptomTitleinReportingPage)
                                    .foregroundColor(Color("Primary0tTextOn0"))
                            }
                            Text(item.symptomNames.isEmpty ? " " : item.symptomNames)
                                .font(.symptomSmallTitleinReportingPage)
                                .foregroundColor(Color("BlackMediumEmphasis"))
                                .frame(maxWidth: 150, maxHeight: 20)
                                .lineLimit(1) // Prevents wrapping
                                .truncationMode(.tail)
                        }

                        Spacer()
                        Image("ic-play-blue")
                    }
                    .padding(10)
                }
            }
            .padding(10)
        
    }
}

    struct ReportListRow_Previews: PreviewProvider {
        static var previews: some View {
            let generalViewModel = GeneralViewModel()
            let symptomViewModel = SymptomViewModel(generalViewModel: generalViewModel)  // Injected
            let eventsViewModel = EventsViewModel(generalViewModel: generalViewModel)  // Injected
            let reportingViewModel = ReportingViewModel(generalViewModel: generalViewModel)  // Injected
            
            ReportListRow(item: Report(id:"", dayNameofWeek: "", monthNameofWeek: "", dateString: "", emojiStateofDay: "", symptomNames: "",reportCompletionStatus: false, description: "", questions: "", notes: "", symptomCompletionStatus: false, eventCompletionStatus: false,    descriptionCompletionStatus: false, questionsandNotesCompletionStatus: false, emojiCompletionStatus: false, creationDateTime: Date.now, userId: AuthViewModel.getLoggedInUserId()))
                .environmentObject(generalViewModel)
                .environmentObject(symptomViewModel)
                .environmentObject(eventsViewModel)
                .environmentObject(reportingViewModel)
        }
    }
}
