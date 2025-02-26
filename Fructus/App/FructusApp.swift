//
//  FructusApp.swift
//  Fructus
//
//  Created by Aref Shalchi on 2/25/25.
//

import SwiftUI

@main
struct FructusApp: App {
    // MARK: - PROPERTIES
    @AppStorage("isOnboarding") var isOnboarding: Bool = false
    
    // MARK: - BODY
    var body: some Scene {
        WindowGroup {
            if isOnboarding {
                OnbordingView()
            } else {
                ContentView()
            }
        }
    }
}
