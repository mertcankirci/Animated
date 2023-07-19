//
//  AnimatedApp.swift
//  Animated
//
//  Created by Mertcan Kırcı on 17.07.2023.
//

import SwiftUI

@main
struct AnimatedApp: App {
    
    let tabSelection = TabSelectionManager()

        var body: some Scene {
            WindowGroup {
                ContentView()
                    .environmentObject(tabSelection)
            }
    }
}
