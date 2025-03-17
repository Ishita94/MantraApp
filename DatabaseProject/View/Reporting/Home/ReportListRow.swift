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
                .aspectRatio(contentMode: .fit)
            HStack {
                VStack (alignment:.trailing){
                    Text(item.dayNameofWeek)
                        .font(.dayText)
                        .foregroundColor(Color("BlackMediumEmphasis"))
                    Text(item.monthNameofWeek)
                        .font(.dateText)
                        .foregroundColor(Color("BlackMediumEmphasis"))
                }
                Spacer()
                ZStack{
                    Image("ic-report-list-item-blue-background")
                    
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
                        Spacer()
                        VStack{
                            Text(item.emojiStateofDay.isEmpty ? "Incomplete report": item.emojiStateofDay )
                                .font(.symptomTitleinReportingPage)
                                .foregroundColor(Color("Primary0tTextOn0"))
                            Text(item.symptomNames)
                                .font(.symptomSmallTitleinReportingPage)
                                .foregroundColor(Color("BlackMediumEmphasis"))
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
