//
//  View.swift
//  Matule
//
//  Created by Евгений Михайлов on 19.02.2025.
//  Расширение базового типа

import Foundation
import SwiftUI



extension View {
    @ViewBuilder
    func customFont(fontSize: CGFloat, weight: FontWeight, foreground: Color) -> some View {
        // Метод для шрифта (удобно)
        switch weight{
        case .regular: self.font(.custom("Roboto-Regular", size: fontSize)).foregroundColor(foreground)
        case .bold: self.font(.custom("Roboto-Bold", size: fontSize)).foregroundColor(foreground)
        }
    }
    
    @ViewBuilder
    func onLoadingProccess(isLoading: Bool) -> some View {
        // индиксация
        if isLoading {
            ZStack {
                self
                ProgressView()
            }
        }
        else {
            self
        }
    }
    @ViewBuilder
        func onLoading(isLoading: Bool) -> some View {
            // индиксация
            if isLoading {
                ProgressView()
            }
            else {
                self
            }
        }
}
