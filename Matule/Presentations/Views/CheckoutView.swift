//
//  CheckoutView.swift
//  Matule
//
//  Created by Михайлов Егвнеий on 20.02.2025.
// Подтверждение заказа

import SwiftUI

struct CheckoutView: View {
    @Environment(\.presentationMode) var pm
    @StateObject var model: MainViewModel
    @State var showwi = false
    var body: some View {
        VStack {
            Text("Корзина")
                .customFont(fontSize: 16, weight: .regular, foreground: .text)
                .frame(maxWidth: .infinity, maxHeight: 44)
                .overlay {
                    Button(action: {
                        pm.wrappedValue.dismiss()
                    }) {
                        ZStack{
                            Circle()
                                .foregroundColor(Color.block)
                            Image("arrow.left")
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.top, 48)
            VStack {
                Text("Контактная информация")
                    .customFont(fontSize: 14, weight: .regular, foreground: .text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.vertical, 16)
                
                ContactField(text: Binding(get: {
                    model.user!.email ?? ""
                }, set: { value in
                    model.user!.email = value
                }), label: "Email", image: "mail.black", placeholder: "*******@****.**")
                .padding(.bottom, 16)
                ContactField(text: Binding(get: {
                    model.user!.phone ?? ""
                }, set: { value in
                    model.user!.phone = value
                }), label: "Телефон", image: "phone.black", placeholder: "**-***-***-****")
                .padding(.bottom, 12)
                Text("Адрес")
                    .customFont(fontSize: 14, weight: .regular, foreground: .text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 12)
                HStack {
                    TextField("Адрес...", text: $model.address)
                        .customFont(fontSize: 12, weight: .regular, foreground: .hint)
                    Spacer()
                    Image("edit")
                }
                .padding(.bottom, 16)
                Image("map")
                    .resizable()
                    .scaledToFit()
                    .padding(.bottom,12)
                Text("Способ оплаты")
                    .customFont(fontSize: 14, weight: .regular, foreground: .text)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 12)
                HStack(spacing: 12) {
                    Group {
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(Color.background)
                            .overlay {
                                Image("icon.credit")
                                    .resizable()
                                    .scaledToFit()
                            }
                            .frame(maxWidth: 40, maxHeight: 40)
                        VStack(alignment: .leading, spacing: 4) {
                            Text("DbL Card")
                                .customFont(fontSize: 14, weight: .regular, foreground: .text)
                            
                            
                            
                            Text("**** **** 0696 4629")
                                .customFont(fontSize: 12, weight: .regular, foreground: .hint)
                        }
                        Spacer()
                        Button {
                        } label: {
                            Image("arrow.bottom")
                        }
                    }
                }
                .frame(height: 40)
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 25)
            .background(Color.block)
            .cornerRadius(16)
            VStack {
                HStack {
                    Text("Сумма")
                        .customFont(fontSize: 16, weight: .regular, foreground: .subTextDark)
                    Spacer()
                    Text(model.costCart.price())
                        .customFont(fontSize: 16, weight: .regular, foreground: .text)

                }
                .padding(.top, 34)
                .padding(.bottom, 10)
                HStack {
                    Text("Доставка")
                        .customFont(fontSize: 16, weight: .regular, foreground: .subTextDark)
                    Spacer()
                    Text(model.costDelivery.price())
                        .customFont(fontSize: 16, weight: .regular, foreground: .text)

                }
                ZStack {
                    Capsule()
                        .frame(maxWidth: .infinity, maxHeight: 2)
                        .foregroundColor(.subTextDark.opacity(0.5))
                    HStack {
                        ForEach(0..<33) { index in
                            Spacer()
                                .frame(width: 6)
                            Rectangle()
                                .foregroundColor(Color.block)
                                .frame(maxWidth: 6, maxHeight: 2)
                        }
                    }
                }
                .padding(.top, 18)
                .padding(.bottom, 15)
                
                HStack {
                    Text("Итого")
                        .customFont(fontSize: 16, weight: .regular, foreground: .text)
                    Spacer()
                    Text((model.costCart + model.costDelivery).price())
                        .customFont(fontSize: 16, weight: .regular, foreground: .accent)

                }
                .padding(.bottom, 32)
                Button(action: {showwi = true}) {
                    Text("Подтвердить")
                }
                .buttonStyle(MainButtonStyle(background: .accent, foreground: .block))
                .disabled(model.costCart == 0.0)
                .padding(.bottom, 32)
            }
        }
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
        .background(Color.background)
        .blur(radius: showwi ? 2 : 0)
        .overlay {
            if showwi {
                ZStack {
                    Color.blur.opacity(0.2)
                    
                    VStack {
                        ZStack {
                            Circle()
                                .foregroundColor(.accent.opacity(0.15))
                                .overlay {
                                    Image("ura")
                                        .resizable()
                                        .scaledToFit()
                                }
                                .frame(maxWidth: 134, maxHeight: 134)
                                
                                .padding(.bottom, 24)
                        }
                        Text("Вы успешно\nоформили заказ")
                            .customFont(fontSize: 20, weight: .regular, foreground: .text)
                            .padding(.bottom, 30)
                        NavigationLink(destination: MainView()
                            .navigationBarBackButtonHidden()) {
                            Text("Вернуться к покупкам")
                        }
                            .buttonStyle(MainButtonStyle(background: .accent, foreground: .block))
                            .padding(.horizontal, 51.5)
                        
                    }
                    .background(Color.block)
                    .cornerRadius(16)
                    .padding()

                }
                .ignoresSafeArea(.all)
            }
        }
    }
}

#Preview {
    CheckoutView(model: MainViewModel())
}
