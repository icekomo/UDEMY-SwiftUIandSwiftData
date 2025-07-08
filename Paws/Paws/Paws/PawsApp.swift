//
//  PawsApp.swift
//  Paws
//
//  Created by Josh Gdovin on 7/7/25.
//

import SwiftUI
import SwiftData

@main
struct PawsApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Pet.self)
        }
    }
}
