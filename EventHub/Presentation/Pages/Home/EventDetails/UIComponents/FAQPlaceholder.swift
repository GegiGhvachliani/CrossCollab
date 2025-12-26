//
//  FAQPlaceholder.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 23.12.25.
//

import SwiftUI


struct FAQPlaceholder: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Frequently Asked Questions")
                .font(.system(size: 18, weight: .semibold))
            
            Text("You can cancel your registration up to 24 hours before the event through this app. This will allow someone from the waitlist to attend.")
                .font(.system(size: 14))
                .foregroundColor(.secondary)
        }
        .padding(.horizontal)
    }
}
