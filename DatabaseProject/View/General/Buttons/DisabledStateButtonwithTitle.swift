//
//  DisabledStateButtonwithTitle.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-05-21.
//

import SwiftUI

struct DisabledStateButtonwithTitle: View {
    @State var title: String
    
    var body: some View {
        Button(action: {}) {
            Text(title)
                .foregroundColor(Color(.offBlackText))
                .font(.titleinRowItem)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(Color(.greyNonClickable))
                .cornerRadius(10)
        }
        .allowsHitTesting(false)
        .buttonStyle(.plain) // Avoids system styling
    }
}

#Preview {
    DisabledStateButtonwithTitle(title: "")
}
