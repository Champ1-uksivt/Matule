//
//  CartResponse.swift
//  Matule
//
//  Created by Михайлов Евгений on 19.02.2025.
//  Моделька для декодирование корзины

import Foundation

struct CartResponse: Codable, Identifiable {
    let id: Int
    let sneaker: String
    var count: Int
    let user: String
}
