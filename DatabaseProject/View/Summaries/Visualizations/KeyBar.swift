//
//  KeyBar.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2025-05-06.
//

import SwiftUI

struct KeyBar: View {
    @State private var sliderValue: Double = 0.5
    private let numberOfSegments = 10 // Number of segments
    @State private var selectedColorIndex: Double = 0
    let totalGapWidth: CGFloat = 9*4
    
    var body: some View {
        VStack (alignment: .leading) {
            Text("Key")
                .font(.keyTitleinSummariesPage)
                .foregroundStyle(.black)
                .padding(.top, 4)
            
            GeometryReader { geometry in
                VStack{
                    HStack(spacing: 4) {
                        let width = RatingRectangleUtils.getSegmentWidth(totalWidth: geometry.size.width-totalGapWidth, numberOfSegments: numberOfSegments)
                        LeftRoundedRectangle(cornerRadius: 12)
                            .fill(RatingRectangleUtils.colorForSegment(0))
                            .frame(width: max(0, width))
                        ForEach(1..<numberOfSegments-1, id: \.self) { segment in
                                Rectangle()
                                .fill(RatingRectangleUtils.colorForSegment(segment))
                                    .frame(width: max(0, width))
                        }
                        RightRoundedRectangle(cornerRadius: 12)
                            .fill(RatingRectangleUtils.colorForSegment(numberOfSegments-1))
                            .frame(width: max(0, width))
                    }
                    .frame(maxHeight: 26)
                }
            }
            .frame(height: 26 ) // Controls vertical space
            HStack{
                Text("Better than \nyesterday")
                    .foregroundColor(Color(.black))
                    .font(.smallTitle)
                Spacer()
                Text("Worse than \nyesterday")
                    .foregroundColor(Color(.black))
                    .font(.smallTitle)
            }
//            .padding(.top, 4.0)
        }
    }
}

#Preview {
    KeyBar()
}
