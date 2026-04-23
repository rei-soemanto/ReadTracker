//
//  AddNewBookView.swift
//  ReadTracker
//
//  Created by Rei Soemanto on 20/02/26.
//

import SwiftUI

struct AddNewBookView: View {
    @EnvironmentObject private var bookViewModel: BookViewModel
    
    @State var title = ""
    @State var author = ""
    @State var genre = ""
    @State var saveButtonDisabled: Bool = true
    
    @Binding var isAddBook: Bool
    
    let genres = ["Fantasy", "Romance", "Thriller", "Science Fiction"]
    
    var body: some View {
        VStack{
            
            HStack{
                Text("Title       : ")
                    .padding()
                TextField("The Book Title", text: $title)
                    .onChange(of: title, {
                        if !title.isEmpty && !author.isEmpty && !genre.isEmpty {
                            saveButtonDisabled = false
                        } else {
                            saveButtonDisabled = true
                        }
                    })
                    .padding()
                Spacer()
            }
            
            HStack{
                Text("Author   : ")
                    .padding()
                TextField("Enter the author's name", text: $author)
                    .onChange(of: author, {
                        if !title.isEmpty && !author.isEmpty && !genre.isEmpty {
                            saveButtonDisabled = false
                        } else {
                            saveButtonDisabled = true
                        }
                    })
                    .padding()
                Spacer()
            }
            
            HStack{
                Text("Genre    : ")
                    .padding()
                Picker("Genre", selection: $genre) {
                    ForEach(genres, id: \.self) {
                        Text($0)
                    }
                    .onChange(of: genre, {
                        if !title.isEmpty && !author.isEmpty && !genre.isEmpty {
                            saveButtonDisabled = false
                        } else {
                            saveButtonDisabled = true
                        }
                    })
                    .padding()
                }
                .pickerStyle(.menu)
                Spacer()
            }
            
            ZStack{
                Rectangle()
                    .fill(Color(red: 0.94, green: 0.925, blue: 0.925))
                    .frame(width: 239, height: 239)
                Image(systemName: "plus.circle.fill")
                    .imageScale(.large)
            }.padding()
            
            HStack{
                Button("Cancel"){
                    isAddBook = false
                }
                .tint(.red)
                .buttonStyle(.borderedProminent)
                
                Button("Save"){
                    let newBook = Book(
                        title: title, author: author, image: "harry-potter", genre: genre
                    )
                    
                    bookViewModel.addBook(book: newBook)
                    
                    title = ""
                    author = ""
                    genre = "Fantasy"
                    isAddBook = false
                }
                .buttonStyle(.borderedProminent)
                .disabled(saveButtonDisabled)
            }.padding(.top, 50.0)
            
            Spacer()
        }
        .navigationTitle(Text("Add New Book"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AddNewBookView(isAddBook: .constant(true))
            .environmentObject(BookViewModel())
    }
}
