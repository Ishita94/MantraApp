//
//  BackandNextButtonPanel.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-24.
//

import SwiftUI

struct BackandNextButtonPanel: View {
    var body: some View {
        HStack{
            Button(action: {}) {
                HStack {
                    Image(systemName: "arrow.left")
                        .foregroundColor(Color(.disabledText))
                    Text("Back")
                        .foregroundColor(Color (.disabledText))
                }
            }
            .padding()
            .foregroundColor(Color(.disabledBackground))
            .background(Color(.disabledBackground))
            .cornerRadius(10)
            Spacer()
            Button(action: {}) {
                HStack {
                    Image(systemName: "arrow.right")
                        .foregroundColor(.white)
                    Text("Next").foregroundColor(.white)
                }
            }
            .padding()
            .foregroundColor(Color(.primary4))
            .background(Color(.primary4))
            .cornerRadius(10)
        }
//        .padding()
        .frame(maxWidth: .infinity, minHeight: 100)
    }
}

#Preview {
    BackandNextButtonPanel()
}
