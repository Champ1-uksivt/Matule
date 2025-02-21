//
//  LoginView.swift
//  Matule
//
//  Created by Евгений Михайлов on 19.02.2025.
//  Представление авторизации



//  !!!Данные для входа!!!
//  email: e.mikhaylov2006@gmail.com
//  password: qweQWE123

import SwiftUI

struct LoginView: View {
    @Environment(\.presentationMode) var pm
    @StateObject var model = LoginViewModel()
    var body: some View {
            VStack {
                Button {
                    pm.wrappedValue.dismiss()
                } label: {
                    ZStack {
                        Circle()
                            .foregroundColor(Color.background)
                        Image("arrow.left")
                    }
                }
                .frame(maxWidth: .infinity,maxHeight: 44, alignment: .leading)
                .padding(.top, 66)
                .padding(.bottom, 11)

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

                NavigationLink(destination: ForgotPassword(model: model).navigationBarBackButtonHidden(), label: {
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
                .accessibilityIdentifier("btn")
                .buttonStyle(MainButtonStyle(background: .accent, foreground: .block))
                Spacer()
                HStack {
                    Text("Вы впервые?")
                        .customFont(fontSize: 16, weight: .regular, foreground: .hint)
                    NavigationLink(destination: SignUp().navigationBarBackButtonHidden()) {
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
            .alert("Ошибка", isPresented: $model.isError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(model.messageError)
            }
            .onAppear {
                model.clear()
            }

        }
    
}

#Preview {
    LoginView()
}
