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
    
    var body: some View {
        NavigationStack (){
            
            ZStack{
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.primary0))
                    .frame(maxWidth: .infinity, maxHeight: 100)
                HStack{
                    VStack(alignment: .leading){
                        HStack{
                            Text(item.title )
                                .font(.symptomTitleinReportingPage)
                                .foregroundColor(Color(.offBlackText))
                            
                            Text(item.recentStatus)
                            //.padding()
                                .background(Color(.warning1))
                                .foregroundStyle(.white)
                                .font(.symptomSmallTitleinReportedSymptomsPage)
                                .cornerRadius(6)
                                .frame(maxHeight: 27)
                            
                        }
                        Text("Severity Rating \(item.rating) /10")
                        //.padding()
                            .background(Color(.secondary2))
                            .foregroundStyle(Color(.white))
                            .font(.symptomSmallTitleinReportedSymptomsPage)
                            .cornerRadius(6)
                            .frame(maxHeight: 20)
                        if(item.symptomComparisonState.isEmpty == false) //symptom has been compared
                        {
                            Text("You feel \(item.symptomComparisonState.lowercased()).")
                            //.padding()
                                .background(Color(.secondary2))
                                .foregroundStyle(Color(.white))
                                .font(.symptomSmallTitleinReportedSymptomsPage)
                                .cornerRadius(6)
                                .frame(maxHeight: 20)
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
                        //                        ReportedSymptomswithRecommendationView(loggedIn: $loggedIn)
                        ChooseSymptomComparisonView(isSheetVisible: Binding.constant(true), item: item, loggedIn: $loggedIn)
                            .environmentObject(SymptomViewModel())/*.frame(maxWidth: .infinity, maxHeight: 680)*/
                    }
                    else
                    {
                        //TODO: pass the rating so that in the slider the rating is selected
                        SetSymptomView(item: Symptom(symptomName: item.symptomName, rating: item.rating, recentStatus: item.recentStatus, creationDateTime: item.creationDateTime, tracking: true, userId: item.userId), loggedIn: $loggedIn)
                        
                    }
                    
                }
            }
        }
    }
    
}

#Preview {
    ReportedEventRow(item: Event(title: "Went on a walk", category: "Physical Well-Being")
                     , loggedIn: Binding.constant(true)).environmentObject(GeneralViewModel())
}
