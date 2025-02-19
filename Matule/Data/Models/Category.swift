//
//  Category.swift
//  Matule
//
//  Created by Михайлов Евгений on 19.02.2025.
//  Моделька категории для декодирование

import Foundation


struct Category: Codable, Identifiable {
    let id: Int
    let name: String
    var locizedname: String {
        NSLocalizedString(name, comment: "")
    }
}
