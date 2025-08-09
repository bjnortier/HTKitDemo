//
//  SwishDemoApp.swift
//  SwishDemo
//
//  Created by Ben Nortier on 2025/05/26.
//

@preconcurrency import AVFoundation
import SwiftUI

@main
struct SwishDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView2()
                #if os(macOS)
                    .padding()
                #endif
        }
        #if os(macOS)
            .windowResizability(.contentSize)
        #endif
    }
}
