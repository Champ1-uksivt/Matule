//
//  ProductView.swift
//  Matule
//
//  Created by Евгений Михайлов on 19.02.2025.
//  UI элемент карточки товара

import SwiftUI
import Kingfisher

struct ProductView: View {
    @StateObject var model: MainViewModel
    var sneaker: Sneaker
    var body: some View {
        VStack {
            Spacer()
            KFImage(sneaker.imageULR)
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 9)
                .padding(.top, 18)
                .padding(.bottom, 12)
            Text(sneaker.bestseller ? "BEST SELLER" : "")
                .customFont(fontSize: 12, weight: .regular, foreground: .accent)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 9)
                .padding(.bottom, 8)
            Text(sneaker.name)
                .customFont(fontSize: 16, weight: .regular, foreground: .hint)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 9)
            HStack {
                Text(sneaker.price.price())
                    .customFont(fontSize: 14, weight: .regular, foreground: .text)
                    .padding(.horizontal, 9)
                Spacer()
                Button(action: {
                    
                }) {
                    ZStack {
                        CustomCorner(corners: [.topLeft, .bottomRight])
                            .foregroundColor(Color.accent)
                        Image("plus")
                    }
                }
                .frame(maxWidth: 34, maxHeight: 34)

            }
            
        }
        .overlay {
                    Button(action: {}) {
                        ZStack {
                            Circle()
                                .foregroundColor(Color.background)
                            Image("heart.unfill")
                                
                        }
                        .frame(maxWidth: 28, maxHeight: 28)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .padding(9)
                }
        .background(Color.block)
        .cornerRadius(16)
        .frame(maxWidth: UIScreen.main.bounds.width/2, maxHeight: UIScreen.main.bounds.height * 0.3)
        
    }
}

#Preview {
    ProductView(model: MainViewModel(), sneaker: Sneaker(id: "qweqwe", name: "Nike Air Max", price: 9123.123123, category: 1, description: "QWE QWEQWE  QWE QWE ", bestseller: true, fullname: "Nie Air Max 270", imageULR: URL(string: "https://dnhbfwerqzathenuvacj.supabase.co/storage/v1/object/public/assets//631b7043-e9f1-4c42-a8a1-8a2e55ec6b48.png")))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.disable)
}
