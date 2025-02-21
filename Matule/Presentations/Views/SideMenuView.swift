//
//  SideMenuView.swift
//  Matule
//
//  Created by uksivt on 21.02.2025.
//

import SwiftUI
import Kingfisher

struct SideMenuView: View {
    @StateObject var model: MainViewModel
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                KFImage(URL(string: "https://dnhbfwerqzathenuvacj.supabase.co/storage/v1/object/public/users//3756c392-43c8-4cc4-b74d-b01d52bc37fc.jpg"))
                    .placeholder({ progress in
                        ProgressView()
                    })
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 96)
                    .clipShape(Circle())
                    .padding(.top, 78)
                    .padding(.horizontal, 15)

                Text(model.user?.appMetadata["name"]?.stringValue ?? "Эмануэль Кверти")
                    .customFont(fontSize: 20, weight: .regular, foreground: .block)
                    .padding(.horizontal, 15)
                    .padding(.bottom,55)
                VStack(alignment: .leading, spacing: 30) {
                    NavigationLink(destination: EmptyView()) {
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
                    NavigationLink(destination: EmptyView()) {
                        HStack(spacing: 22) {
                            Image("delivary.white")
                            Text("Заказы")
                                .customFont(fontSize: 16, weight: .regular, foreground: .block)
                            
                        }
                    }
                    NavigationLink(destination: EmptyView()) {
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
                    
                    NavigationLink(destination: LoginView()) {
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
