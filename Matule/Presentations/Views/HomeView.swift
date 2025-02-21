//
//  HomeView.swift
//  Matule
//
//  Created by Евгений Михайлов on 19.02.2025.
//  Домашная страница

import SwiftUI
import Kingfisher

struct HomeView: View {
    @StateObject var model: MainViewModel
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Button(action: {
                        print("side menu")
                        model.showSideMenu = true
                    }) {
                        Image("hamb")
                        
                    }
                    Spacer()
                    Text("Главная")
                        .customFont(fontSize: 32, weight: .regular, foreground: .text)
                        .overlay {
                            Image("tile")
                                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                                .offset(x: -14, y: -8)
                        }
                    Spacer()
                    Button(action: {
                        print("cart")
                    }) {
                        ZStack {
                            Circle()
                                .foregroundColor(Color.block)
                                .overlay {
                                    Circle()
                                        .frame(maxWidth: 8, maxHeight: 8)
                                        .foregroundColor(Color.customRed)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topTrailing)
                                        .offset(x: -3, y: 3)
                                }
                            Image("bag.black")
                            
                        }
                        
                    }
                    .frame(maxWidth: 44, minHeight: 44)
                }
                .padding(.horizontal, 20)
                .frame(maxWidth: .infinity, maxHeight: 44)
                .padding(.top, 48)
                HStack(spacing: 14) {
                    Button(action: {
                        print("search")
                    }) {
                        HStack(spacing: 12) {
                            Spacer()
                                .frame(width: 14)
                            Image("search")
                            Text("Поиск")
                                .customFont(fontSize: 12, weight: .regular, foreground: .hint)
                            Spacer()
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.block)
                    .cornerRadius(14)
                    Button(action: {}) {
                        ZStack {
                            Circle()
                                .foregroundColor(Color.accent)
                            Image("sliders")
                        }
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: 52)
                .padding(.horizontal, 20)
                .padding(.vertical, 20)
                .shadow(color: .subTextLight.opacity(0.5), radius: 3, y: 3)
                CategoryView(model: model)
                    .padding(.bottom, 24)
                    .onLoading(isLoading: model.isLoading)
                HStack {
                    Text("Популярное")
                        .customFont(fontSize: 16, weight: .regular, foreground: .text)
                    
                    Spacer()
                    NavigationLink(destination: PopularView(model: model).navigationBarBackButtonHidden()) {
                        Text("Все")
                            .customFont(fontSize: 12, weight: .regular, foreground: .accent)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 30)
                LazyVGrid(columns: [GridItem(.flexible(minimum: 150, maximum: UIScreen.main.bounds.width/2), spacing: 15), GridItem(.flexible(minimum: 150, maximum: UIScreen.main.bounds.width/2), spacing: 15)], spacing: 15) {
                    ForEach(model.sneakers.indices, id: \.self) { index in
                        if model.sneakers[index].bestseller {
                            ProductView(model: model, sneaker: model.sneakers[index])
                        }
                    }
                }
                .padding(.horizontal, 20)
                .onLoading(isLoading: model.isLoading)
                HStack {
                    Text("Акции")
                        .customFont(fontSize: 16, weight: .regular, foreground: .text)
                    
                    Spacer()
                    NavigationLink(destination: EmptyView()) {
                        Text("Все")
                            .customFont(fontSize: 12, weight: .regular, foreground: .accent)
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
                .padding(.top, 29)
                
                ForEach(model.ads.indices, id: \.self) { index in
                    if index == 0 {
                        KFImage(model.ads[index].imageURL)
                            .resizable()
                            .scaledToFit()
                            .padding(.horizontal, 20)
                            .onLoading(isLoading: model.isLoading)
                            

                    }
                }
                
            }

        }
        .background(Color.background)
        .ignoresSafeArea(.all)
        .navigationDestination(isPresented: $model.categoryIsSelected) {
            ProductFromCategoryView(model: model)
                .navigationBarBackButtonHidden()
        }


    }
}
#Preview {
    HomeView(model: MainViewModel())
}
