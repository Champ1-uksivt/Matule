//
//  CustomTextFieldStyle.swift
//  Matule
//
//  Created by uksivt on 19.02.2025.
//  Стиль для текстового поля

import Foundation
import SwiftUI


struct CustomTextFieldStyle : TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal, 14)
            .frame(maxWidth: .infinity, maxHeight: 48)
            .background(Color.background)
            .customFont(fontSize: 14, weight: .regular, foreground: .text)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .cornerRadius(15)
    }
}
