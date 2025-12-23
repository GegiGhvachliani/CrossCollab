//
//  Untitled.swift
//  EventHub
//
//  Created by Gegi Ghvachliani on 21.12.25.
//

import SwiftUI
import Combine

struct CustomTextField: View {
    @Binding var text: String
    var title: String
    var placeHolder: String
    var withSymbol: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.system(size: 15))

            HStack {
                if withSymbol {
                    Image(systemName: "envelope")
                        .resizable()
                        .frame(width: 20, height: 13)
                        .foregroundStyle(.secondary)
                        
                }
                TextField(placeHolder, text: $text)
            }
            .frame(height: 25)
            .foregroundStyle(.black.opacity(0.7))
            .font(.system(size: 15))
            .autocorrectionDisabled()
            .padding(10)
            .padding(.horizontal, 10)
            .background(
                RoundedRectangle(cornerRadius: 7)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
        }
    }
}


struct CustomPasswordTextField: View {
    
    @Binding var text: String
    
    var title: String
    var placeHolder: String
    
    var isSecure: Bool = true
    
    @State private var isPasswordVisible: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(Font.system(size: 15))
            
            HStack {
                if isSecure && !isPasswordVisible {
                    SecureField(placeHolder, text: $text)
                        .frame(height: 25)
                        .font(Font.system(size: 15))
                        .autocorrectionDisabled()
                } else {
                    TextField(placeHolder, text: $text)
                        .frame(height: 25)
                        .font(Font.system(size: 15))
                        .autocorrectionDisabled()
                }
                
                if isSecure {
                    Button {
                        isPasswordVisible.toggle()
                    } label: {
                        Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.gray)
                            .font(.system(size: 16))
                    }
                }
            }
            .padding(10)
            .padding(.horizontal, 10)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray.opacity(0.5), lineWidth: 1)
            )
        }
    }
}


#Preview {
    @State var email = ""
    //    CustomPasswordTextField(text: $email, title: "Email",
    //                    placeHolder: "Enter your email")
    @State var text: String = ""
    CustomTextField(
        text: $text,
        title: "Email",
        placeHolder: "Enter email",
        withSymbol: true
    )
}

