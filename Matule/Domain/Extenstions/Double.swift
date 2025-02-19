//
//  Double.swift
//  Matule
//
//  Created by Евгений Михайлов on 19.02.2025.
//  Расширения для Double

import Foundation


extension Double {
    func price() -> String {
        // Форматирование цены
        return String(format: "₽%.2f", self)
    }
}
