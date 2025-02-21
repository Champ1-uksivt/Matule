//
//  MainView.swift
//  Matule
//
//  Created by Евгений Михайлов on 19.02.2025.
//  Главная страница

import SwiftUI

struct MainView: View {
    @StateObject var model = MainViewModel()
    var body: some View {
        ZStack {
            SideMenuView(model: model)
            ZStack(alignment: .bottom) {
                getCurrentView()
                navigationBar
            }
            .disabled(model.showSideMenu)
            .cornerRadius(40)
            .offset(x: model.showSideMenu ? 290 : 0)
            .scaleEffect(model.showSideMenu ? 0.8 : 1)
            .rotationEffect(.degrees(model.showSideMenu ? -3.43 : 0))
            .ignoresSafeArea(.all)
            .shadow(color: .black.opacity(0.2), radius: 10)
            .onTapGesture {
                if model.showSideMenu {
                    model.showSideMenu = false
                }
            }
            .animation(.spring(duration: 1), value: model.showSideMenu)
        }
        .ignoresSafeArea(.all)

        
    }
    var navigationBar: some View {
        ZStack {
            Image("navbar")
                .resizable()
                .scaledToFit()
                .shadow(color: .subTextLight.opacity(0.8), radius: 3, y: -3)

            HStack {
                Button {
                    model.navigationStack.append(.home)
                } label: {
                    Image(model.navigationStack.last == .home ? "home.select" : "home.unselect")
                        .resizable()
                        .scaledToFit()
                }
                .frame(maxWidth: 24, maxHeight: 24)
                Spacer()
                Button {
                    model.navigationStack.append(.favorites)

                } label: {
                    Image(model.navigationStack.last == .favorites ? "favorites.select" : "favorites.unselect")
                }
                Spacer()
                NavigationLink(destination: CartView(model: model).navigationBarBackButtonHidden()) {
                    ZStack {
                        Circle()
                            .foregroundColor(Color.accent)
                        Image("bag.white")
                    }
                }
                .frame(maxWidth: 56, maxHeight: 56)
                .offset(y: -40)
                .shadow(color: .accent.opacity(0.6), radius: 12, y: 7)
                Spacer()
                Button {
                    model.navigationStack.append(.notifications)
                } label: {
                    Image(model.navigationStack.last == .notifications ? "notifications.select" : "notifications.unselect")
                }
                Spacer()
                Button {
                    model.navigationStack.append(.profile)

                } label: {
                    Image(model.navigationStack.last == .profile ? "profile.select" : "profile.unselect")
                }
                
            }
            .padding(.horizontal, 31)
            .offset(y: 15)
            .alert("Ошибка сети", isPresented: $model.isConnected) {
                Button {
                    model.loadData()
                } label: {
                    Text("Попробовать снова")
                }

            } message: {
                Text("Проверьте подключение к интернету")
            }
            .onLoadingProccess(isLoading: model.isLoadingProccess)

        }
    }
    @ViewBuilder
    func getCurrentView() -> some View {
        let currentView = model.navigationStack.last ?? .home
        switch currentView {
        case .home: HomeView(model: model)
        case .favorites: FavoritesView(model: model)
        case .notifications: NotificationView(model: model)
        case .profile: ProfileView(model: model)
        }
    }
}

#Preview {
    NavigationStack {
        MainView()
    }
}
