//
//  SignUp.swift
//  Matule
//
//  Created by uksivt on 20.02.2025.
//

import SwiftUI

struct SignUp: View {
    @StateObject var model = SignUpViewModel()
    @Environment(\.presentationMode) var pm
    @State var pdfIsRead = false
    @State var pdfViewPresented = false
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
            .padding(.bottom, 11)
            
            Text("Регистрация")
                .customFont(fontSize: 32, weight: .regular, foreground: .text)
                .padding(.bottom, 8)
            Text("Заполните Свои Данные Или\nПродолжите Через Социальные Медиа")
                .customFont(fontSize: 16, weight: .regular, foreground: .subTextDark)
                .multilineTextAlignment(.center)
                .padding(.bottom, 30)
                .lineSpacing(4)
            CustomTextField(label: "Ваше имя", placeholder: "xxxxxxxx", text: $model.name, isSecure: false)
                .padding(.bottom, 12)
                .accessibilityIdentifier("email")
            CustomTextField(label: "Email", placeholder: "xyz@gmail.com", text: $model.email, isSecure: false)
                .padding(.bottom, 12)
                .accessibilityIdentifier("email")
            CustomTextField(label: "Пароль", placeholder: "••••••••", text: $model.password, isSecure: true)
                .padding(.bottom, 12)
                .accessibilityIdentifier("password")
            HStack(spacing: 12) {
                Button(action: {pdfIsRead.toggle()}) {
                    RoundedRectangle(cornerRadius: 6)
                        .frame(maxWidth: 16, maxHeight: 16)
                        .foregroundColor(pdfIsRead ? .accent : .background)
                        .overlay {
                            Image("shield")
                        }
                }
                NavigationLink(destination: PDFReader()) {
                    Text("Даю согласие на обработку персональных данных")
                        .customFont(fontSize: 16, weight: .regular, foreground: .hint)
                        .underline()
                        .multilineTextAlignment(.leading)
                }
                Spacer()
            }
            .padding(.bottom, 24)
            Button {
                model.signUp()
            } label: {
                Text("Зарегистрироваться")
            }
            .buttonStyle(MainButtonStyle(background: .accent, foreground: .block))
            Spacer()
            HStack {
                Text("Есть аккаунт?")
                    .customFont(fontSize: 16, weight: .regular, foreground: .hint)
                Button(action: {pm.wrappedValue.dismiss()}) {
                    Text("Войти")
                        .customFont(fontSize: 16, weight: .regular, foreground: .text)
                }
            }
            .padding(.bottom, 47)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
        .background(Color.block)
        .padding(.horizontal, 20)
        .onLoadingProccess(isLoading: model.isLoading)
        .navigationDestination(isPresented: $model.isRegister) {
            MainView()
                .navigationBarBackButtonHidden()
        }
        .onAppear {
            model.clearSession()
        }
        .alert("Ошибка", isPresented: $model.isError) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(model.messageError )
        }

    }
}

#Preview {
    NavigationStack {
        SignUp()
    }
}
