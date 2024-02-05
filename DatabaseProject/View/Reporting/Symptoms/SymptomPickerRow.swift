//
//  SymptomRowIteminPicker.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-09-25.
//

import SwiftUI

struct SymptomPickerRow: View {
    var item: SymptoPickerItem
    @Binding var showThirdView: Bool

    var body: some View {
            ZStack{
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color(.primary0))
                    .frame(maxWidth: .infinity, maxHeight: 62)
                
                HStack{
                    Text(item.symptomName)
                        .font(.symptomTitleinReportingPage)
                        .foregroundColor(Color("Primary0tTextOn0"))
                    
                    Spacer()
                    Button(action: {showThirdView=true}){
                        Image("ic-play-blue")
                    }
                //.padding(10)
            }
                .padding(10)
        }
    }
    
}

#Preview {
    SymptomPickerRow(item: SymptoPickerItem(symptomName: "N/A"), showThirdView: Binding.constant(false))//default value))
}
