//
//  SecondaryNavBar.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-24.
//

import SwiftUI

struct SecondaryNavBar: View {
    @State private var stepNumber: String = "1"
    @State private var stepTitle: String = "Report your symptoms"
    @State var currentStateIndex: Int = 0
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            TopProgressBarView(currentStateIndex: $currentStateIndex)
            Text("Step "+stepNumber)
                .foregroundColor(Color(.greyText))
                .font(.regularText)
                
            Text(stepTitle)
                .foregroundColor(Color(.black))
                .font(.symptomTitleinReportingPage)
            //Spacer()
        }
//        .padding()
        
        .frame(maxWidth: .infinity, minHeight: 100)
    }
}

#Preview {
    SecondaryNavBar()
    
}
