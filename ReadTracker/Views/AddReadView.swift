//
//  AddReadView.swift
//  ReadTracker
//
//  Created by Rei Soemanto on 27/02/26.
//

import SwiftUI

struct AddReadView: View {
    @EnvironmentObject var bookViewModel: BookViewModel
    
    @State var searchText: String = ""
    @State var showSuggestions = true
    @State var isResultEmpty = false
    @State var isReadyToRead = false
    @State var filteredBooks: [Book] = []
    @State var selectedBook: Book? = nil
    
    var body: some View {
        VStack(spacing: 10) {
            TextField(
                "Search for a book",
                text: $searchText
            )
            .onChange(of: searchText, {
                filteredBooks = bookViewModel.filterBooks(byTitle: searchText)
                print(filteredBooks)
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding([.leading, .bottom, .trailing])
            
            HStack {
                Text("Book info").font(.title).fontWeight(.bold)
                Spacer()
            }.padding(.horizontal)
            
            ScrollView {
                VStack {
                    ForEach(searchText.isEmpty ? bookViewModel.books : filteredBooks, id: \.self) { book in
                        
                        Button {
                            selectedBook = book
                            filteredBooks = []
                            isReadyToRead = true
                        } label: {
                            BookCardView(book: book)
                        }
                    }
                }
            }
            
            Spacer()
        }
        .fullScreenCover(isPresented: $isReadyToRead, content: {
            StartReadView(isReadyToRead: $isReadyToRead, book: $selectedBook)
        })
    }
}

#Preview {
    AddReadView()
        .environmentObject(BookViewModel())
        .environmentObject(DailyReadViewModel())
}
