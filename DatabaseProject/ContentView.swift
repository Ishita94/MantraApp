//
//  ContentView.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-04.
//

import SwiftUI

struct ContentView: View {
    
    init(){
            
    }
    var body: some View {
        
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!").font(.navLargeTitle)
            
        }
                        
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
