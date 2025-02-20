//
//  LoginViewModel.swift
//  Matule
//
//  Created by Михайлов Евгений on 19.02.2025.
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
    @Published var codeIsSend = false
    @Published var code = ""
    @Published var codeList: [String] = Array(repeating: "", count: 6) {
        didSet {
            print(codeList)
            code = codeList.joined()
            print(code)
            if code.count == 6 {
                verifyCode()
            }
        }
    }
    @Published var timer = 60
    @Published var statusCode: CodeStatus = .none
    
    func startTimer() {
        if timer == 0 {
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.timer -= 1
        }
        startTimer()
    }
    
    func resetPassowrd(password: String) {
        Task {
            if !password.validatePassword() {
               return
            }
            do {
                try await SupabaseService.shared.updatePassword(password: password)
                statusCode = .none
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func verifyCode() {
        Task {
            do {
                try await SupabaseService.shared.verifyCode(code: code, email: email)
                statusCode = .success
            }
            catch {
                print(error.localizedDescription)
                statusCode = .faield
            }
        }
    }
    
    func sendCode() {
        Task {
            isLoading = true
            do {
                try await SupabaseService.shared.sendCodeToEmail(for: email)
                codeIsSend = true
                timer = 60
                //startTimer()
            }
            catch {
                print(error.localizedDescription)
            }
            isLoading = false

        }
    }
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
