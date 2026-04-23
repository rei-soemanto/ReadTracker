//
//  LoginRegisterSheet.swift
//  ReadTracker
//
//  Created by Rei Soemanto on 23/04/26.
//

import SwiftUI

struct LoginRegisterSheet: View {
    @Binding var showAuthSheet: Bool
    @EnvironmentObject var authVM: AuthViewModel
    @State var registerClicked: Bool = false
    
    var body: some View {
        if registerClicked {
            VStack {
                Text("Login")
                    .font(.title)
                
                TextField("Email", text: $authVM.myUser.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $authVM.myUser.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                if authVM.falseCredentials {
                    Text("Invalid Username and Password")
                        .fontWeight(.medium)
                        .foregroundColor(Color.red)
                }
                
                Button(
                    action: {
                        Task {
                            await authVM.signIn()
                            if !authVM.falseCredentials {
                                authVM.checkUserSession()
                                showAuthSheet = !authVM.isSignedIn
                                authVM.myUser = MyUser()
                            }
                        }
                    }
                ) {
                    Text("Login").frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .buttonStyle(.borderedProminent)
                
                Spacer()
                
                Button(
                    action: {
                        registerClicked = false
                    }
                ) {
                    Text("Register").font(.system(size: 18)).fontWeight(.medium)
                }
            }
            .interactiveDismissDisabled(true)
        } else {
            VStack {
                Text("Register")
                    .font(.title)
                
                TextField("Name", text: $authVM.myUser.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Email", text: $authVM.myUser.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $authVM.myUser.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                if authVM.falseCredentials {
                    Text("Invalid Username and Password")
                        .fontWeight(.medium)
                        .foregroundColor(Color.red)
                }
                
                Button(
                    action: {
                        Task {
                            await authVM.signUp()
                            if !authVM.falseCredentials {
                                authVM.checkUserSession()
                                showAuthSheet = !authVM.isSignedIn
                                authVM.myUser = MyUser()
                            }
                        }
                    }
                ) {
                    Text("Register").frame(maxWidth: .infinity)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .buttonStyle(.borderedProminent)
                
                Spacer()
                
                Button(
                    action: {
                        registerClicked = true
                    }
                ) {
                    Text("Login").font(.system(size: 18)).fontWeight(.medium)
                }
            }
            .interactiveDismissDisabled(true)
        }
    }
}

#Preview {
    LoginRegisterSheet(showAuthSheet: .constant(true)).environmentObject(AuthViewModel())
}
