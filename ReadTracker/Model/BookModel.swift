//
//  BookModel.swift
//  MADCourse2025
//
//  Created by Theresia Saputri on 06/02/25.
//

import Foundation

struct Book: Identifiable {
    let id = UUID()
    let title: String
    let author: String
    let image: String
}
