//
//  DailyReadModel.swift
//  ReadTracker
//
//  Created by Rei Soemanto on 02/04/26.
//

import SwiftUI
import Foundation
import Combine
import FirebaseDatabase
import WatchConnectivity

class BookViewModel: NSObject, ObservableObject, WCSessionDelegate {
    @Published var books = [Book]()
    var session: WCSession
    
    private var ref: DatabaseReference
    
    init(session: WCSession = .default) {
        self.session = session
        
        self.ref = Database.database().reference().child("books")
        
        super.init()
        session.delegate = self
        session.activate()
        
        books = [
            Book(title: "Harry Potter 1", author: "J.K. Rowling", image: "harryPotter", genre: "Fantasy"),
            Book(title: "Harry Potter 2", author: "J.K. Rowling", image: "harryPotter", genre: "Fantasy"),
            Book(title: "Harry Potter 3", author: "J.K. Rowling", image: "harryPotter", genre: "Fantasy")
        ]
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        DispatchQueue.main.async {
            print("Recieved message: \(message)")
            
            self.books.append(Book(title: message["title"] as! String, author: message["author"] as! String, image: message["image"] as! String, genre: message["genre"] as! String))
        }
    }
    
    func addNewBook(title: String, author: String, image: String, genre: String) {
        books.append(Book(title: title, author: author, image: image, genre: genre))
    }
    
    func filterBooks(byTitle title: String) -> [Book] {
        let filteredBooks = books.filter { $0.title.lowercased().contains(title.lowercased()) }
        print(filteredBooks)
        
        return filteredBooks
    }
    
    func fetchBooks() {
        ref.observe(.value) { snapshot in
            guard let value = snapshot.value as? [String: Any] else {
                self.books = []
                return
            }
            
            self.books = value.compactMap { (key, bookData) in
                guard let bookDict = bookData as? [String: Any],
                      let jsonData = try? JSONSerialization.data(withJSONObject: bookDict)
                else {
                    return nil
                }
                return try? JSONDecoder().decode(Book.self, from: jsonData)
            }
        }
    }
    
    func addBook(book: Book) {
        guard let jsonData = try? JSONEncoder().encode(book),
            let json = try? JSONSerialization.jsonObject(with: jsonData)
                as? [String: Any]
        else {
            return
        }
        ref.child(book.id.uuidString).setValue(json)
    }
    
    func updateBook(book: Book) {
        guard let jsonData = try? JSONEncoder().encode(book),
            let json = try? JSONSerialization.jsonObject(with: jsonData)
                as? [String: Any]
        else {
            return
        }
        ref.child(book.id.uuidString).setValue(json)
    }
    
    func deleteBook(book: Book) {
        ref.child(book.id.uuidString).removeValue()
    }
}
