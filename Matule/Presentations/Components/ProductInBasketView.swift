//
//  ProductInBasketView.swift
//  Matule
//
//  Created by uksivt on 19.02.2025.
//

import SwiftUI
import SwipeActions
import Kingfisher

struct ProductInBasketView: View {
    @StateObject var model: MainViewModel
    var sneaker: Sneaker
    var body: some View {
        SwipeView(label: {
            HStack {
                RoundedRectangle(cornerRadius: 16)
                    .foregroundColor(Color.background)
                    .frame(maxWidth: UIScreen.main.bounds.width*0.232, maxHeight: UIScreen.main.bounds.width*0.232)
                    .overlay {
                        KFImage(sneaker.imageULR)
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(0.85)
                    }
                    .padding(10)
                VStack(alignment: .leading) {
                    Text(sneaker.name)
                        .customFont(fontSize: 16, weight: .regular, foreground: .text)
                    Text(sneaker.price.price())
                        .customFont(fontSize: 14, weight: .regular, foreground: .text)
                    
                }
                .padding(.leading, 30)
                Spacer()
            }
            .background(Color.block)
            .cornerRadius(8)
            
        }, leadingActions: { la in
            VStack {
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                        .foregroundColor(.block)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                Text("1")
                    .customFont(fontSize: 14, weight: .regular, foreground: .block)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                Button {
                                    
                                } label: {
                                    Image(systemName: "minus")
                                        .foregroundColor(.block)

                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)

            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.accent)
        }, trailingActions: { ta in
            VStack {
                Button(action: {}) {
                    Image("basket")
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.customRed)
        })
        .swipeActionCornerRadius(8)
        .swipeActionsMaskCornerRadius(8)
        .swipeActionWidth(65)
        .swipeSpacing(10)
        .cornerRadius(8)
    }
}

#Preview {
    ProductInBasketView(model: MainViewModel(), sneaker: Sneaker(id: "qweqwe", name: "Nike Air Max", price: 9123.123123, category: 1, description: "QWE QWEQWE  QWE QWE ", bestseller: true, fullname: "Nie Air Max 270", imageULR: URL(string: "https://dnhbfwerqzathenuvacj.supabase.co/storage/v1/object/public/assets//631b7043-e9f1-4c42-a8a1-8a2e55ec6b48.png")))
        .padding(.horizontal, 20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.disable)
}
