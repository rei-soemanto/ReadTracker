//
//  DetailedDailyReadView.swift
//  ReadTracker
//
//  Created by Rei Soemanto on 27/02/26.
//

import SwiftUI

struct DetailedDailyReadView: View {
    @EnvironmentObject var dailyReadViewModel: DailyReadViewModel
    
    var body: some View {
        ScrollView {
            ForEach(dailyReadViewModel.dailyReads, id: \.self) { dailyRead in
                DetailedReadCardView(dailyRead: dailyRead)
            }
        }
    }
}

#Preview {
    DetailedDailyReadView()
        .environmentObject(DailyReadViewModel())
}
