//
//  NetworkMonitor.swift
//  Matule
//
//  Created by Евгений Михайлов on 19.02.2025.
//  Класс для трекинга подклбчения к сети

import Foundation
import Network


final class NetworkMonitor : ObservableObject {
    @Published var isConnected = false
    static let shared = NetworkMonitor()
    private init() {
        let nw = NWPathMonitor()
        let queue = DispatchQueue(label: "networkMonitorQueue")
        nw.start(queue: queue)
        nw.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status != .satisfied
        }
    }
}
