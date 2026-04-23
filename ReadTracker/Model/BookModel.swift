//
//  DailyReadModel.swift
//  ReadTracker
//
//  Created by Rei Soemanto on 02/04/26.
//

import Foundation

struct Book: Identifiable, Hashable, Codable {
    let id = UUID()
    var title: String
    var author: String
    var image: String
    var genre: String
}
