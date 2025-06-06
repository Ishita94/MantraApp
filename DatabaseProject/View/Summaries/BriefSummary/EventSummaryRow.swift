//
//  EventSummaryRow.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-05-05.
//

import SwiftUI

struct EventSummaryRow: View {
//    var title: String
    var events: [Event]
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 16)
                .foregroundColor(Color(.greyNonClickable)) // this is the actual fill

            RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.outlineGrey), lineWidth: 1)
              
            //TODO: Fix
            if(events.count==0){
                    Text("On Tuesday, August 2, you started a new medication, which may have affected how your symptoms trended.")
                        .padding(.horizontal, 20)
                        .padding(.vertical, 16)
                        .font(.regularText)
                        .foregroundColor(Color(.offBlackText))
                        .multilineTextAlignment(.leading)
            }
           
        }
    }
}

#Preview {
    EventSummaryRow(events: [])
}
