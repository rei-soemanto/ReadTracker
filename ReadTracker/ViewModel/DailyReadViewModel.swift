//
//  DailyReadViewModel.swift
//  ReadTracker
//
//  Created by Rei Soemanto on 02/04/26.
//

import SwiftUI
import Foundation
import Combine
import FirebaseDatabase

class DailyReadViewModel: ObservableObject {
    
    @Published var dailyReads: [DailyRead] = []
    
    private var ref: DatabaseReference

    init() {
        self.ref = Database.database().reference().child("daily_read")
        
        fetchDailyRead()
        
//        dailyReads.append(
//            DailyRead(
//                book: Book(
//                    title: "Harry Potter 1",
//                    author: "J. K. Rowling",
//                    image: "harry-potter",
//                    genre: "Fantasy"
//                ),
//                readDate: Date(),
//                readTimeInSeconds: 10,
//                note: "This is such a great book"
//            )
//        )
//        dailyReads.append(
//            DailyRead(
//                book: Book(
//                    title: "Harry Potter 2",
//                    author: "J. K. Rowling",
//                    image: "harry-potter",
//                    genre: "Fantasy"
//                ),
//                readDate: Calendar.current.date(from: DateComponents(year: 25, month: 3, day: 5)) ?? .now,
//                readTimeInSeconds: 2000,
//                note: "This is such a great book again"
//            )
//        )
    }

    func addNewDailyRead(dailyRead: DailyRead) {
        dailyReads.append(dailyRead)
    }

    func getHours(seconds: Int) -> String {
        let hours = Int(seconds / 3600)
        return hours > 9 ? String(hours) : "0\(hours)"
    }

    func getMinutes(seconds: Int) -> String {
        let minutes = Int((seconds % 3600) / 60)
        return minutes > 9 ? String(minutes) : "0\(minutes)"
    }

    func getSeconds(seconds: Int) -> String {
        let seconds = Int((seconds % 3600) % 60)
        return seconds > 9 ? String(seconds) : "0\(seconds)"
    }

    func getTotalMinutesOnCurrentDate(currentDate date: Date) -> Int {
        let readsToday = dailyReads.filter {
            Calendar.current.isDate($0.readDate, inSameDayAs: date)
        }
        
        print("reads today: \(readsToday)")
        
        let result = readsToday.reduce(0) {
            $0 + $1.readTimeInSeconds
        }
        
        print("total read's time today: \(result)")
        
        return result / 60
    }

    func getWholeWeekReadStats(byDate date: Date) -> [Int] {
        let calendar = Calendar.current
        
        let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: date)?.start ?? date
        
        let daysOfWeek = (0..<7).compactMap {
            calendar.date(byAdding: .day, value: $0, to: startOfWeek)
        }
        
        return daysOfWeek.map {
            if $0 > Date.now {
                return 0
            } else {
                let totalMinutesOnCurrentDate = getTotalMinutesOnCurrentDate(currentDate: $0)
                
                if totalMinutesOnCurrentDate == 0 {
                    return Calendar.current.isDateInToday($0) ? 1 : 3
                } else if totalMinutesOnCurrentDate >= 30 {
                    return Calendar.current.isDateInToday($0) ? 2 : 4
                } else {
                    return Calendar.current.isDateInToday($0) ? 2 : 5
                }
            }
        }
    }
    
    func fetchDailyRead() {
        ref.observe(.value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                self.dailyReads = []
                return
            }
            
            self.dailyReads = value.compactMap { (key, dailyReadData) in
                guard let dailyReadDict = dailyReadData as? [String: Any],
                      let jsonData = try? JSONSerialization.data(withJSONObject: dailyReadDict)
                else {
                    return nil
                }
                return try? JSONDecoder().decode(DailyRead.self, from: jsonData)
            }
        }
    }
    
    func addDailyRead(dailyRead: DailyRead) {
        guard let jsonData = try? JSONEncoder().encode(dailyRead),
            let json = try? JSONSerialization.jsonObject(with: jsonData)
                as? [String: Any]
        else {
            return
        }
        ref.child(dailyRead.id.uuidString).setValue(json)
    }
    
    func updateDailyRead(dailyRead: DailyRead) {
        guard let jsonData = try? JSONEncoder().encode(dailyRead),
            let json = try? JSONSerialization.jsonObject(with: jsonData)
                as? [String: Any]
        else {
            return
        }
        ref.child(dailyRead.id.uuidString).setValue(json)
    }
    
    func deleteDailyRead(dailyRead: DailyRead) {
        ref.child(dailyRead.id.uuidString).removeValue()
    }
}
