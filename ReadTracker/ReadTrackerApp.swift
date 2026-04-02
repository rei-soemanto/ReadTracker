//
//  ReadTrackerApp.swift
//  ReadTracker
//
//  Created by Rei Soemanto on 20/02/26.
//

import SwiftUI

@main
struct ReadTrackerApp: App {
    @StateObject private var bookViewModel = BookViewModel()
    @StateObject private var dailyReadViewModel = DailyReadViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(bookViewModel)
                .environmentObject(dailyReadViewModel)
        }
    }
}
