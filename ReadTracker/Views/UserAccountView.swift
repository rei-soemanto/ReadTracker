//
//  UserAccountView.swift
//  ReadTracker
//
//  Created by Rei Soemanto on 27/02/26.
//

import SwiftUI

struct UserAccountView: View {
    @Binding var showAuthSheet: Bool
    @EnvironmentObject var authVM: AuthViewModel
    
    var body: some View {
        Text("This is account view")
        
        Button("Logout") {
            authVM.signOut()
            authVM.checkUserSession()
            showAuthSheet = !authVM.isSignedIn
        }
        .tint(.gray)
        .buttonStyle(.borderedProminent)
    }
}

#Preview {
    UserAccountView(showAuthSheet: .constant(true)).environmentObject(AuthViewModel())
}
