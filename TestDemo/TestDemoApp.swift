//
//  TestDemoApp.swift
//  TestDemo
//
//  Created by Apple on 23/04/2026.
//

import SwiftUI

@main
struct TestDemoApp: App {
    @StateObject private var appEnvironment = AppEnvironment()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appEnvironment)
        }
    }
}
