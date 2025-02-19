//
//  LoginView.swift
//  Matule
//
//  Created by uksivt on 19.02.2025.
//  Представление авторизации
//  Данные для входа
//  email: e.mikhaylov2006@gmail.com
//  password: qweQWE123

import SwiftUI

struct LoginView: View {
    @StateObject var model = LoginViewModel()
    var body: some View {
        NavigationStack{
            VStack {
                NavigationLink {
                    MainView()
                        .navigationBarBackButtonHidden()
                } label: {
                    Text("Пропустить")
                        .customFont(fontSize: 12, weight: .regular, foreground: .subTextDark)
                }
                .padding(.bottom, 62)
                .padding(.top, 48)
                .frame(maxWidth: .infinity, alignment: .trailing)

                Text("Привет!")
                    .customFont(fontSize: 32, weight: .regular, foreground: .text)
                    .padding(.bottom, 8)
                Text("Заполните Свои Данные Или\nПродолжите Через Социальные Медиа")
                    .customFont(fontSize: 16, weight: .regular, foreground: .subTextDark)
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 30)
                    .lineSpacing(4)
                CustomTextField(label: "Email", placeholder: "xyz@gmail.com", text: $model.email, isSecure: false)
                    .padding(.bottom, 26)
                    .accessibilityIdentifier("email")
                CustomTextField(label: "Пароль", placeholder: "••••••••", text: $model.password, isSecure: true)
                    .padding(.bottom, 16)
                    .accessibilityIdentifier("password")

                NavigationLink(destination: EmptyView(), label: {
                    Text("Восстановить")
                        .customFont(fontSize: 12, weight: .regular, foreground: .subTextDark)

                })
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.bottom, 24)

                Button {
                    model.loginUser()
                } label: {
                    Text("Войти")
                    
                }
                .buttonStyle(MainButtonStyle(background: .accent, foreground: .block))
                .accessibilityIdentifier("btn")
                Spacer()
                HStack {
                    Text("Вы впервые?")
                        .customFont(fontSize: 16, weight: .regular, foreground: .hint)
                    NavigationLink(destination: EmptyView()) {
                        Text("Создать пользователя")
                            .customFont(fontSize: 16, weight: .regular, foreground: .text)
                    }
                }
                .padding(.bottom, 47)

                

            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.block)
            .ignoresSafeArea(.all)
            .onLoadingProccess(isLoading: model.isLoading)
            .navigationDestination(isPresented: $model.isLogin) {
                MainView()
                    .navigationBarBackButtonHidden()
            }
        }
    }
}

#Preview {
    LoginView()
}
