//
//  MoodBarItem.swift
//  Animated
//
//  Created by Mertcan Kırcı on 21.07.2023.
//

import SwiftUI

struct MoodBarItem: View {
    
    @Binding var isSelected: Bool
    
    var body: some View {
        Text("Yarrak")
            .padding(8)
            .background(
                isSelected ? Color.green : Color.white
            )
            .cornerRadius(8, corners: .allCorners)
            .onTapGesture {
                isSelected.toggle()
            }
    }
}

struct MoodBarItem_Previews: PreviewProvider {
    static var previews: some View {
        MoodBarItem(isSelected: .constant(true))
    }
}
