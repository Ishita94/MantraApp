//
//  CustomTopBackButton.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-04-03.
//

import SwiftUI

struct CustomBackButtonLabel: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    CustomBackButtonLabel()
}

struct CustomBackLabel: View {
    var text: String  // 👈 Accept external text

    var body: some View {
        HStack {
            Image(systemName: "arrow.left.circle.fill")
                .foregroundColor(.green)
            Text(text)  // ✅ Use the passed text here
                .fontWeight(.semibold)
        }
    }
}
