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
    //let segmentWidth: CGFloat
    @EnvironmentObject var mainController : GeneralViewModel

//    @Binding var selectedSegment: Int

//    init() {
//            // Calculate the segment width based on the number of segments
//            segmentWidth = UIScreen.main.bounds.width / CGFloat(numberOfSegments)
//        }
        let colors: [Color] = [
            Color(.scale1), Color(.scale2), Color(.scale3), Color(.scale4), Color(.scale5), Color(.scale6), Color(.scale7),Color(.scale8), Color(.scale9), Color(.scale10)
        ]
    func colorForSegment(_ segment: Int) -> Color {
        
        return colors[segment % colors.count]
    }
    func getSegmentWidth(totalWidth: CGFloat) -> CGFloat {
        let width = totalWidth / CGFloat(numberOfSegments)
        return width
    }

    
    func thumbOffset(totalWidth: CGFloat)-> CGFloat {
        if (mainController.selectedSegment==0) {
            return 0
        }
        else {
            return CGFloat(mainController.selectedSegment) * getSegmentWidth(totalWidth: totalWidth) + getSegmentWidth(totalWidth: totalWidth) / 2
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
                    Text("\(mainController.selectedSegment)/10")
                        .foregroundColor(Color(.blackMediumEmphasis))
                        .font(.ratingofSymptom)
                }
                .padding(.bottom, 50.0)
                
                ZStack(alignment: .leading) {
                    // Colored segments
                    HStack(spacing: 0) {
                        ForEach(0..<numberOfSegments, id: \.self) { segment in
                            Rectangle()
                                .fill(colorForSegment(segment))
                                .frame(width: getSegmentWidth(totalWidth: geometry.size.width))
                        }
                    }
                    
                    // Slider thumb
                    Circle()
                        .fill(Color.white)
                        .overlay(
                            Circle()
                                .stroke(Color(.secondary4), lineWidth: 6) // Green border
                        )
                        .frame(width: getSegmentWidth(totalWidth:  geometry.size.width) - 5, height: 25) // Adjust the size of the thumb
                        .offset(x: thumbOffset(totalWidth: geometry.size.width)-2.5) // To set at the beginning
                        .gesture(DragGesture().onChanged { value in
                            let newPosition = value.location.x - getSegmentWidth(totalWidth:  geometry.size.width) / 2
                            let newIndex = max(0, min(numberOfSegments - 1, Int(newPosition / getSegmentWidth(totalWidth: geometry.size.width))))
                            mainController.selectedSegment = newIndex
                            print("Selected: \(mainController.selectedSegment)")
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
    SetSymptomRatingView()
        .environmentObject(GeneralViewModel())
}

