//
//  SetSymptomRatingView.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-10-01.
//

import SwiftUI

struct SetSymptomRatingView: View {
    @State private var sliderValue: Double = 0.5
    private let numberOfSegments = 10 // Number of segments
    @State private var selectedColorIndex: Double = 0
    let totalGapWidth: CGFloat = 9*1
    @EnvironmentObject var generalViewModel : GeneralViewModel
    @Binding var selectedSegment: Int
    
    func thumbOffset(totalWidth: CGFloat)-> CGFloat {
        if (selectedSegment==0) {
            return 0
        }
        else {
            let width = RatingRectangleUtils.getSegmentWidth(totalWidth: totalWidth, numberOfSegments: numberOfSegments)
            return (CGFloat(selectedSegment) * width + width / 2).rounded()
        }
    }
    var body: some View {
        GeometryReader { geometry in
            VStack{
                HStack{
                    Text("Rating")
                        .foregroundColor(Color(.blackMediumEmphasis))
                        .font(.regularText)
                    Spacer()
                    Text("\(selectedSegment)/10")
                        .foregroundColor(Color(.blackMediumEmphasis))
                        .font(.ratingofSymptom)
                }
                .padding(.bottom, 50.0)
                
                ZStack(alignment: .leading) {
                    // Colored segments
                    HStack(spacing: 1) {
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
                    // Slider thumb
                    Circle()
                        .fill(Color.white)
                        .overlay(
                            Circle()
                                .stroke(Color(.secondary4), lineWidth: 6) // Green border
                        )
//                        .frame(width: max(0, getSegmentWidth(totalWidth:  geometry.size.width) - 5), height: 25) // Adjust the size of the thumb
                        .frame(width: max(0, RatingRectangleUtils.getSegmentWidth(totalWidth: geometry.size.width - 5, numberOfSegments: numberOfSegments)), height: 25) // Adjust the size of the thumb
                        .offset(x: thumbOffset(totalWidth: geometry.size.width)-2.5) // To set at the beginning
                        .gesture(DragGesture().onChanged { value in
                            let width = RatingRectangleUtils.getSegmentWidth(totalWidth: geometry.size.width-totalGapWidth
                                                                             , numberOfSegments: numberOfSegments)
                            let newPosition = value.location.x - width / 2
                            let newIndex = max(0, min(numberOfSegments-1, Int(newPosition / width)))
                            selectedSegment = newIndex
                            print("Selected: \(selectedSegment)")
                            sliderValue = Double(newIndex)
                        })
                }
                .frame(maxHeight: 16)
                
                HStack{
                    Text("0 - Absent")
                        .foregroundColor(Color(.blackMediumEmphasis))
                        .font(.ratingofSymptomScaleText)
                    Spacer()
                    Text("10 - Very severe")
                        .foregroundColor(Color(.blackMediumEmphasis))
                        .font(.ratingofSymptomScaleText)
                }
                .padding(.top, 4.0)
                
            }
        }
    }
}

#Preview {
    SetSymptomRatingView(selectedSegment: Binding.constant(0))
        .environmentObject(GeneralViewModel())
}

