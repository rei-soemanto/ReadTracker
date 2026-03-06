//
//  DailyReadView.swift
//  ReadTracker
//
//  Created by Rei Soemanto on 27/02/26.
//

import SwiftUI

struct DailyReadView: View {
    @State var dailyGoal = 5.0
    @State var isAddActivity = false
    @State private var selectedDate = Date()
    @State private var showDatePicker = false
    
    var dayName: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE"
        return formatter.string(from: selectedDate)
    }
    
    var dateOnly: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: selectedDate)
    }
    
    var dateIndicator: String {
        let calendar = Calendar.current
        if calendar.isDateInToday(selectedDate) {
            return "Today"
        } else {
            return "Past"
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    selectDateButton
                    Spacer()
                    VStack{
                        Text("\(dateIndicator)").font(.system(size: 32)).fontWeight(.bold)
                        Text("\(dayName), \(dateOnly)").font(.system(size: 20))
                    }
                    Spacer()
                    NavigationLink(destination: DetailedDailyReadView()){viewDetailButton}
                }.padding()
                
                dayNameLabel
                
                HStack {
                    Spacer()
                    DailyIndicatorItem(dayIndicator: 5)
                    Spacer()
                    DailyIndicatorItem(dayIndicator: 4)
                    Spacer()
                    DailyIndicatorItem(dayIndicator: 4)
                    Spacer()
                    DailyIndicatorItem(dayIndicator: 3)
                    Spacer()
                    DailyIndicatorItem(dayIndicator: 2)
                    Spacer()
                    DailyIndicatorItem(dayIndicator: 0)
                    Spacer()
                    DailyIndicatorItem(dayIndicator: 0)
                    Spacer()
                }
                
                Spacer()
                
                ZStack {
                    let progress = Double(dailyGoal / 30)
                    
                    Circle()
                        .inset(by: 10)
                        .stroke(Color.gray, lineWidth: 30)
                        .opacity(0.2)
                    
                    Circle()
                        .inset(by: 10)
                        .trim(from: 0.0, to: progress)
                        .stroke(.blue, style: StrokeStyle(lineWidth: 30, lineCap: .round, lineJoin: .round))
                        .rotationEffect(Angle(degrees: 270.0))
                    
                    VStack {
                        Text("Daily Goal").font(.largeTitle).padding()
                        Text("\(Int(dailyGoal)) /30 mins").font(.title2).padding()
                    }
                }.frame(width: 340, height: 340)
                
                Spacer()
                
                Button("Add Reading Activity") {
                    isAddActivity = true
                }
                .buttonStyle(.borderedProminent)
                
                Spacer()
            }
            .navigationDestination(isPresented: $isAddActivity, destination: {AddReadView()})
            .navigationTitle(Text("Daily Read"))
            .navigationBarHidden(true)
        }
    }
}

extension DailyReadView {
    private var dayNameLabel: some View {
        HStack {
            Spacer()
            Text("S").font(.system(size: 26)); Spacer()
            Text("M").font(.system(size: 26)); Spacer()
            Text("T").font(.system(size: 26)); Spacer()
            Text("W").font(.system(size: 26)); Spacer()
            Text("T").font(.system(size: 26)); Spacer()
            Text("F").font(.system(size: 26)); Spacer()
            Text("S").font(.system(size: 26)); Spacer()
        }
    }
    
    private var selectDateButton: some View {
        ZStack {
            Button (action: {
                showDatePicker.toggle()
            }) {
                ZStack {
                    Rectangle()
                        .fill(Color(red: 0.974, green: 0.964, blue: 0.965))
                        .frame(width: 60, height: 60)
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 30, height: 30)
                }
            }
        }
        .sheet(isPresented: $showDatePicker) {
            VStack {
                DatePicker("Select Date", selection: $selectedDate, in: ...Date(), displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                
                Button("Done") {
                    showDatePicker = false
                }.padding()
            }
        }.padding()
    }
    
    private var viewDetailButton: some View {
        ZStack {
            ZStack {
                Rectangle()
                    .fill(Color(red: 0.974, green: 0.964, blue: 0.965))
                    .frame(width: 60, height: 60)
                Image(systemName: "doc.richtext")
                    .resizable()
                    .frame(width: 30, height: 30)
            }
        }.padding()
    }
}

#Preview {
    DailyReadView()
}
