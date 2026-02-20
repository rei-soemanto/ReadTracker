//
//  AddNewBookView.swift
//  ReadTracker
//
//  Created by Rei Soemanto on 20/02/26.
//

import SwiftUI

struct AddNewBookView: View {
    @State var title = ""
    @State var author = ""
    @State var genre = ""
    
    let genres = ["Fantasy", "Romance", "Thriller", "Science Fiction"]
    @State var selectedGenre = "Fantasy"
    
    var body: some View {
        VStack{
            
            HStack{
                Text("Title       : ")
                    .padding()
                TextField("The Book Title", text: $title)
                    .padding()
                Spacer()
            }
            
            HStack{
                Text("Author   : ")
                    .padding()
                TextField("Enter the author's name", text: $author)
                    .padding()
                Spacer()
            }
            
            HStack{
                Text("Genre    : ")
                    .padding()
                Picker("Genre", selection: $selectedGenre) {
                    ForEach(genres, id: \.self) {genre in
                        Text(genre)
                    }
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
                    
                }
                .tint(.red)
                .buttonStyle(.borderedProminent)
                
                Button("Save"){
                    
                }
                .buttonStyle(.borderedProminent)
            }.padding(.top, 50.0)
            
            Spacer()
        }
        .navigationTitle(Text("Add New Book"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AddNewBookView()
    }
}
