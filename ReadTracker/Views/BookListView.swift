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
    
    var body: some View {
        NavigationStack{
            ScrollView {
                VStack(alignment:.leading){
                    ForEach(0..<10){_ in
                        BookCardView()
                    }
                }
            }
            
            .searchable(text: $searchBook, placement: .navigationBarDrawer(displayMode: .always))
            .navigationDestination(isPresented: $isAddBook, destination: {AddNewBookView()})
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
}
