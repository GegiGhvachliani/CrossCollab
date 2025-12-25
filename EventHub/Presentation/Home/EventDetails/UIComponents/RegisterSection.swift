//
//  RegisterSection.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 23.12.25.
//

import SwiftUI

struct RegisterSection: View {
    let event: Event
    @ObservedObject var viewModel: EventDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Button(action: handleButtonTap) {
                HStack {
                    if viewModel.isRegistering {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    } else {
                        Text(buttonText)
                    }
                }
                .font(.system(size: 14, weight: .semibold))
                .frame(maxWidth: .infinity)
                .padding()
                .background(buttonColor)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .disabled(isButtonDisabled)
            .padding(.top, 8)
            
            // Show status message if registered
            if let status = viewModel.registrationStatus {
                HStack {
                    Image(systemName: status == "Confirmed" ? "checkmark.circle.fill" : "clock.fill")
                    Text("Status: \(status)")
                }
                .font(.caption)
                .foregroundColor(status == "Confirmed" ? .green : .orange)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            
            Text("Registration deadline: TBA")
                .font(.system(size: 12))
                .foregroundColor(.secondary)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.horizontal)
    }
    
    // MARK: - Computed Properties
    private var buttonText: String {
        if let status = viewModel.registrationStatus {
            // Already registered - show cancel option
            return status == "Confirmed" ? "Cancel Registration" : "Leave Waitlist"
        }
        // Not registered - show register option
        return event.isFull ? "Join Waitlist" : "Register Now"
    }
    
    private var buttonColor: Color {
        if viewModel.registrationStatus != nil {
            // Registered - red for cancel
            return .red
        }
        // Not registered
        return event.isFull ? .orange : .black
    }
    
    private var isButtonDisabled: Bool {
        viewModel.isRegistering
    }
    
    // MARK: - Actions
    private func handleButtonTap() {
        // CHANGED: Use the new method from ViewModel
        viewModel.handleRegistrationAction()
    }
}
