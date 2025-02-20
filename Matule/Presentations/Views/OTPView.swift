//
//  OTPView.swift
//  Matule
//
//  Created by Михайлов Евгений on 20.02.2025.
//  Представление с ОТП

import SwiftUI

struct OTPView: View {
    @StateObject var model: LoginViewModel
    @Environment(\.presentationMode) var pm
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

            Text("OTP проверка")
                .customFont(fontSize: 32, weight: .regular, foreground: .text)
                .padding(.bottom, 8)
            Text("Пожалуйста, проверьте свою электронную\nпочту, чтобы увидеть код подтверждения")
                .customFont(fontSize: 16, weight: .regular, foreground: .subTextDark)
                .multilineTextAlignment(.center)
                .padding(.bottom, 30)
                .lineSpacing(4)
            Text("OTP Код")
                .customFont(fontSize: 21, weight: .regular, foreground: .text)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 20)
                .padding(.top, 16)
//            TextField("", text: $model.code)
//                .textFieldStyle(CustomTextFieldStyle())
//                .padding(.bottom, 20)
            HStack(spacing: 12) {
                ForEach(0..<model.codeList.count) { index in
                    TextField("", text: $model.codeList[index])
                        .frame(maxWidth: .infinity, maxHeight: 99)
                        .background(Color.background)
                        .multilineTextAlignment(.center)
                        .cornerRadius(12)
                        .overlay {
                            if model.statusCode == .faield {
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.customRed)
                            }
                        }
                        
                }
            }
            .padding(.bottom, 20)
            HStack {
                Button(action: {}) {
                    Text("Отправить заново")
                        .customFont(fontSize: 12, weight: .regular, foreground: .subTextDark)
                    Spacer()
                    Text("00:30")
                        .customFont(fontSize: 12, weight: .regular, foreground: .subTextDark)
                }
            }
            
            Spacer()
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea(.all)
        .background(Color.block)
        .navigationBarBackButtonHidden()
        .overlay {
            if model.statusCode == .success {
                VStack {
                    TextField("", text: $model.password)
                        .textFieldStyle(CustomTextFieldStyle())
                    TextField("", text: .constant(model.password.replacingOccurrences(of: "o", with: "0")
                        .replacingOccurrences(of: "O", with: "0")
                        .replacingOccurrences(of: "l", with: "1")
                        .replacingOccurrences(of: "i", with: "1")
                        .replacingOccurrences(of: "g", with: "9")
                        .replacingOccurrences(of: "s", with: "5")
                        .replacingOccurrences(of: "S", with: "5")
                        .replacingOccurrences(of: "G", with: "6")))
                    Button {
                        model.resetPassowrd(password: model.password
                            .replacingOccurrences(of: "o", with: "0")
                            .replacingOccurrences(of: "O", with: "0")
                            .replacingOccurrences(of: "l", with: "1")
                            .replacingOccurrences(of: "i", with: "1")
                            .replacingOccurrences(of: "g", with: "9")
                            .replacingOccurrences(of: "s", with: "5")
                            .replacingOccurrences(of: "S", with: "5")
                            .replacingOccurrences(of: "G", with: "6"))
                    } label: {
                        Text("Задать пароль")
                            
                    }
                    .buttonStyle(MainButtonStyle(background: .accent, foreground: .block))

                }
                .background(Color.disable)
            }
        }
    }
}

#Preview {
    OTPView(model: LoginViewModel())
}
