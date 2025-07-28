//
//  WatchListApp.swift
//  WatchList
//
//  Created by Josh Gdovin on 7/25/25.
//

import SwiftUI
import SwiftData

@main
struct WatchListApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: Movie.self)
        }
    }
}
