//
//  SelectableButton.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-05-20.
//

import SwiftUI

struct SelectableButton: View {
    @State var title: String
    @Binding var toggleState: Bool
    var selectedForegroundColor = Color(.primary4)
    var selectedFontColor = Color(.primary4TTextOn4)
    var notSelectedForegroundColor = Color(.primary0)
    var notSelectedFontColor = Color(.primary0TTextOn0)
    
    var body: some View {
        HStack {
            Text(title)
                .foregroundColor((toggleState == true) ? selectedFontColor: notSelectedFontColor)
                .font(.titleinRowItem)
            Spacer()
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.white)
                .font(.system(size: 30))
                .opacity(toggleState ? 1: 0)
        }
        .padding()
        .background((toggleState == true) ? selectedForegroundColor: notSelectedForegroundColor)
        .cornerRadius(10)
        .contentShape(Rectangle()) // Explicitly sets the tappable area    }
    }
}

#Preview {
    SelectableButton(title: "", toggleState: Binding.constant(false))
}
