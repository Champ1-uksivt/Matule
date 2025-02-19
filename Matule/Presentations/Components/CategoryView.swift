//
//  CategoryView.swift
//  Matule
//
//  Created by Евгений Михайлов on 19.02.2025.
//  Отображение категорий. Вынес в отдельный файл так как переиспользуется

import SwiftUI

struct CategoryView: View {
    @StateObject var model: MainViewModel
    var body: some View {
        VStack(spacing: 16) {
            Text("Категории")
                .customFont(fontSize: 16, weight: .regular, foreground: .text)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 20)
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    Spacer()
                        .frame(width: 4)
                    ForEach(model.categories.indices, id: \.self) { index in
                        Button(action: {
                            model.selectedCategory = index
                        }) {
                            Text(model.categories[index].locizedname)
                                .offset(y: -2)
                                .customFont(fontSize: 12, weight: .regular, foreground: model.selectedCategory == index ? .block : .text)
                                .frame(minWidth: 108, minHeight: 40)
                                .background(model.selectedCategory == index ? .accent : .block)
                                .cornerRadius(8)
                        }
                    }
                    Spacer()
                        .frame(width: 4)
                }
            }
            .scrollIndicators(.never)
        }
    }
}

#Preview {
    CategoryView(model: MainViewModel())
}
