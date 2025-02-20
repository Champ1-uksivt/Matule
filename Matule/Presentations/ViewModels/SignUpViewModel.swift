//
//  SignUpViewModel.swift
//  Matule
//
//  Created by Михайлов Евгений on 20.02.2025.
//  Небольшая вьюмоделька для регистрации

import Foundation
import Auth


@MainActor
final class SignUpViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var isError = false
    @Published var messageError = ""
    @Published var isRegister = false
    
    func signUp() {
        Task {
            if email.isEmpty || password.isEmpty || name.isEmpty {
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
                try await SupabaseService.shared.signUp(email: email, password: password, name: name)

                isRegister = true

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
    func clearSession() {
        Task {
            do {
                try await SupabaseService.shared.clear()
            }catch {
                print(error.localizedDescription)
            }
        }
    }
}
