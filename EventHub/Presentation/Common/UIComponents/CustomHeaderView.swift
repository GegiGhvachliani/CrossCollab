//
//  CustomHeaderView.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import SwiftUI

struct CustomHeaderView: View {
    var title: String
    var subTitle: String
    
    var body: some View {
        VStack(spacing: 10) {
            Text(title)
                .font(Font.system(size: 30))
            
            Text(subTitle)
                .multilineTextAlignment(.center)
                .font(Font.system(size: 17))
                .foregroundStyle(.secondary)
                .minimumScaleFactor(0.7)
                .lineLimit(2)
                .padding(.horizontal, 30)
        }
    }
}
