//
//  ExtensionPlaceholderforTextEditor.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-02-27.
//

import SwiftUI

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .topLeading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            if shouldShow { placeholder() }
            self
        }
    }
}
