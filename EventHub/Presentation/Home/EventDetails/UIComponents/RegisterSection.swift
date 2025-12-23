//
//  RegisterSection.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 23.12.25.
//

import SwiftUI


struct RegisterSection: View {
    let event: Event
    let onRegister: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Button(action: onRegister) {
                Text(buttonText)
                    .font(.system(size: 14, weight: .semibold))
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(buttonColor)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .disabled(event.isFull)
            .padding(.top, 8)
            
            Text("Registration deadline: TBA")
                .font(.system(size: 12))
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.horizontal)
    }
    
    private var buttonText: String {
        if event.isFull {
            return "Event Full"
        }
        return "Register Now"
    }
    
    private var buttonColor: Color {
        event.isFull ? .gray : .black
    }
}
