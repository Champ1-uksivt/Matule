//
//  ProductFromCategoryView.swift
//  Matule
//
//  Created by Евгений Михайлов on 19.02.2025.
//  Представление для отображение товаров по категориям
//

import SwiftUI

struct ProductFromCategoryView: View {
    @Environment(\.presentationMode) var pm
    @StateObject var model :MainViewModel
    var body: some View {
        ScrollView {
            VStack {
                ForEach(model.categories.indices, id: \.self) { index in
                    if index == model.selectedCategory {
                        Text(model.categories[index].locizedname)
                            .customFont(fontSize: 16, weight: .regular, foreground: .text)
                            .frame(maxWidth: .infinity)
                            .overlay {
                                Button {
                                    pm.wrappedValue.dismiss()
                                } label: {
                                    Image("arrow.left")
                                        .padding(.horizontal, 10)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                
                            }
                            .padding(.horizontal, 20)
                    }
                }
                CategoryView(model: model)
                    .padding(.top, 16)
                    .padding(.bottom, 20)
                LazyVGrid(columns: [GridItem(.flexible(minimum: 150, maximum: UIScreen.main.bounds.width/2), spacing: 15), GridItem(.flexible(minimum: 150, maximum: UIScreen.main.bounds.width/2), spacing: 15)], spacing: 15) {
                    ForEach(model.sneakers.indices, id: \.self) { index in
                        if model.sneakers[index].category == model.selectedCategory {
                            ProductView(model: model, sneaker: model.sneakers[index])
                        }
                        else if model.selectedCategory == 0 {
                            ProductView(model: model, sneaker: model.sneakers[index])

                        }
                    }
                }
                .padding(.horizontal, 20)
                
            }
        }
        .background(Color.background)
        .onDisappear {
            model.selectedCategory = -1
        }
    }
}

#Preview {
    ProductFromCategoryView(model: MainViewModel())
}
