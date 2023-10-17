//
//  VCard.swift
//  Animated
//
//  Created by Mertcan Kırcı on 19.07.2023.
//

import SwiftUI

struct VCard: View {
    
    var course: Course
    var cookie = 3
    @State var isLocked: Bool
    @Binding var show: Bool

    
    var body: some View {
        if isLocked {
            locked
        }
        else {
            notLocked
        }
    }
    
    var locked: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(course.title)
                .customFont(.title2)
                .frame(maxWidth: 150, alignment: .leading)
                .layoutPriority(1)
            
            Text(course.caption.uppercased())
                .customFont(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(course.subtitle)
                .customFont(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .opacity(0.7)
            
            
            
            Spacer()
            
        }
        .foregroundColor(.white)
        .padding(30)
        .frame(width: 260, height: 310)
        .background(
            .linearGradient(colors: [.gray, .black.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .mask {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
        }
        .shadow(color: course.color.opacity(0.3), radius: 8, x: 0, y: 12)
        .shadow(color: course.color.opacity(0.3), radius: 2, x: 0, y: 1)
        .opacity(0.6)
        .overlay(
            Image(systemName: "lock.fill")
              
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .foregroundColor(.white)
                .padding(20)
        )
        .onTapGesture{
            withAnimation(.spring()) {
                show.toggle()
            }
        }

    }
    
    var notLocked: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(course.title)
                .customFont(.title2)
                .frame(maxWidth: 150, alignment: .leading)
                .layoutPriority(1)
            
            Text(course.caption.uppercased())
                .customFont(.subheadline)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text(course.subtitle)
                .customFont(.footnote)
                .frame(maxWidth: .infinity, alignment: .leading)
                .opacity(0.7)
            
            
            
            Spacer()
            
            HStack {
                ForEach(Array([4 ,5].shuffled().enumerated()), id: \.offset) { index, number in
                    HStack {
                        course.image
                            .resizable()
                            .frame(width: 44, height: 44)
                            .mask(Circle())
                            .offset(x: CGFloat(index * -20))
                    }
                        
                }
                Text("+ 2")
                    .customFont(.title2)
                    .offset(x: -20)
                    
            }
        }
        .foregroundColor(.white)
        .padding(30)
        .frame(width: 260, height: 310)
        .background(
            .linearGradient(colors: [course.color, course.color.opacity(0.5)], startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .mask {
            RoundedRectangle(cornerRadius: 30, style: .continuous)
        }
        .shadow(color: course.color.opacity(0.3), radius: 8, x: 0, y: 12)
        .shadow(color: course.color.opacity(0.3), radius: 2, x: 0, y: 1)
        .overlay(
            course.image
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                .foregroundColor(.white)
                .padding(20)
        )

    }
}

struct VCard_Previews: PreviewProvider {
    static var previews: some View {
        VCard(course: courses[0], isLocked: false, show: .constant(false))
    }
}
