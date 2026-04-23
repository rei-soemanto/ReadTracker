//
//  StartReadView.swift
//  ReadTracker
//
//  Created by Rei Soemanto on 27/02/26.
//

import SwiftUI

struct StartReadView: View {
    @EnvironmentObject var dailyReadViewModel: DailyReadViewModel
    
    @State var isReading = false
    @State var isPausing = false
    @State var timeInSeconds = 0
    @State var noteInputPresented: Bool = false
    @State var noteInput: String = ""
    
    @Binding var isReadyToRead: Bool
    @Binding var book: Book?
    
    @State var timer = Timer.publish(every: 1, on: .main, in: .common)
    
    var playpauseButton: String {
        if isPausing {
            return "play.fill"
        } else {
            return "pause.fill"
        }
    }
    
    var body: some View {
        VStack {
            BookCardView(book: book!)
            
            Text("⏱️ Time a Reading Sessions").font(.body)
            Text("\(dailyReadViewModel.getHours(seconds: timeInSeconds)):\(dailyReadViewModel.getMinutes(seconds: timeInSeconds)):\(dailyReadViewModel.getSeconds(seconds: timeInSeconds))").font(.system(size: 65,)).fontWeight(.semibold)
            
            if isReading {
                HStack {
                    Button(action: {
                        isPausing.toggle()
                        if (isPausing) {
                            timer = Timer.publish(every: 1, on:.main, in: .common)
                        } else {
                            timer.connect()
                        }
                    }) {
                        Image(systemName: playpauseButton)
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                    
                    Button(action: {
                        timeInSeconds = 0
                        isReading = false
                        isPausing = false
                    }) {
                        Image(systemName: "stop.fill")
                            .resizable()
                            .frame(width: 30, height: 30)
                    }
                }
            } else {
                Button(action: {
                    timer.connect()
                    isReading.toggle()
                }) {
                    Image(systemName: "play.fill")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
            
            Button("Manage Notes") {
                noteInputPresented = true
            }
            .padding(.vertical)
            .buttonStyle(.borderedProminent)
            
            HStack {
                Button("Cancel") {
                    isReadyToRead = false
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                
                Button("Save") {
                    let newDailyRead = DailyRead(book: book!, readDate: Date(), readTimeInSeconds: timeInSeconds, note: noteInput)
                    
                    dailyReadViewModel.addDailyRead(dailyRead: newDailyRead)
                    
                    isReading = false
                    isPausing = false
                    timeInSeconds = 0
                    noteInputPresented = false
                    noteInput = ""
                    timer = Timer.publish(every: 1, on: .main, in: .common)
                    isReadyToRead = false
                }
                .buttonStyle(.borderedProminent)
                .tint(.gray)
            }
        }
        .onReceive(timer, perform: {_ in
            timeInSeconds += 1
        })
        .fullScreenCover(isPresented: $noteInputPresented, content: {
            ReadNoteInputView(note: $noteInput, noteInputPresented: $noteInputPresented)
        })
    }
}

#Preview {
    StartReadView(isReadyToRead: .constant(true), book: .constant(Book(title: "Test Book", author: "Test Author", image: "harryPotter", genre: "Fantasy")))
        .environmentObject(DailyReadViewModel())
}
