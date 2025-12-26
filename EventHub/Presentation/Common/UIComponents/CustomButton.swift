//
//  Untitled.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import SwiftUI

struct CustomButton: View {
    
    let title: String
    let action: () -> Void
    let isLoading: Bool
    
    var backgroundColor: Color = .blue
    var foregroundColor: Color = .white
    var cornerRadius: CGFloat = 7
    var height: CGFloat = 50
    var font: Font = .system(size: 16)
    
    var body: some View {
        Button(action: action) {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor)
                    .frame(height: height)
                
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: foregroundColor))
                } else {
                    Text(title)
                        .foregroundStyle(foregroundColor)
                        .font(font)
                }
            }
        }
        .disabled(isLoading)
    }
}
