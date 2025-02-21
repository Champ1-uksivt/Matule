//
//  Date.swift
//  Matule
//
//  Created by Михайлов Евгений on 21.02.2025.
//  Расшиерние для даты (не работает все равно)

import Foundation
import SwiftUI


extension Date {
    func format() -> String {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yyyy HH:mm"
        return ""
    }
}
