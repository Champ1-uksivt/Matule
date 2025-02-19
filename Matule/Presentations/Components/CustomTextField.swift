//
//  CustomTextField.swift
//  Matule
//
//  Created by uksivt on 19.02.2025.
//  Кастомный элемент текстового поля

import SwiftUI

struct CustomTextField: View {
    var label: String?
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    init(label: String?, placeholder: String, text: Binding<String>, isSecure: Bool = false ) {
        self.label = label
        self.placeholder = placeholder
        self._text = text
        self.isSecure = isSecure
    }
    @State var isShowPassword = false
    @FocusState var isFocused: Bool
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Group {
                if label != nil {
                    Text(label!)
                        .customFont(fontSize: 16, weight: .regular, foreground: .text)
                }
                ZStack(alignment: .leading) {
                    if !isSecure {
                        TextField("", text: $text)
                            .textFieldStyle(CustomTextFieldStyle())
                        
                    }
                    else {
                        ZStack(alignment: .trailing) {
                            if isShowPassword {
                                TextField("", text: $text)
                                    .textFieldStyle(CustomTextFieldStyle())
                            }
                            else {
                                SecureField("", text: $text)
                                    .textFieldStyle(CustomTextFieldStyle())
                                
                            }
                            Button {
                                isShowPassword.toggle()
                            } label: {
                                Image(isShowPassword ? "eye" : "eye.slash")
                            }
                            .padding(.horizontal, 14)
                            
                        }
                        
                    }
                    if text.isEmpty {
                        Text(placeholder)
                            .customFont(fontSize: 14, weight: .regular, foreground: .hint)
                            .padding(.horizontal, 14)
                    }
                }
                .onTapGesture {
                    isFocused = true
                }
                .focused($isFocused)
            }
        }
    }
}

#Preview {
    CustomTextField(label: "Email", placeholder: "xyz@gmail.com", text: .constant(""), isSecure: true)
}
