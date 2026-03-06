//
//  StartReadView.swift
//  ReadTracker
//
//  Created by Rei Soemanto on 27/02/26.
//

import SwiftUI

struct StartReadView: View {
    @State var isReading = false
    @State var isPausing = false
    
    var playpauseButton: String {
        if isPausing {
            return "playpause.fill"
        } else {
            return "pause.fill"
        }
    }
    
    var body: some View {
        VStack {
            BookCardView()
            
            Text("⏱️ Time a Reading Sessions").font(.body)
            Text("00:00:00").font(.system(size: 65,)).fontWeight(.semibold)
            
            if isReading {
                HStack {
                    Button(action: {isPausing.toggle()}) {
                        Image(systemName: playpauseButton)
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    
                    Button(action: {
                        isReading = false
                        isPausing = false
                    }) {
                        Image(systemName: "stop.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }
            } else {
                Button(action: {isReading.toggle()}) {
                    Image(systemName: "play.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
            
            Button("Manage Notes") {}
                .buttonStyle(.borderedProminent)
                .padding(15)
            
            HStack {
                Button("Cancel") {}
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                
                Button("Save") {}
                    .buttonStyle(.borderedProminent)
                    .tint(.gray)
            }
        }
    }
}

#Preview {
    StartReadView()
}
