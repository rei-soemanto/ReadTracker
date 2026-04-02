//
//  AddNewBookView.swift
//  ReadTracker
//
//  Created by Rei Soemanto on 20/02/26.
//

import SwiftUI

struct AddNewBookView: View {
    @ObservedObject var iOSConnectivityManager: iOSConnectivity
    
    @State var title = ""
    @State var author = ""
    @State var genre = ""
    
    @Binding var isPresented: Bool
    
    let genres = ["Fantasy", "Romance", "Thriller", "Science Fiction"]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            ScrollView {
                TextField("Book Title", text: $title)
                TextField("Book Author", text: $author)
                
                Picker("Genre", selection: $genre) {
                    ForEach(genres, id: \.self) {
                        Text($0)
                    }
                }
                .pickerStyle(.navigationLink)
                .padding(.vertical, 5)
                
                HStack {
                    Button {
                        isPresented = false
                    } label: {
                        Text("Cancel")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.red)
                    
                    Button {
                        dismiss()
                        
                        iOSConnectivityManager.sendToiOS(data: Book(title: title, author: author, image:"harryPotter", genre: genre))
                    } label: {
                        Text("Save")
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.blue)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        AddNewBookView(iOSConnectivityManager: iOSConnectivity(), isPresented: .constant(true))
    }
}
