//
//  TeknoASApp.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 16.01.2025.
//

import SwiftUI
import SwiftData

@main
struct TeknoASApp: App {
    let modelContainer: ModelContainer

    init() {
        do {
            modelContainer = try ModelContainer(for: SCIbans.self)
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(modelContainer)
    }
}
