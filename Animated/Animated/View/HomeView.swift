//
//  HomeView().swift
//  Animated
//
//  Created by Mertcan Kırcı on 19.07.2023.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var type: FortuneType
    @Binding var show: Bool
    var body: some View {
        ZStack {
            
            Color("Background")
                .ignoresSafeArea()
            
            ScrollView(showsIndicators: false) {
                content
            }
            
            if type == .horoscope && show == true {
                ZodiacSignView(show: $show)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                            .fill(Color(hex:0x160C1E))
                    )
                    .mask(
                        RoundedRectangle(cornerRadius: 30, style: .continuous)
                    )
                    .shadow(color: .black.opacity(0.5), radius: 40, x: 0, y: 40)
                    .ignoresSafeArea(.all, edges: .top)
                    .transition(.move(edge: .top))
                    .offset(y: show ? -10 : 0)
                    .zIndex(1)
                    .environmentObject(ChooseModeViewModel())
                    .environmentObject(ZodiacSignViewModel())
            }
        }
    }
    
    var content: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Daily Fortune")
                .customFont(.largeTitle)
                .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(courses) { course in
                        VCard(course: course, isLocked: course.isLocked, show: $show)
                            .onTapGesture {
                                type = course.type
                                print(type)
                                withAnimation(.spring()) {
                                    show.toggle()
                                }
                                print(show)
                            }
                    }
                }
                .padding(20)
                .padding(.bottom, 10)
            }
                
                Text("Previus Fortune Telling")
                    .customFont(.title3)
                    .padding(.horizontal, 20)
            
            VStack(spacing: 20) {
                ForEach(courseSections) { section in
                    HCard(section: section, isLocked: section.isLocked)
                }
            }
            .padding(20)
                
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(type: .constant(.horoscope), show: .constant(true))
    }
}
