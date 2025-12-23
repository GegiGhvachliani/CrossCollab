//
//  UpdatesView.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import SwiftUI

struct UpdatesView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Updates Screen")
                    .font(.largeTitle)
                    .bold()
                
                Text("Notifications will be here")
                    .foregroundColor(.gray)
            }
            .navigationTitle("Updates")
        }
    }
}

#Preview {
    UpdatesView()
}
