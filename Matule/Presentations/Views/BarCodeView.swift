//
//  BarCodeView.swift
//  Matule
//
//  Created by Михайлов Евгений on 21.02.2025.
//  Отображение баркода на весь экран

import SwiftUI

struct BarCodeView: View {
    var image: String
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFit()
            .rotationEffect(.degrees(90))
            .scaleEffect(2)
            .onAppear {
                UIScreen.main.brightness = 0.8
            }
    }
}
