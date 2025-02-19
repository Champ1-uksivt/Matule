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
        ZStack(alignment: .bottom) {
            getCurrentView()
            navigationBar
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
                    
                } label: {
                    Image("home.select")
                        .resizable()
                        .scaledToFit()
                }
                .frame(maxWidth: 24, maxHeight: 24)
                Spacer()
                Button {
                    
                } label: {
                    Image("favorites.unselect")
                }
                Spacer()
                Button {
                    
                } label: {
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
                    
                } label: {
                    Image("notifications.unselect")
                }
                Spacer()
                Button {
                    
                } label: {
                    Image("profile.unselect")
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

        }
    }
    @ViewBuilder
    func getCurrentView() -> some View {
        let currentView = model.navigationStack.last ?? .home
        switch currentView {
        case .home: HomeView(model: model)
        case .favorites: EmptyView()
        case .notifications: EmptyView()
        case .profile: EmptyView()
        }
    }
}

#Preview {
    NavigationStack {
        MainView()
    }
}
