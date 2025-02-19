//
//  String.swift
//  Matule
//
//  Created by uksivt on 19.02.2025.
//  Расширение для строки

import Foundation


extension String {
    func validateEmail() -> Bool {
        // валидация email

        let emailregex = "[0-9a-z&._+-]+@[0-9a-z_-]+\\.[a-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailregex).evaluate(with: self)
    }
    func validatePassword() -> Bool {
        // валидация пароля
            let passwordRegex = "^(?=.*[A-Z])(?=.*[a-z])(?=.*[0-9])[A-Za-z0-9]{6,12}$"
            return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
        }
}
