//
//  Sneaker.swift
//  Matule
//
//  Created by Михайлов Евгений on 19.02.2025.
//  Моделька кроссовка для декодирование

import Foundation


struct Sneaker: Codable, Identifiable {
    let id: String
    let name: String
    let price: Double
    let category: Int
    let description: String
    let bestseller: Bool
    let fullname: String
    var imageULR: URL?
    var countInBasket: Int?
}
