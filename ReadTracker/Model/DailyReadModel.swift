//
//  DailyReadModel.swift
//  ReadTracker
//
//  Created by Rei Soemanto on 02/04/26.
//

import Foundation

struct DailyRead: Hashable, Identifiable {
    let id = UUID()
    var book: Book
    var readDate: Date
    var readTimeInSeconds: Int
    var note: String
}
