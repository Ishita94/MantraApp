//
//  SetSymptomView.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-10-01.
//

import SwiftUI

struct SetSymptomView: View {
    @State var symptomName: String
    var body: some View {
        VStack{
            NavBar()
            Divider()
            SecondaryNavBar()
            Divider()
            SetSymptomContentPage(symptomName: symptomName)
//            Divider()
//            BackandNextButtonPanel()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)    }
        
}

#Preview {
    SetSymptomView(symptomName: "")
}
