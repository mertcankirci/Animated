//
//  MenuItem.swift
//  Animated
//
//  Created by Mertcan Kırcı on 19.07.2023.
//

import Foundation
import RiveRuntime

struct MenuItem: Identifiable {
    var id = UUID()
    var text: String
    var icon: RiveViewModel
    var menu: SelectedMenu
}


enum SelectedMenu: String {
    case home
    case search
    case favourites
    case help
    case history
    case notifications
    case darkmode
}
