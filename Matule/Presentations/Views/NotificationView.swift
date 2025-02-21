//
//  NotificationView.swift
//  Matule
//
//  Created by Михайлов Евгений on 21.02.2025.
//  Отображение уведомлений

import SwiftUI

struct NotificationView: View {
    @StateObject var model: MainViewModel
    var body: some View {
        ScrollView {
            VStack {
                Text("Уведомления")
                    .customFont(fontSize: 16, weight: .regular, foreground: .text)
                    .frame(maxWidth: .infinity, maxHeight: 44)
                    .overlay {
                        Button(action: {
                            model.showSideMenu = true
                        }) {
                            Image("hamb")
                            
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding(.top, 56)
                    
                VStack(spacing: 12) {
                    ForEach(model.notifications.indices, id: \.self) { index in
                        NotificationCartView(notification: model.notifications[index])
                            .onLoadingProccess(isLoading: model.isLoadingProccess)
                    }
                }
                .padding(.vertical, 8)
            }
            .padding(.horizontal, 20)
        }
        .navigationBarBackButtonHidden()
        .ignoresSafeArea(.all)
        .background(Color.block)
    }
}

#Preview {
    NotificationView(model: MainViewModel())
}
