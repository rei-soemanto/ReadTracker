//
//  DailyIndicatorItem.swift
//  ReadTracker
//
//  Created by Rei Soemanto on 27/02/26.
//

import SwiftUI

struct DailyIndicatorItem: View {
    @State var dayIndicator: Int
    
    var body: some View {
        ZStack {
            if dayIndicator == 0 {
                Circle()
                    .stroke(.gray, lineWidth: 3)
                    .frame(width: 28, height: 28)
            } else if dayIndicator == 1 {
                Circle()
                    .stroke(.blue, lineWidth: 3)
                    .frame(width: 28, height: 28)
            } else if dayIndicator == 2 {
                Circle()
                    .stroke(.blue, lineWidth: 3)
                    .frame(width: 28, height: 28)
                Image(systemName: "checkmark")
            } else if dayIndicator == 3 {
                Circle()
                    .stroke(.red, lineWidth: 3)
                    .frame(width: 28, height: 28)
                Image(systemName: "checkmark")
            } else if dayIndicator == 4 {
                Circle()
                    .stroke(.yellow, lineWidth: 3)
                    .frame(width: 28, height: 28)
                Image(systemName: "checkmark")
            } else {
                Circle()
                    .stroke(.green, lineWidth: 3)
                    .frame(width: 28, height: 28)
                Image(systemName: "checkmark")
            }
        }
    }
}

#Preview {
    DailyIndicatorItem(dayIndicator: 3)
}
