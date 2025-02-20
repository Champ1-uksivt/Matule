//
//  FavoritesView.swift
//  Matule
//
//  Created by Михайлов Евгений on 19.02.2025.
//  Представление избранного

import SwiftUI

struct FavoritesView: View {
    @Environment(\.presentationMode) var pm
    @StateObject var model: MainViewModel
    var body: some View {
        VStack {
            HStack {
                Button {
                    if model.navigationStack.last != .favorites {
                        pm.wrappedValue.dismiss()
                    }
                    else {
                        model.navigationStack.dropLast()
                    }
                } label: {
                    ZStack {
                        Circle()
                            .foregroundColor(Color.block)
                        Image("arrow.left")
                        
                    }
                }
                Spacer()
                Text("Sneaker Shop")
                    .customFont(fontSize: 16, weight: .regular, foreground: .text)
                Spacer()
                Button(action: {
                    print("cart")
                }) {
                    ZStack {
                        Circle()
                            .foregroundColor(Color.block)
                        Image("heart.fill.big")
                        
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 44)
            .padding(.horizontal, 20)
            ScrollView {
                LazyVGrid(columns: [GridItem(.flexible(minimum: 150, maximum: UIScreen.main.bounds.width/2), spacing: 15), GridItem(.flexible(minimum: 150, maximum: UIScreen.main.bounds.width/2), spacing: 15)], spacing: 15) {
                    ForEach(model.favorites.indices, id: \.self) { index in
                        ProductView(model: model, sneaker: model.sneakers[index])
                    }
                }
                .padding(.horizontal, 20)
                
            }
        }
        .padding(.top, 48)
        .background(Color.background)
    }
}

#Preview {
    FavoritesView(model: MainViewModel())
}
