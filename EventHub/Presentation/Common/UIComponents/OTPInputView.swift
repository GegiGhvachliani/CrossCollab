//
//  Untitled.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.

import SwiftUI

struct OTPView: View {
    @Binding var otp: String
    let length = 6
    
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        VStack {
            ZStack {
                TextField("", text: $otp)
                    .keyboardType(.numberPad)
                    .textContentType(.oneTimeCode)
                    .foregroundColor(.clear)
                    .accentColor(.clear)
                    .focused($isTextFieldFocused)
                    .frame(height: 45)
                    .background(Color.clear)
                
                HStack(spacing: 12) {
                    ForEach(0..<length, id: \.self) { index in
                        OTPBox(index: index, text: otp)
                    }
                }
                .allowsHitTesting(false)
            }
        }
        .contentShape(Rectangle())
        .onTapGesture {
            isTextFieldFocused = true
        }
        .onChange(of: otp) { newValue in
            otp = String(newValue.prefix(length).filter { $0.isNumber })
        }
    }
}

struct OTPBox: View {
    let index: Int
    let text: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                .frame(width: 45, height: 45)
            
            Text(charAtIndex())
                .font(.title3)
        }
    }
    
    private func charAtIndex() -> String {
        if index < text.count {
            let idx = text.index(text.startIndex, offsetBy: index)
            return String(text[idx])
        }
        return ""
    }
}



#Preview {
    @Previewable @State var otp: String = "123"
    OTPView(otp: $otp)
}
