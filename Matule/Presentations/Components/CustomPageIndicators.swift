//
//  CustomPageIndicators.swift
//  Matule
//
//  Created by Евгений Михайлов on 19.02.2025.
//  Отображение страниц на онборде

import SwiftUI

struct CustomPageIndicators: View {
    @Binding var currentPage: Int
    var body: some View {
        HStack(spacing: 12) {
            ForEach(0..<3) { index in
                Capsule()
                    .frame(maxWidth: index == currentPage ? 43 : 28, maxHeight: 5)
                    .foregroundColor(index == currentPage ? .block : .disable)
                
            }
        }
    }
}
