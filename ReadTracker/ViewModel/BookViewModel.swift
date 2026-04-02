//
//  BookViewModel.swift
//  MADCourse2025
//
//  Created by Theresia Saputri on 06/02/25.
//

import Foundation

init() {
    dailyReads.append(
        DailyRead(
            book: Book(
                title: "Harry Potter 1",
                author: "J. K. Rowling",
                image: "harry-potter",
                genre: "Fantasy"
            ),
            readDate: Date(),
            readTimeInSeconds: 10,
            note: "This is such a great book"
        )
    )
    dailyReads.append(
        DailyRead(
            book: Book(
                title: "Harry Potter 2",
                author: "J. K. Rowling",
                image: "harry-potter",
                genre: "Fantasy"
            ),
            readDate: Calendar.current.date(from: DateComponents(year: 25, month: 3, day: 5)) ?? .now,
            readTimeInSeconds: 2000,
            note: "This is such a great book again"
        )
    )
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
    // [1, 2, 3, 4, 5] -> filter bilangan prima -> [1, 3, 5]
    let readsToday = dailyReads.filter {
        Calendar.current.isDate($0.readDate, inSameDayAs: date)
    }
    // [1, 1, 3, 5, 7, 3, 2] = 22
    let result = readsToday.reduce(0) {
        $0 + $1.readTimeInSeconds
    }
    return Int(getMinutes(seconds: result)) ?? 0
}

func getWholeWeekReadStats(byDate date: Date) -> [Int] {
    let calendar = Calendar.current
    
    let startOfWeek = calendar.dateInterval(of: .weekOfYear, for: date)?.start ?? date
    
    // [a, nil/null, c] -> map setiap elemen ditambah huruf z -> ["az", nil, "cz"]
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
