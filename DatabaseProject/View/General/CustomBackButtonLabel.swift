//
//  CustomTopBackButton.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-04-03.
//

import SwiftUI

struct CustomBackButtonLabel: View {
    var text: String = "Back"  // 👈 Accept external text

    var body: some View {
        HStack {
            Image(systemName: "arrow.left.circle.fill")
                .foregroundColor(.green)
            Text(text)  // ✅ Use the passed text here
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    CustomBackButtonLabel()
}
