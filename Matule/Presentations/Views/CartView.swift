//
//  CartView.swift
//  Matule
//
//  Created by Михайлов Евгений on 20.02.2025.
//  Представление корзины

import SwiftUI

struct CartView: View {
    @StateObject var model: MainViewModel
    @Environment(\.presentationMode) var pm
    var body: some View {
        VStack {
            Text("Корзина")
                .customFont(fontSize: 16, weight: .regular, foreground: .text)
                .frame(maxWidth: .infinity, maxHeight: 44)
                .overlay {
                    Button(action:{pm.wrappedValue.dismiss()}) {
                        ZStack{
                            Circle()
                                .foregroundColor(Color.block)
                            Image("arrow.left")
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal, 20)
                .padding(.top, 48)

            ScrollView {
                VStack {
                    Text("\(model.cart.reduce(0) {$0 + $1.countInBasket!}) товара")
                        .customFont(fontSize: 16, weight: .regular, foreground: .text)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 13)
                        .padding(.top, 16)
                    VStack(spacing: 14) {
                        ForEach(model.cart.indices, id: \.self) { i in
                            ProductInBasketView(model: model, sneaker: model.cart[i])
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
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
                NavigationLink(destination: CheckoutView( model: model).navigationBarBackButtonHidden()) {
                    Text("Оформить Заказ")
                }
                .buttonStyle(MainButtonStyle(background: .accent, foreground: .block))
                .disabled(model.costCart == 0.0)
                .padding(.bottom, 32)
            }
            .padding(.horizontal, 20)
            .background(Color.block)
        }
        .ignoresSafeArea()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
}

#Preview {
    CartView(model: MainViewModel())
}
