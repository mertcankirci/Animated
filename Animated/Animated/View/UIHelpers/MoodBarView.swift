//
//  MoodBarView.swift
//  Animated
//
//  Created by Mertcan Kırcı on 21.07.2023.
//

import SwiftUI

struct MoodBarView: View {
    
    @State var isSelected: Bool
    
    var body: some View {
        ScrollView(.vertical , showsIndicators: false) {
            HStack {
                ForEach(0..<5) { mood in
                    MoodBarItem(isSelected: $isSelected)
                }
            }
        }
    }
}

struct MoodBarView_Previews: PreviewProvider {
    static var previews: some View {
        MoodBarView(isSelected: false)
    }
}
