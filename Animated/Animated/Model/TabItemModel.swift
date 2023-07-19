//
//  TabItemModel.swift
//  Animated
//
//  Created by Mertcan Kırcı on 18.07.2023.
//

import Foundation
import RiveRuntime

struct TabItem: Identifiable {
    var id = UUID()
    var icon: RiveViewModel
    var tab: Tab
}

enum Tab: String {
    case chat
    case search
    case timer
    case bell
    case user
}

