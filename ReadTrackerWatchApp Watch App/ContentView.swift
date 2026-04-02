//
//  ContentView.swift
//  ReadTrackerWatchApp Watch App
//
//  Created by Rei Soemanto on 02/04/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var iOSConnectivityManager: iOSConnectivity = iOSConnectivity()
    @State private var showAddBookView: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Text("Welcome to ReadTracker Watch OS!")
                NavigationLink("Add new book", value: "")
                    .padding(.top, 15)
            }
            .navigationDestination(for: String.self, destination: { value in
                AddNewBookView(iOSConnectivityManager: iOSConnectivityManager, isPresented: $showAddBookView)
            })
        }
    }
}

#Preview {
    ContentView()
}
