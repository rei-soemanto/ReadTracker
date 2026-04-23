//
//  AuthViewModel.swift
//  ReadTracker
//
//  Created by Rei Soemanto on 23/04/26.
//

import Combine
import Foundation
import FirebaseAuth

@MainActor
class AuthViewModel: ObservableObject {
    @Published var user: User?
    @Published var isSignedIn: Bool
    @Published var myUser: MyUser
    
    @Published var falseCredentials: Bool
    
    init() {
        self.user = nil
        self.isSignedIn = false
        self.falseCredentials = false
        self.myUser = MyUser()
        self.checkUserSession()
    }
    
    func checkUserSession() {
        self.user = Auth.auth().currentUser
        self.isSignedIn = self.user != nil
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Sign Out Error: \(error.localizedDescription)")
        }
    }
    
    func signIn() async {
        do {
            _ = try await Auth.auth().signIn(withEmail: myUser.email,password: myUser.password)
            DispatchQueue.main.async {
                self.falseCredentials = false
            }
        } catch {
            DispatchQueue.main.async {
                self.falseCredentials = true
            }
        }
    }
    
    func signUp() async {
        do {
            let _ = try await Auth.auth().createUser(withEmail: myUser.email, password: myUser.password)
            self.falseCredentials = false
        } catch {
            print("Sign Up Error: \(error.localizedDescription)")
            self.falseCredentials = true
        }
    }
}
