//
//  Course.swift
//  AnimatedApp
//
//  Created by Meng To on 2022-04-14.
//

import SwiftUI

struct Course: Identifiable {
    var id = UUID()
    var title: String
    var subtitle: String
    var caption: String
    var color: Color
    var image: Image
    var isLocked: Bool
    var type: FortuneType
}

var courses = [
    Course(title: "Daily Horospoce Analysis", subtitle: "Explore your daily potential by your sign !", caption: "KNOW YOUR DAY BEFORE IT STARTS", color: Color(hex: 0x6792FF), image: Image("planet"), isLocked: false, type: .horoscope),
    Course(title: "Daily Cookie Fortune", subtitle: "Findout your daily fortune and explore your day's potential !", caption: "1 CLICK - 1 AMAZING DAY", color: Color(hex: 0x7850F0), image: Image("cookie"), isLocked: false, type: .cookie),
    Course(title: "Tarot Card", subtitle: "Learn about your day by your tarot picks.", caption: "3 CARD - 1 DAY", color: Color(hex: 0x005FE7), image: Image("Topic 1"), isLocked: true, type: .tarot)
]

enum FortuneType: String {
    case horoscope
    case cookie
    case tarot
}
