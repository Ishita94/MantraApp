//
//  SuggestedSymptomsListRow.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-12-23.
//

import SwiftUI

struct SuggestedSymptomsListRow: View {
    var item: SymptomReport
    @State var isSheetVisible: Bool = false
    @Binding var loggedIn: Bool
    @State var dateString: String

    var body: some View {
        ZStack{
            if #available(iOS 17.0, *) {
                RoundedRectangle(cornerRadius: 16)
                    .strokeBorder(Color(.outlineGrey), style: StrokeStyle(lineWidth: 2, dash: [10]))
                    .fill(Color(.greyNonClickable))
                
                    .frame(maxWidth: .infinity, maxHeight: 92)
            }
            else
            {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.greyNonClickable))
                    .frame(maxWidth: .infinity, maxHeight: 92)
            }
            HStack{
                Image(systemName: "x.square.fill")
                    .foregroundColor(Color(.warning2))
                    .cornerRadius(12)
                    .font(.system(size: 33))
                VStack(alignment: .leading){
                    HStack{
                        
                        Text(item.symptomName)
                            .font(.symptomTitleinReportedSymptomsPage)
                            .foregroundColor(Color(.outlineDarker))
                        
//                        Text(item.recentStatus)
//                        //.padding()
//                            .background(Color(.warning1))
//                            .foregroundStyle(.white)
//                            .font(.symptomSmallTitleinReportedSymptomsPage)
//                            .cornerRadius(6)
//                            .frame(maxHeight: 27)
                        
                    }
                    Text("Severity level " + "\(item.rating)" + " on \(item.creationDateTime.formatted(date: .abbreviated, time: .omitted))")
//                        .background(Color(.secondary2))
                        .foregroundStyle(Color(.outlineDarker))
                        .font(.regularText)
                        .cornerRadius(6)
                        .frame(maxHeight: 51)
                }.padding(.top, 10)
                Spacer()
                Button(action: {
                    isSheetVisible = true
                }) {
                    Image("ic-plus-blue-filled-rectangle")
                    }
            }
            .padding()
        }
        .sheet(isPresented: $isSheetVisible){
            ChooseSymptomComparisonView(isSheetVisible: $isSheetVisible, item: item, loggedIn: $loggedIn, dateString: dateString, edit: false)
//                .environmentObject(SymptomViewModel())/*.frame(maxWidth: .infinity, maxHeight: 680)*/
        }
    }
}

#Preview {
    SuggestedSymptomsListRow(item: SymptomReport(dateFormatted: "", creationDateTime: Date.now, lastModifiedDateTime: Date.now, rating: 0, emojiIconName: "ic-incomplete-red-filled", symptomName: "", symptomComparisonState: "", reportCompletionStatus: false, recentStatus: "", symptomId: "", userId: ""), loggedIn: Binding.constant(true), dateString: Date.now.datetoString()!)
}
