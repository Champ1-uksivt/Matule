//
//  MainViewModel.swift
//  Matule
//
//  Created by uksivt on 19.02.2025.
//  Основной класс для обновления интерфейса и получения данных

import Foundation
import Combine
import Auth

@MainActor
final class MainViewModel : ObservableObject {
    
    @Published var cart = [Sneaker]() {
        didSet {
            costCart = cart.reduce(0) {$0 + $1.price * Double($1.countInBasket ?? Int(1.0))}
            costDelivery = Double(cart.reduce(0) {$0 + ($1.countInBasket ?? 1) * 10})
        }
    }
    @Published var favorites = [Sneaker]()
    
    @Published var isLoading = false
    @Published var isConnected = false
    @Published var showSideMenu = false
    @Published var isLoadingProccess = false
    @Published var sneakers: [Sneaker] = []
    @Published var categories: [Category] = []
    @Published var address = ""
    @Published var ads: [Ad] = []
    @Published var navigationStack: [Tabs] = [.home]
    @Published var selectedCategory = -1 {
        didSet {
            categoryIsSelected = selectedCategory != -1
        }
    }
    @Published var categoryIsSelected = false
    @Published var selectedSneaker: Int? = 1
    @Published var costCart = 0.0
    @Published var costDelivery = 0.0
    @Published var user: User?
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
        fetchUser()
        
    }
    
    func fetchCart() {
        Task {
            do {
                cart = try await SupabaseService.shared.fetchCart(user: user!.id.uuidString)
                
            }
            catch {
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchUser() {
        Task {
            do {
                user = try await SupabaseService.shared.fetchUser()
                if user != nil {
                    favorites = try await SupabaseService.shared.fetchFavorites(user: user!.id.uuidString)
                    cart = try await SupabaseService.shared.fetchCart(user: user!.id.uuidString)
                }
                
            }
            catch {
                print(error.localizedDescription)
            }
        }
        if user != nil {
            fetchCart()
        }
        
    }
    
    func updateCart(sneaker: Sneaker, value: Int = 1) {
        if user == nil {
            if cart.contains(where: {$0.id == sneaker.id}) {
                cart[cart.firstIndex(where: {$0.id == sneaker.id})!].countInBasket? += 1
            }
            else {
                cart = cart + [sneaker]
            }
        }
        else {
            Task {
                isLoadingProccess = true

                do {
                    if cart.contains(where: {$0.id == sneaker.id}) {
                        if value == -1 && sneaker.countInBasket == 1 {
                            return
                        }
                        try await SupabaseService.shared.updateCountInCart(user: user!.id.uuidString, sneaker: sneaker.id, value: value)
                    }
                    else {
                        try await SupabaseService.shared.addCart(user: user!.id.uuidString, sneaker: sneaker.id)
                    }
                    cart = try await SupabaseService.shared.fetchCart(user: user!.id.uuidString)
                }
                catch {
                    print(error.localizedDescription)
                }
                isLoadingProccess = false

                
            }
        }
        
    }
    func deleteFromCart(sneaker: Sneaker) {
        if user == nil {
            cart.remove(at: cart.firstIndex(where: {$0.id == sneaker.id})!)
        }
        else {
            isLoadingProccess = true
            Task {
                do {
                    try await SupabaseService.shared.deleteFromCart(user: user!.id.uuidString, sneaker: sneaker.id)
                    cart = try await SupabaseService.shared.fetchCart(user: user!.id.uuidString)
                }
                catch {
                    print(error.localizedDescription)
                }
            }
            isLoadingProccess = false
        }
    }
    
    func addToFavorite(sneaker: Sneaker) {
        if user != nil {
            Task {
                isLoadingProccess = true

                do{
                    try await SupabaseService.shared.addToFavorite(sneaker: sneaker.id, user: user!.id.uuidString)
                    favorites = try await SupabaseService.shared.fetchFavorites(user: user!.id.uuidString)
                }
                catch {
                    print(error.localizedDescription)
                }
                isLoadingProccess = false

            }
        }
        else {
            favorites.append(sneaker)
        }
    }
    
    func deleteFromFavorite(sneaker: Sneaker) {
        if user != nil {
            Task {
                isLoadingProccess = true
                do{
                    try await SupabaseService.shared.deleteFromFavorite(sneaker: sneaker.id, user: user!.id.uuidString)
                    favorites = try await SupabaseService.shared.fetchFavorites(user: user!.id.uuidString)
                }
                catch {
                    print(error.localizedDescription)
                }
                isLoadingProccess = false

            }
        }
        else {
            favorites.remove(at: favorites.firstIndex(where: {$0.id == sneaker.id})!)
        }
    }
    
    
    
    func saveCart() {
//        Task {
//            do {
//                if user == nil {
//                    if let data = try JSONEncoder().encode(cart) {
//                        
//                    }
//                }
//               
//            }
//            catch {
//                print(error.localizedDescription)
//            }
//        }
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
