//
//  MyEventsView.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import SwiftUI

struct MyEventsView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("My Events Screen")
                    .font(.largeTitle)
                    .bold()
                
                Text("Your registered events will be here")
                    .foregroundColor(.gray)
            }
            .navigationTitle("My Events")
        }
    }
}

#Preview {
    MyEventsView()
}
