//
//  OrdersView.swift
//  Matule
//
//  Created by Михайлов Евгений on 21.02.2025.
//  Представление для отображение заказов

import SwiftUI

struct OrdersView: View {
    @Environment(\.presentationMode) var pm
    @StateObject var model: MainViewModel
    var body: some View {
        ScrollView {
            VStack {
                Text("Заказы")
                    .customFont(fontSize: 16, weight: .regular, foreground: .text)
                    .frame(maxWidth: .infinity, maxHeight: 44)
                    .overlay {
                        Button(action: {pm.wrappedValue.dismiss()}) {
                            ZStack {
                                Circle()
                                    .foregroundColor(.block)
                                Image("arrow.left")
                            }
                            .frame(minHeight: 44)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.top, 48)
                Text("НЕ УСПЕЛ😩")
                    .customFont(fontSize: 32, weight: .bold, foreground: .accent)
                    
            }
            .padding(.horizontal, 20)
        }
        .ignoresSafeArea(.all)
        .background(Color.background)
    }
}

#Preview {
    OrdersView(model: MainViewModel())
}
