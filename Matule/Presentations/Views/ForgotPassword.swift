//
//  ForgotPassword.swift
//  Matule
//
//  Created by Михайлов Евгений on 20.02.2025.
//  Представление с восстановлением пароля

import SwiftUI

struct ForgotPassword: View {
    @Environment(\.presentationMode) var pm
    @StateObject var model: LoginViewModel
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
            .frame(maxWidth: .infinity,minHeight: 44, maxHeight: 44, alignment: .leading)
            .padding(.top, 66)
            .padding(.bottom, 20)
            
            Text("Забыл пароль")
                .customFont(fontSize: 32, weight: .regular, foreground: .text)
                .padding(.bottom, 8)
            Text("Введите Свою Учетную Запись\nДля Сброса")
                .customFont(fontSize: 16, weight: .regular, foreground: .subTextDark)
                .multilineTextAlignment(.center)
                .padding(.bottom, 40)
                .lineSpacing(4)
            CustomTextField(label: nil, placeholder: "xyz@gmail.com", text: $model.email)
                .padding(.bottom, 40)
            Button(action: {
                model.sendCode()
            }) {
                Text("Отправить")
            }
            .buttonStyle(MainButtonStyle(background: .accent, foreground: .block))
            Spacer()
        }
        .onLoadingProccess(isLoading: model.isLoading)
        .padding(.horizontal, 20)
        .ignoresSafeArea(.all)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.block)
        .blur(radius: model.codeIsSend ? 2 : 0)
        .overlay {
            if model.codeIsSend {
                ZStack {
                    Color.blur.opacity(0.2)
                    NavigationLink(destination: OTPView(model: model)
                        .navigationBarBackButtonHidden()
                    ) {
                        VStack {
                            Circle()
                                .frame(maxWidth: 44, maxHeight: 44)
                                .foregroundColor(Color.accent)
                                .overlay {
                                    Image("mail")
                                }
                                .padding(.bottom, 24)
                                .padding(.top, 30)
                            Text("Проверьте Ваш Email")
                                .customFont(fontSize: 16, weight: .regular, foreground: .text)
                                .padding(.bottom, 8)
                            Text("Мы Отправили Код Восстановления Пароля На Вашу Электронную Почту.")
                                .customFont(fontSize: 16, weight: .regular, foreground: .hint)
                                .multilineTextAlignment(.center)
                                .padding(.bottom, 30)
                                .padding(.horizontal, 20)

                        }
                        .padding(.horizontal, 10)
                        .background(Color.block)
                        .cornerRadius(16)
                        .padding(.horizontal, 20)
                    }
                        .buttonStyle(.plain)
                    
                }
                .ignoresSafeArea(.all)
                .onTapGesture {
                    model.codeIsSend = false
                    
                }
            }
        }
    }
}

#Preview {
    ForgotPassword(model: LoginViewModel())
}
