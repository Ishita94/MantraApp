//
//  SuggestedEventRow.swift
//  DatabaseProject
//
//  Created by Ishita Haque on 2023-12-23.
//

import SwiftUI
extension View {
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S : ShapeStyle {
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
        return clipShape(roundedRect)
             .overlay(roundedRect.strokeBorder(content, lineWidth: width))
    }
}
struct SuggestedEventRow: View {
    @State var item: Event
    @Binding var loggedIn: Bool
    @State var readyToNavigate: Bool = false
    @EnvironmentObject var generalViewModel : GeneralViewModel
    @Binding var selectedEvents: [Event]

    var body: some View {
            ZStack{
                if(!readyToNavigate){
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.primary0))
                        .frame(maxWidth: .infinity, maxHeight: 100)
                }
                else
                {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.primary4))
                        .frame(maxWidth: .infinity, maxHeight: 100)
                }
                HStack{
                    VStack(alignment: .leading){
                        if(!readyToNavigate){
                            Text(item.title)
                                .font(.symptomTitleinReportingPage)
                                .foregroundColor(Color(.primary0TTextOn0))
                        }
                        else
                        { Text(item.title)
                                .font(.symptomTitleinReportingPage)
                                .foregroundColor(Color.white)
                            
                        }
                        
                        Text(item.category)
                            .background(Color(.secondary2))
                            .foregroundStyle(Color(.white))
                            .font(.symptomSmallTitleinReportedSymptomsPage)
                            .cornerRadius(4)
                            .frame(maxHeight: 20)
                    }
                    //.padding(.top, 10)
                    Spacer()
                    
                    Button(action: {
                        readyToNavigate.toggle()
                        if(readyToNavigate){
                            if(selectedEvents.contains(where: { $0.title.lowercased() == item.title.lowercased() &&  $0.category.lowercased() == item.category.lowercased()}) == false)
                            {
                                selectedEvents.append(item)
                            }
                        }
                        else
                        {
                            if(selectedEvents.contains(where: { $0.title.lowercased() == item.title.lowercased() &&  $0.category.lowercased() == item.category.lowercased()}) == true)
                            {
                                selectedEvents.removeAll(where: { $0.title.lowercased() == item.title.lowercased() &&  $0.category.lowercased() == item.category.lowercased()})
                            }
                        }
                    }) {
                        if(!readyToNavigate){
                            Circle()
                                .fill(Color.white)
                                .frame(width: 25, height: 25)
                                .addBorder(Color(.primary0EElementsOn0), width: 2, cornerRadius: 20)
                            
                            
                            //                        Image("ic-edit")
                            
                        }
                        
                        else
                        {
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(Color.white)
//                                .background(Color.white)
                                .font(.bigTitle)                        }
                    }
                }
                .padding()
            
        }
    }
    
}

#Preview {
    SuggestedEventRow(item: Event(title: "Went on a walk", category: "Physical Well-Being", creationDateTime: Date.now, userId: "", tracking: false)
                      , loggedIn: Binding.constant(true), selectedEvents: Binding.constant([])).environmentObject(GeneralViewModel())
}
