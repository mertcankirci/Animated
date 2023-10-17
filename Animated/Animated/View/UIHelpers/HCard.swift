//
//  HCard.swift
//  Animated
//
//  Created by Mertcan Kırcı on 19.07.2023.
//

import SwiftUI

struct HCard: View {
    
    var section: CourseSection
    @State var isLocked: Bool
    
    var body: some View {
        if isLocked {
            locked
        }
        else {
            notLocked
        }
    }
    
    var locked: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                Text(section.title)
                    .customFont(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(section.caption)
                    .customFont(.body)
            }
            Divider()
            Image(systemName: "lock.fill")
                .foregroundColor(.white)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 110)
        .background(
            .linearGradient(colors: [.gray, .black.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .foregroundColor(.white)
        .mask(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
        )
    }
    
    var notLocked: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading, spacing: 8) {
                Text(section.title)
                    .customFont(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(section.caption)
                    .customFont(.body)
            }
            Divider()
            section.image
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: 110)
        .background(section.color)
        .foregroundColor(.white)
        .mask(
            RoundedRectangle(cornerRadius: 30, style: .continuous)
        )
    }
}

struct HCard_Previews: PreviewProvider {
    static var previews: some View {
        HCard(section: courseSections[0], isLocked: false)
    }
}
