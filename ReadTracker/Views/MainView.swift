//
//  MainView.swift
//  ReadTracker
//
//  Created by Rei Soemanto on 27/02/26.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var authVM: AuthViewModel
    @State var showAuthState = false
    
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
            
            UserAccountView(showAuthSheet: $showAuthState)
                .tabItem {
                    Label("Account", systemImage: "person")
                }.badge("!")
        }
        
        .onAppear {
            showAuthState = !authVM.isSignedIn
        }
        
        .sheet(isPresented: $showAuthState) {
            LoginRegisterSheet(showAuthSheet: $showAuthState)
        }
    }
}

#Preview {
    MainView()
        .environmentObject(BookViewModel())
        .environmentObject(DailyReadViewModel())
        .environmentObject(AuthViewModel())
}
