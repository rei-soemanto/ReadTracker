//
//  DetailedReadCardView.swift
//  ReadTracker
//
//  Created by Rei Soemanto on 27/02/26.
//

import SwiftUI

struct DetailedReadCardView: View {
    var body: some View {
        ZStack{
            Rectangle()
                .fill(Color(red:0.973, green: 0.973, blue: 0.973))
                .frame(height: 370)
            
            VStack {
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
                
                HStack {
                    Text("Duration : ")
                        .padding(.leading, 22)
                    Text("00 Hours 24 Mins 10 Sec")
                    Spacer()
                }.padding(.bottom, 15)
                
                ZStack {
                    Rectangle()
                        .fill(Color(hue: 1.0, saturation: 0.015, brightness: 0.894))
                        .frame(width: 317, height: 70)
                    Text("So good, I hope I have more time to read the book")
                }.padding()
            }
        }.padding([.leading, .top, .trailing], 10)
    }
}

#Preview {
    DetailedReadCardView()
}
