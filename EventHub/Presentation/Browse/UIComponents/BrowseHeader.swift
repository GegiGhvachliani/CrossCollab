//
//  BrowseHeader.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 23.12.25.
//

import SwiftUI


struct BrowseHeader: View {
    var body: some View {
        HStack {
            Text("Browse Events")
//                .font(.largeTitle)
                .navigationBarTitleDisplayMode(.inline)
                .bold()
            
            Spacer()
            
            Image(systemName: "calendar")
                .font(.title2)
        }
        .padding()
    }
}
