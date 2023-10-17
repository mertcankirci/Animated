//
//  CourseSection.swift
//  AnimatedApp
//
//  Created by Meng To on 2022-04-14.
//

import SwiftUI

struct CourseSection: Identifiable {
    var id = UUID()
    var title: String
    var caption: String
    var color: Color
    var image: Image
    var isLocked: Bool
}

var courseSections = [
    CourseSection(title: "Horoscope Sign", caption: "Look into your past favourite horoscope fortunes", color: Color(hex: 0x6E6AE8), image: Image("planet"), isLocked: false),
    CourseSection(title: "Cookie Fortune", caption: "Read your past cookie fortunes again", color: Color(hex: 0x9CC5FF), image: Image("cookie"), isLocked: false),
    CourseSection(title: "Tarot Card", caption: "Look into your past Tarot fortunes", color: Color(hex: 0x005FE7), image: Image("Topic 2"), isLocked: true),
]
