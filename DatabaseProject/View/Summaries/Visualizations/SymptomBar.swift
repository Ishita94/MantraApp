//
//  SymptomBar.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-05-13.
//

import SwiftUI

struct SymptomBar: View {
    @EnvironmentObject var summariesViewModel : SummariesViewModel
    var selectedWeekDays: [CustomDateModel]
    var symptomName: String
    
    var body: some View {
        VStack (alignment: .leading, spacing: 4){
            Text(symptomName)
                .font(.keyRangeTitleinSummariesPage)
                .foregroundColor(Color(.primary0TTextOn0))
                .padding(.leading, 18)
            
            GeometryReader { geo in
                let spacing: CGFloat = 0
                let itemWidth = (geo.size.width - spacing * 6) / 7
                
                HStack (spacing: spacing){
                    let ratingsofSymptom : [SymptomReport] = summariesViewModel.dictionaryofSymptoms[symptomName]!
                    
                    ForEach(selectedWeekDays.indices, id: \.self){index in
                        let item = selectedWeekDays[index].dateString
                        let rating = ratingsofSymptom.first {$0.creationDateTime.datetoString() == item}?.rating ?? nil
                        SymptomBarItem(symptomRating: rating, isFirst: index == 0, isLast: index == selectedWeekDays.count - 1, itemWidth: itemWidth)
                            .frame(width: itemWidth, height: 50)
                    }
                }
            }
            .frame(height: 50)
        }
        .padding(.top, 4)
    }
}

#Preview {
    SymptomBar(selectedWeekDays: [], symptomName: "")
}
