//
//  Ad.swift
//  Matule
//
//  Created by Михайлов Евгений on 19.02.2025.
//  Моделька для рекламы

import Foundation



struct Ad: Codable, Identifiable {
    let id: String
    var imageURL: URL?
}
