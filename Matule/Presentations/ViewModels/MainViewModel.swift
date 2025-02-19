//
//  MainViewModel.swift
//  Matule
//
//  Created by uksivt on 19.02.2025.
//  Основной класс для обновления интерфейса и получения данных

import Foundation
import Combine

@MainActor
final class MainViewModel : ObservableObject {
    @Published var isLoading = false
    @Published var isConnected = false
    @Published var isLoadingProccess = false
    @Published var sneakers: [Sneaker] = []
    @Published var categories: [Category] = []
    @Published var ads: [Ad] = []
    @Published var navigationStack: [Tabs] = [.home]
    @Published var selectedCategory = -1 {
        didSet {
            categoryIsSelected = selectedCategory != -1
        }
    }
    @Published var categoryIsSelected = false
    var canc: Set<AnyCancellable> = []
    init() {
        loadData()
    }
    func loadData() {
        let nw = NetworkMonitor.shared
        nw.$isConnected.receive(on: DispatchQueue.main).sink { [weak self] isConnected in
            if isConnected {
                self?.isConnected = isConnected
            }
        }
        .store(in: &canc)
        fetchCategories()
        fetchSneakers()
        fetchAds()
    }
    func fetchCategories() {
        Task {
            isLoading = true
            do {
                categories = try await SupabaseService.shared.fetchCategory()
                categories.insert(Category(id: 0, name: "Все"), at: 0)
            }
            catch {
                print(error.localizedDescription)
            }
            isLoading = false
        }
    }
    func fetchSneakers() {
        Task {
            isLoading = true
            do {
                sneakers = try await SupabaseService.shared.fetchSneakers()
            }
            catch {
                print(error.localizedDescription)
            }
            isLoading = false
        }
    }
    
    func fetchAds() {
        Task {
            isLoading = true
            do {
                ads = try await SupabaseService.shared.fetchAds()
            }
            catch {
                print(error.localizedDescription)
            }
            isLoading = false
        }
    }
}
