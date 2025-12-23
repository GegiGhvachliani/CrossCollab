//
//  BrowseView.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import SwiftUI

struct BrowseView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Browse Screen")
                    .font(.largeTitle)
                    .bold()
                
                Text("Search and filter events here")
                    .foregroundColor(.gray)
            }
            .navigationTitle("Browse Events")
        }
    }
}

#Preview {
    BrowseView()
}
