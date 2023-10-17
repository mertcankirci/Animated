//
//  ModeItem.swift
//  Animated
//
//  Created by Mertcan Kırcı on 23.07.2023.
//

import Foundation
import SwiftUI

struct ModeItem: Identifiable {
    var id = UUID().uuidString
    var name: String
    var exp: String
    var icon: Image
    var mode: Mode
}


enum Mode: String, Codable {
    case general
    case love
    case career
}
