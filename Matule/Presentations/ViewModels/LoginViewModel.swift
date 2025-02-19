//
//  LoginViewModel.swift
//  Matule
//
//  Created by uksivt on 19.02.2025.
//  Логика для представления с авторизацией

import Foundation
import Auth



@MainActor
final class LoginViewModel : ObservableObject {
    @Published var isLoading = false
    @Published var isLogin = false
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isError = false
    @Published var messageError = ""
    
    func loginUser() {
        Task {
            if email.isEmpty || password.isEmpty {
                messageError = "Поля не могут быть пусты"
                isError = true
                return
            }
            if !email.validateEmail(){
                messageError = "Некорректный формат email"
                isError = true
                return
            }
            if !password.validatePassword(){
                messageError = "Некорректный формат пароля"
                isError = true
                return
            }
            isLoading = true
            do{
                try await SupabaseService.shared.login(email: email, password: password)
                isLogin = true
            }
            catch {
                if let supabaseError = error as? AuthError {
                    switch supabaseError.errorCode {
                    case .invalidCredentials: messageError = "Неверный логин или пароль"
                    default: messageError = supabaseError.localizedDescription
                    }
                }
                else if let networkError = error as? URLError {
                    switch networkError.code {
                    case .notConnectedToInternet: messageError = "Нету подключения к интернету"
                    default: messageError = networkError.localizedDescription
                    }
                }
                else {
                    messageError = error.localizedDescription
                }
                isError = true
            }
            isLoading = false
            
        }
    }
}
