//
//  SplashScreen.swift
//  ReadTracker
//
//  Created by Rei Soemanto on 10/04/26.
//

import SwiftUI

struct SplashScreen: View {
    @State private var isActive = false
    
    @State private var iconOffset: CGFloat = 50
    @State private var iconOpacity: Double = 0
    @State private var circleScale: CGFloat = 0.01
    @State private var textOpacity: Double = 0
    
    var body: some View {
        ZStack {
            if isActive {
                MainView()
                    .environmentObject(BookViewModel())
                    .environmentObject(DailyReadViewModel())
                
                    .transition(.asymmetric(insertion: .scale(scale: 0.9).combined(with: .opacity), removal: .opacity))
            } else {
                ZStack {
                    Color ("PaperColor")
                        .ignoresSafeArea()
                    
                    VStack(spacing: 20) {
                        ZStack {
                            Circle()
                                .fill(Color.orange.opacity(0.2))
                                .frame(width: 200, height: 200)
                                .scaleEffect(circleScale)
                            
                            Image(systemName: "book.closed.fill")
                                .font(.system(size: 80))
                                .foregroundColor(Color("SecondaryColor"))
                                .offset(y: iconOffset)
                                .opacity(iconOpacity)
                        }
                        
                        VStack(spacing: 8) {
                            Text("Book App")
                                .font(.custom("Georgia-Bold", size: 36))
                                .foregroundColor(Color("SecondaryColor"))
                            
                            Text("Your story begins here")
                                .font(.custom("Georgia-Italic", size: 16))
                                .foregroundColor(.gray)
                        }
                        .opacity(textOpacity)
                    }
                }
                .transition(.opacity.combined(with: .scale(scale: 1.2)))
            }
        }
        .onAppear {
            animateSequence()
        }
    }
    
    private func animateSequence() {
        withAnimation(.spring(response: 0.75, dampingFraction: 0.6).delay(0.2)) {
            circleScale = 1.0
        }
        
        withAnimation(.easeOut(duration: 1.0).delay(0.5)) {
            iconOffset = 0
            iconOpacity = 1.0
        }
        
        withAnimation(.easeIn(duration: 0.8).delay(1.2)) {
            textOpacity = 1.0
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            withAnimation(.easeInOut(duration: 0.8)) {
                isActive = true
            }
        }
    }
}

#Preview {
    SplashScreen()
}
