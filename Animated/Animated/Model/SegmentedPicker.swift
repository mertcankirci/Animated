//
//  SegmentedPicker.swift
//  Animated
//
//  Created by Mertcan Kırcı on 28.07.2023.
//

import Foundation

enum Interval: String, CaseIterable, Identifiable {
    case daily = "Daily"
    case weekly = "Weekly"
    case monthly = "Monthly"
    case yearly = "Yearly"
    
    var id: String { self.rawValue }
}
