//
//  WeekDayBar.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-05-15.
//

import SwiftUI

struct WeekDayBar: View {
    @EnvironmentObject var summariesViewModel : SummariesViewModel

    var body: some View {
        GeometryReader { geo in
            let spacing: CGFloat = 0
            let itemWidth = (geo.size.width - spacing * 6) / 7

            HStack (spacing: spacing){
                ForEach(summariesViewModel.selectedWeekDays, id: \.self) { date in
                    VStack{
                        Text(date.shortDay)
                            .font(.smallRegularText)
                        Text(date.monthandDate)
                            .font(.dateinWeekDayBar)
                    }
                    .frame(width: itemWidth, height: 40)
                }
            }
        }
        .frame(height: 40)
    }
}

#Preview {
    WeekDayBar()
}
