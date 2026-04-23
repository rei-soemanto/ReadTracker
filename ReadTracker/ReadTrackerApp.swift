//
//  ReadTrackerApp.swift
//  ReadTracker
//
//  Created by Rei Soemanto on 20/02/26.
//

import SwiftUI
import Firebase
import FirebaseAppCheck

@main
struct ReadTrackerApp: App {
    @StateObject private var bookViewModel = BookViewModel()
    @StateObject private var dailyReadViewModel = DailyReadViewModel()
    @StateObject var authVM = AuthViewModel()
    
    init() {
        FirebaseApp.configure()
        
        #if DEBUG
            let providerFactory = AppCheckDebugProviderFactory()
            AppCheck.setAppCheckProviderFactory(providerFactory)
        #endif
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(bookViewModel)
                .environmentObject(dailyReadViewModel)
        }
    }
}
