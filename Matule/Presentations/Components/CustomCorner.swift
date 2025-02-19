//
//  CustomCorner.swift
//  Matule
//
//  Created by Евгений Михайлов on 19.02.2025.
//  Кастомная фигура в которой можно выбрать углы который необходимо закруглить


import SwiftUI

struct CustomCorner: Shape {
    var corners: UIRectCorner = .allCorners
    var radius: CGFloat = 16
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
