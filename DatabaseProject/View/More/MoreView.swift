//
//  MoreView.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-18.
//

import SwiftUI

struct MoreView: View {
    @Binding var loggedIn: Bool

    var body: some View {
        NavigationStack{
            VStack(alignment: .leading, spacing: 15){
                TitleBarforMoreTab(loggedIn: $loggedIn)
                VStack (spacing: 12){
                    ForEach(MoreMenuOption.allCases, id: \.self) { item in
                        OptionRow(loggedIn: $loggedIn, option: item)
                    }
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)    }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView(loggedIn: Binding.constant(true))
    }
}
