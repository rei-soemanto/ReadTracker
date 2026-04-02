//
//  DetailedReadCardView.swift
//  ReadTracker
//
//  Created by Rei Soemanto on 27/02/26.
//

import SwiftUI

struct DetailedReadCardView: View {
    let dailyRead: DailyRead
    
    @EnvironmentObject var dailyReadViewModel: DailyReadViewModel
    
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
                            Text(dailyRead.book.title)
                            Spacer()
                        }
                        HStack{
                            Text("Author  : ")
                            Text(dailyRead.book.author)
                            Spacer()
                        }
                        HStack{
                            Text("Genre   : ")
                            Text(dailyRead.book.genre)
                            Spacer()
                        }
                    }.padding()
                    
                    Image(dailyRead.book.image)
                        .resizable()
                        .frame(width: 100, height: 160)
                        .padding(.trailing, 30)
                }
                
                HStack {
                    Text("Duration : ")
                        .padding(.leading, 22)
                    Text("\(dailyReadViewModel.getHours(seconds: dailyRead.readTimeInSeconds)) Hours \(dailyReadViewModel.getMinutes(seconds: dailyRead.readTimeInSeconds)) Mins \(dailyReadViewModel.getSeconds(seconds: dailyRead.readTimeInSeconds)) Sec")
                    Spacer()
                }.padding(.bottom, 15)
                
                ZStack {
                    Rectangle()
                        .fill(Color(hue: 1.0, saturation: 0.015, brightness: 0.894))
                        .frame(width: 317, height: 70)
                    Text(dailyRead.note ?? "No Note")
                }.padding()
            }
        }.padding([.leading, .top, .trailing], 10)
    }
}

#Preview {
    DetailedReadCardView(dailyRead: DailyRead(book: Book(title: "Test", author: "Test", image: "harryPotter", genre: "Test"), readDate: Date(), readTimeInSeconds: 300, note: "Test"))
        .environmentObject(DailyReadViewModel())
}
