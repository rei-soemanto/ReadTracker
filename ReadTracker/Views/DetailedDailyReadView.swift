//
//  DetailedDailyReadView.swift
//  ReadTracker
//
//  Created by Rei Soemanto on 27/02/26.
//

import SwiftUI

struct DetailedDailyReadView: View {
    var body: some View {
        ScrollView {
            DetailedReadCardView()
            DetailedReadCardView()
            DetailedReadCardView()
        }
    }
}

#Preview {
    DetailedDailyReadView()
}
