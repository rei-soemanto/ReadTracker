//
//  ReadNoteInputView.swift
//  ReadTracker
//
//  Created by Rei Soemanto on 02/04/26.
//

import SwiftUI

struct ReadNoteInputView: View {
    @Binding var note: String
    @Binding var noteInputPresented: Bool
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Text("Note")
                TextField("note", text: $note)
            }
            
            HStack {
                Button("Done") {
                    noteInputPresented = false
                }
                .buttonStyle(.borderedProminent)
            }.padding(.bottom, 40).padding(.top, 20)
            
            Spacer()
        }
        .padding(.horizontal, 15)
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity,
            alignment: .topLeading
        )
        .background(Color.white)
        .clipShape(
            .rect(
                topLeadingRadius: 60,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 0,
                topTrailingRadius: 60
            )
        )
        .shadow(radius: 20, y: 10)
        .mask(Rectangle().padding(.top, -40))
    }
}

#Preview {
    ReadNoteInputView(note: .constant(""), noteInputPresented: .constant(true))
}
