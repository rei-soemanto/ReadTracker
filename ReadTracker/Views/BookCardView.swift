//
//  BookCardView.swift
//  ReadTracker
//
//  Created by Rei Soemanto on 20/02/26.
//

import SwiftUI

struct BookCardView: View {
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color(red:0.973, green: 0.973, blue: 0.973))
                .frame(height: 250)
            
            HStack{
                Spacer()
                
                VStack(spacing: 20){
                    HStack{
                        Text("Title      : ")
                        Text("Harry Potter and The Sorcerer's Stone")
                        Spacer()
                    }
                    HStack{
                        Text("Author  : ")
                        Text("J.K. Rowling")
                        Spacer()
                    }
                    HStack{
                        Text("Genre   : ")
                        Text("Fantasy")
                        Spacer()
                    }
                }.padding()
                
                Image(.harryPotter)
                    .resizable()
                    .frame(width: 100, height: 160)
                    .padding(.trailing, 30)
            }
        }.padding([.leading, .bottom, .trailing], 10)
    }
}

#Preview {
    BookCardView()
}
