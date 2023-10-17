//
//  GenderPicker.swift
//  Animated
//
//  Created by Mertcan Kırcı on 23.07.2023.
//

import SwiftUI

enum Gender: String, CaseIterable, Identifiable, Codable {
    case male = "Male"
    case female = "Female"
    case other = "Other"

    var id: String { self.rawValue }
}
