//
//  SwiftUIView.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-24.
 //Reference: "https:\//www.kodeco.com/books/swiftui-cookbook/v1.0/chapters/8-make-a-custom-segmented-progress-bar-in-swiftu


import SwiftUI

struct TopProgressBarView: View {
    @State private var progressOne: CGFloat = 1.0
    @State private var progressTwo: CGFloat = 1.0
    @State private var progressThree: CGFloat = 1.0
    @State private var progressFour: CGFloat = 1.0
    @State private var progressFive: CGFloat = 1.0
    @State private var progressState: [Bool] = [false, false, false, false, false]
    
    @Binding var currentStateIndex: Int
//    func determinColor() -> String {
//        
//    }
    
    var body: some View {
        GeometryReader { geometry in
                HStack() {
                    RoundedRectangle(cornerRadius: 3)
                        .foregroundColor(progressState[0] ? Color(.secondary4) : Color(.greyText))                .frame(height: 10)
                        .frame(maxWidth: progressOne * geometry.size.width / 5)
                    RoundedRectangle(cornerRadius: 3)
                        .foregroundColor(progressState[1] ? Color(.secondary4) : Color(.greyText))
                        .frame(height: 10)
                        .frame(maxWidth: progressTwo * geometry.size.width / 5)
                    RoundedRectangle(cornerRadius: 3)
                        .foregroundColor(progressState[2] ? Color(.secondary4) : Color(.greyText))                .frame(height: 10)
                        .frame(maxWidth: progressThree * geometry.size.width / 5)
                    RoundedRectangle(cornerRadius: 3)
                        .foregroundColor(progressState[3] ? Color(.secondary4) : Color(.greyText))                .frame(height: 10)
                        .frame(maxWidth: progressFour * geometry.size.width / 5)
                    RoundedRectangle(cornerRadius: 3)
                        .foregroundColor(progressState[3] ? Color(.secondary4) : Color(.greyText))                .frame(height: 10)
                        .frame(maxWidth: progressFour * geometry.size.width / 5)
                }
            }
            .frame(maxHeight: 24)
        }
        
}

#Preview {
    TopProgressBarView(currentStateIndex: Binding.constant(0)) //default value
}
