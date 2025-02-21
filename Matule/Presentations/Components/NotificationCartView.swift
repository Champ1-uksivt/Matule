//
//  NotificationCartView.swift
//  Matule
//
//  Created by Михайлов Евгений on 21.02.2025.
//  Карточка для уведомления отедльый UI для переимпользования

import SwiftUI

struct NotificationCartView: View {
    var notification: NotificationModel
    var body: some View {
        VStack(alignment: .leading) {
            Text(notification.header)
                .customFont(fontSize: 16, weight: .regular, foreground: .text)
                .padding(.bottom, 8)
            Text(notification.body)
                .customFont(fontSize: 12, weight: .regular, foreground: .text)
                .padding(.bottom, 16)
                .multilineTextAlignment(.leading)
            Text(notification.created_at.description)
                .customFont(fontSize: 12, weight: .regular, foreground: .subTextDark)
        }
        .frame(maxWidth: .infinity)

        .padding(16)
        .background(Color.background)
        .cornerRadius(16)
        
    }
}

#Preview {
    NotificationCartView(notification: NotificationModel(id: 1, header: "Заголовок", body: "йцу й цу йц у йц уц у  уцпукпыап ва пвапвар вапрвапрвапр вапрвапрвапрва првапрвапр вапрвапрвапрвапрва првапрва пр вапр", created_at: Date()))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.disable)
}
