//
//  PopularView.swift
//  Matule
//
//  Created by Михайлов Евгений on 19.02.2025.
//  Экран Popular 

import SwiftUI

struct PopularView: View {
    @StateObject var model: MainViewModel
    @Environment(\.presentationMode) var pm
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Button(action: {pm.wrappedValue.dismiss()}) {
                        ZStack {
                            Circle()
                                .foregroundColor(Color.block)
                            Image("arrow.left")
                        }
                    }
                    Spacer()
                    Text("Популярное")
                    Spacer()
                    NavigationLink(destination: FavoritesView(model: model)
                        .navigationBarBackButtonHidden()) {
                        ZStack {
                            Circle()
                                .foregroundColor(Color.block)
                            Image("heart.unfill.big")
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 44)

                .padding(.horizontal, 20)
                .padding(.top, 48)
                LazyVGrid(columns: [GridItem(.flexible(minimum: 150, maximum: UIScreen.main.bounds.width/2), spacing: 15), GridItem(.flexible(minimum: 150, maximum: UIScreen.main.bounds.width/2), spacing: 15)], spacing: 15) {
                                    ForEach(model.sneakers.indices, id: \.self) { index in
                                        if model.sneakers[index].bestseller {
                                            ProductView(model: model, sneaker: model.sneakers[index])

                                        }
                                    }
                                }
                                .padding(20)
            }
        }
        .ignoresSafeArea(.all)
        .background(Color.background)
        
    }
}

#Preview {
    PopularView(model: MainViewModel())
}
