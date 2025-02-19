//
//  MainButtonStyle.swift
//  Matule
//
//  Created by uksivt on 19.02.2025.
//  Стиль для кнопки

import Foundation
import SwiftUI


struct MainButtonStyle : ButtonStyle {
    var background: Color
    var foreground: Color
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(background)
            .customFont(fontSize: 14, weight: .regular, foreground: foreground)
            .cornerRadius(14)
    }
}
