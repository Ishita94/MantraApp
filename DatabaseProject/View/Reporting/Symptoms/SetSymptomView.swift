//
//  SetSymptomView.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-10-01.
//

import SwiftUI

struct SetSymptomView: View {
    @State var item: Symptom
    @Binding var loggedIn: Bool

//    @Binding var path: NavigationPath
    var backButtonPlacement: ToolbarItemPlacement {
            #if os(iOS)
            ToolbarItemPlacement.navigationBarLeading
            #else
            ToolbarItemPlacement.navigation
            #endif
        }
    var body: some View {
        VStack{
            NavBar(loggedIn: $loggedIn)
            Divider()
            SecondaryNavBar()
            Divider()
            SetSymptomContentPage(item: item, symptomName: item.symptomName,  loggedIn: $loggedIn)
            //            Divider()
            //            BackandNextButtonPanel()
            //                .navigationTitle("Symptom Details")
            //                    .navigationBarBackButtonHidden()
            //                    .toolbar {
            //                        ToolbarItem(placement: backButtonPlacement) {
            //                            Button {
            //                                path.removeLast()
            //                            } label: {
            //                                Image(systemName: "chevron.left.circle")
            //                            }
            //
            //
            //                        }
            //                    }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
        
}

#Preview {
    NavigationStack{
        SetSymptomView(item: Symptom(symptomName: "Nausea", rating: 0, recentStatus: "", creationDateTime: Date.now, tracking: true, userId: ""), loggedIn: Binding.constant(true)).environmentObject(SymptomViewModel())
            .environmentObject(GeneralViewModel())
    }
}
