//
//  NotificationModel.swift
//  Matule
//
//  Created by Михайлов Егвений on 21.02.2025.
//  Моделька для декодирования уведомлений

import Foundation


struct NotificationModel: Codable, Identifiable {
    let id: Int
    let header: String
    let body: String
    let created_at: Date
}
