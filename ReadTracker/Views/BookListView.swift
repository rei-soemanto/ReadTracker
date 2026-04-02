//
//  BookListView.swift
//  ReadTracker
//
//  Created by Rei Soemanto on 20/02/26.
//

import SwiftUI

struct BookListView: View {
    @State var searchBook = ""
    @State var isAddBook = false
    
    @EnvironmentObject var bookViewModel: BookViewModel
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(alignment:.leading){
                    ForEach(bookViewModel.books){ book in
                        BookCardView(book: book)
                    }
                }
            }
            
            .searchable(text: $searchBook, placement: .navigationBarDrawer(displayMode: .always))
            .navigationDestination(isPresented: $isAddBook, destination: {AddNewBookView( isAddBook: $isAddBook )})
            .navigationTitle("Book List").navigationBarTitleDisplayMode(.inline)
            .toolbar{
                Button(action: {isAddBook = true}) {
                    Text("Add Book")
                }
            }
        }
    }
}

#Preview {
    BookListView()
        .environmentObject(BookViewModel())
}
