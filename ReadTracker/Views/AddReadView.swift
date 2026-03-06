//
//  AddReadView.swift
//  ReadTracker
//
//  Created by Rei Soemanto on 27/02/26.
//

import SwiftUI

struct AddReadView: View {
    @State var searchText: String = ""
    @State var showSuggestions = true
    @State var isResultEmpty = false
    @State var isReadyToRead = false
    
    var body: some View {
        VStack(spacing: 10) {
            TextField("Search for a book", text: $searchText, onEditingChanged: { isEditing in
                showSuggestions = !searchText.isEmpty
            })
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding([.leading, .bottom, .trailing])
            
            HStack {
                Text("Book info").font(.title).fontWeight(.bold)
                Spacer()
            }.padding(.horizontal)
            
            if searchText.isEmpty || isResultEmpty {
                ZStack {
                    Rectangle()
                        .fill(Color(red: 0.973, green: 0.973, blue: 0.973))
                        .frame(width: 360, height: 222)
                    
                    Text("No book information").font(.body)
                }
            } else if showSuggestions {
                ScrollView {
                    VStack {
                        Button(action: {
                            isReadyToRead = true
                            showSuggestions = false
                        }) {
                            BookCardView()
                        }
                    }
                }
            }
            
            if isReadyToRead {
                StartReadView()
            } 
            
            Spacer()
        }
    }
}

#Preview {
    AddReadView()
}
