//
//  MainView.swift
//  ReadTracker
//
//  Created by Rei Soemanto on 27/02/26.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            BookListView()
                .tabItem {
                    Label("Books", systemImage: "magnifyingglass")
                }
            
            DailyReadView()
                .tabItem {
                    Label("Read", systemImage: "book")
                }
            
            UserAccountView()
                .tabItem {
                    Label("Account", systemImage: "person")
                }.badge("!")
        }
    }
}

#Preview {
    MainView()
        .environmentObject(BookViewModel())
        .environmentObject(DailyReadViewModel())
}
