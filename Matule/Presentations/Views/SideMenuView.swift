//
//  SideMenuView.swift
//  Matule
//
//  Created by Михайлов Евгений on 21.02.2025.
//  Боковое меню

import SwiftUI
import Kingfisher

struct SideMenuView: View {
    @StateObject var model: MainViewModel
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                Image("ava")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 96)
                    .clipShape(Circle())
                    .padding(.top, 78)
                    .padding(.horizontal, 15)

                Text("\(model.user?.userMetadata["name"]?.stringValue ?? "Эмануэль") \(model.user?.userMetadata["lastname"]?.stringValue ?? "Кверти")")
                    .customFont(fontSize: 20, weight: .regular, foreground: .block)
                    .padding(.horizontal, 15)
                    .padding(.bottom,55)
                VStack(alignment: .leading, spacing: 30) {
                    Button(action: {
                        model.showSideMenu = false
                        if model.navigationStack.last != .profile {
                            model.navigationStack.append(.profile)
                        }
                    }) {
                        HStack(spacing: 22) {
                            Image("profile.white")
                            Text("Профиль")
                                .customFont(fontSize: 16, weight: .regular, foreground: .block)
                            
                        }
                    }
                    NavigationLink(destination: CartView(model: model).navigationBarBackButtonHidden()) {
                        HStack(spacing: 22) {
                            Image("bag.white")
                            Text("Корзина")
                                .customFont(fontSize: 16, weight: .regular, foreground: .block)
                            
                        }
                    }
                    NavigationLink(destination: FavoritesView(model: model).navigationBarBackButtonHidden()) {
                        HStack(spacing: 22) {
                            Image("favorite.white")
                            Text("Избранное")
                                .customFont(fontSize: 16, weight: .regular, foreground: .block)
                            
                        }
                    }
                    NavigationLink(destination: OrdersView(model: model).navigationBarBackButtonHidden()) {
                        HStack(spacing: 22) {
                            Image("delivary.white")
                            Text("Заказы")
                                .customFont(fontSize: 16, weight: .regular, foreground: .block)
                            
                        }
                    }
                    Button(action: {
                        model.showSideMenu = false
                        if model.navigationStack.last != .notifications {
                            model.navigationStack.append(.notifications)
                        }
                    }) {
                        HStack(spacing: 22) {
                            Image("notifications.white")
                            Text("Уведомления")
                                .customFont(fontSize: 16, weight: .regular, foreground: .block)
                            
                        }
                    }
                    NavigationLink(destination: EmptyView()) {
                        HStack(spacing: 22) {
                            Image("settings.white")
                            Text("Настройки")
                                .customFont(fontSize: 16, weight: .regular, foreground: .block)
                        }
                    }
                    .padding(.bottom, 8)
                    Rectangle()
                        .frame(maxWidth: .infinity, maxHeight: 1.5)
                        .foregroundColor(Color.block.opacity(0.2))
                    
                    NavigationLink(destination: LoginView().navigationBarBackButtonHidden()) {
                        HStack(spacing: 22) {
                            Image("signout.white")
                            Text("Выйти")
                                .customFont(fontSize: 16, weight: .regular, foreground: .block)
                            
                        }
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 20)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .ignoresSafeArea(.all)
            .background(Color.accent)
        }
    }
}

#Preview {
    SideMenuView(model: MainViewModel())
}
