//
//  FavoriteResponse.swift
//  Matule
//
//  Created by Михайлов Евгений on 19.02.2025.
//  Моделька для декодирование избранных

import Foundation


struct FavoriteResponse: Codable, Identifiable {
    let id: Int
    let sneaker: String
    let user: String
    
}
