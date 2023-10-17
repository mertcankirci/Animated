//
//  ChooseItemView.swift
//  Animated
//
//  Created by Mertcan Kırcı on 23.07.2023.
//

import SwiftUI

struct ChooseItemView: View {
    
    var item: ModeItem
    @Binding var selectedMode: Mode
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                item.icon
                    .foregroundColor(Color(hex: 0xf77d8e))
                Text(item.name)
                    .customFont(.title3)
            }
            .opacity(selectedMode == item.mode ? 1 : 0.7)
            
            .padding(.vertical, 8)
            
            Text(item.exp)
                .customFont(.subheadline)
        }
        .foregroundColor(selectedMode == item.mode ? .white : Color("Background 2"))
        .cornerRadius(10)
        .frame(width: 150)
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color("Background 2"))
                .frame(maxWidth: selectedMode == item.mode ? .infinity : 0)
                .frame(maxWidth: .infinity, alignment: .leading)
        )
        .cornerRadius(10)
        .background(
            Color.white
                .cornerRadius(10)
                
        )
        
        .onTapGesture {
            withAnimation(.timingCurve(0.2, 0.8, 0.2, 1)) {
                selectedMode = item.mode
            }
    }
        
    }
    
    
}

var modeList = [
    ModeItem(name: "General", exp: "General Life", icon: Image(systemName: "gearshape.fill"), mode: .general),
    ModeItem(name: "Love", exp: "Love Life", icon: Image(systemName: "heart.fill"), mode: .love),
    ModeItem(name: "Career", exp: "Career Life", icon: Image(systemName: "books.vertical.fill"), mode: .career)
]

struct ChooseItemView_Previews: PreviewProvider {
    static var previews: some View {
        ChooseItemView(item: modeList[0], selectedMode: .constant(.general))
    }
}
