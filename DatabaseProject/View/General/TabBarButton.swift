//
//  CustomTabBarButton.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-05-08.
//

import SwiftUI

struct TabBarButton: View {
    @State var imageName: String
    @State var titleName: String
    @State var isActive: Bool
    
    var body: some View {
        VStack (alignment: .center, spacing: 9){
            Image(imageName)
                .renderingMode(.template)
                .resizable()
                .scaledToFit()
                .frame(width: 50, height: 50)
            Text(titleName)
                .font(.tabTitle)
        }
        .tint(isActive ? Color(.primary4) : Color(.tabUnselected))
    }
}
    #Preview {
        TabBarButton(imageName: "ic_round-add-comment", titleName: "Reporting", isActive: true)
    }

