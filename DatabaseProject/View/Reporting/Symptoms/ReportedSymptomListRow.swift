//
//  ReportedSymptomListRow.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-10-03.
//

import SwiftUI

struct ReportedSymptomListRow: View {
    var item: SymptomReport
    @Binding var loggedIn: Bool
    @State var readyToNavigate: Bool = false
    @EnvironmentObject var generalViewModel : GeneralViewModel
//    @State var symptomComparisonState: String = "Much Better"
    @State var dateString: String

    var body: some View {
        NavigationStack (){

            ZStack{
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.primary0))
                    .frame(maxWidth: .infinity, minHeight: 100)
                HStack{
                    VStack(alignment: .leading){
                        HStack{
                            Text(item.symptomName )
                                .font(.symptomTitleinReportingPage)
                                .foregroundColor(Color(.primary0TTextOn0))
                            
                            Text(item.recentStatus)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color(.warning1))
                                .foregroundStyle(Color(.white))
                                .font(.symptomSmallTitleinReportedSymptomsPage)
                                .cornerRadius(6)
                                .frame(minHeight: 27)
                            
                        }
                        Text("Severity Rating \(item.rating) /10")
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color(.secondary2))
                            .foregroundStyle(Color(.white))
                            .font(.symptomSmallTitleinReportedSymptomsPage)
                            .cornerRadius(6)
                            .frame(minHeight: 20)
                        
                        if(item.symptomComparisonState.isEmpty == false) //symptom has been compared
                        {
                            Text("You feel \(item.symptomComparisonState.lowercased()).")
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Color(.secondary2))
                                .foregroundStyle(Color(.white))
                                .font(.symptomSmallTitleinReportedSymptomsPage)
                                .cornerRadius(6)
                                .frame(minHeight: 20)
                        }
                        
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
                    if(item.symptomComparisonState.isEmpty == false) //symptom has been compared
                    {
                        ChooseSymptomComparisonView(isSheetVisible: Binding.constant(true), symptomComparisonState: item.symptomComparisonState, item: item, loggedIn: $loggedIn, dateString: dateString, edit: true, selectedSegment: item.rating)
//                            .environmentObject(SymptomViewModel())/*.frame(maxWidth: .infinity, maxHeight: 680)*/
                    }
                    else
                    {
                        //TODO: check status
                        SetSymptomView(item: Symptom(id: item.id, symptomName: item.symptomName, rating: item.rating, status: "New", creationDateTime: item.creationDateTime, lastModifiedDateTime: item.lastModifiedDateTime, tracking: true, userId: item.userId), loggedIn: $loggedIn)
                        
                    }
                    
                }
            }
    }
}

}

#Preview {
ReportedSymptomListRow(item: SymptomReport(
    dateFormatted: "Aug 20, 2023", creationDateTime: Date.now, lastModifiedDateTime: Date.now, rating: 0, emojiIconName: "ic-incomplete-red-filled", symptomName: "Nausea", symptomComparisonState: "", reportCompletionStatus: false, recentStatus: "N/A", symptomId: "1", userId: ""), loggedIn: Binding.constant(true), dateString: Date.now.datetoString()!).environmentObject(GeneralViewModel())
}



