//
//  NavBar.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-18.
//

import SwiftUI

struct NavBar: View {
    var body: some View {
        Text("Report your day")
            .foregroundColor(Color(.greyText))
            .font(.regularText)
            .multilineTextAlignment(.leading)
    }
}

struct NavBar_Previews: PreviewProvider {
    static var previews: some View {
        NavBar()
    }
}
