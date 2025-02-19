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

        let emailregex = "[a-z0-9&._+-]+@[a-z0-9_-]+\\.[a-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailregex).evaluate(with: self)
    }
    func validatePassword() -> Bool {
        // валидация пароля
            let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])[a-zA-Z0-9]{6,12}$"
            return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: self)
        }
}
