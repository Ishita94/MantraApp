//
//  AddorEditSymptomsLandingPage.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-24.
//

import SwiftUI

struct AddorEditSymptomsLandingPage: View {
    @State var isSheetVisible: Bool = false
//    @State var showThirdView: Bool = false

    var body: some View {
        VStack{
            NavBar()
            Divider()
            SecondaryNavBar()
            Divider()
            AddorEditSymptomsContentView()
            Divider()
            BackandNextButtonPanel()
        }
//        .sheet(isPresented: $isSheetVisible)
//        {
//            ChooseSymptomView(isSheetVisible: $isSheetVisible, showThirdView: $showThirdView) //default value
//        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    AddorEditSymptomsLandingPage()
}
