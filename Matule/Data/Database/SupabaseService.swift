//
//  SupabaseService.swift
//  Matule
//
//  Created by uksivt on 19.02.2025.
//  Логика с базой данных

import Foundation
import Supabase


final class SupabaseService {
    private let supabase = SupabaseClient(supabaseURL: URL(string: "https://dnhbfwerqzathenuvacj.supabase.co")!, supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRuaGJmd2VycXphdGhlbnV2YWNqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Mzk2MDcyODcsImV4cCI6MjA1NTE4MzI4N30.J3XNF9wjFWVI305v2jep7bRV9DC7g1GDyeca3_9H-6M")
    private init() {}
    static let shared = SupabaseService()
    func login(email: String, password: String) async throws {
        try await supabase.auth.signIn(email: email, password: password)
    }
    
    
    func fetchCategory() async throws -> [Category]{
        try await supabase.from("categories").select().execute().value
    }
    func fetchSneakers() async throws -> [Sneaker] {
        var sneakers: [Sneaker] = try await supabase.from("sneakers").select().execute().value
        for i in sneakers.indices {
            sneakers[i].imageULR = try await fetchImage(id: sneakers[i].id)
            sneakers[i].countInBasket = 1
        }
        return sneakers
        
    }
    func fetchImage(id: String, storage: String = "assets") async throws -> URL{
        try supabase.storage.from(storage).getPublicURL(path: "\(id).png", download: false)
    }
    func fetchAds() async throws -> [Ad] {
        var ads: [Ad] = try await supabase.from("ads").select().execute().value
        for i in ads.indices {
            ads[i].imageURL = try await fetchImage(id: ads[i].id, storage: "ads")
        }
        return ads
    }
    
    func fetchFavorites(user: String) async throws -> [Sneaker] {
        let response: [FavoriteResponse] = try await supabase.from("favorites").select().execute().value
        
        var favorites: [Sneaker] = []
        
        for i in response.indices {
            var sneakers: [Sneaker] = try await supabase.from("sneakers").select().eq("id", value: response[i].sneaker).execute().value
            favorites.append(sneakers.first!)
        }
        for i in favorites.indices {
            favorites[i].imageULR = try await fetchImage(id: favorites[i].id)
        }
        return favorites
    }
    func fetchCart(user: String) async throws -> [Sneaker] {
        let response: [CartResponse] = try await supabase.from("cart").select().execute().value
        
        var cart: [Sneaker] = []
        
        for i in response.indices {
            var sneakers: [Sneaker] = try await supabase.from("sneakers").select().eq("id", value: response[i].sneaker).execute().value
            var sneak = sneakers.first!
            sneak.countInBasket = response[i].count
            cart.append(sneak)
        }
        for i in cart.indices {
            cart[i].imageULR = try await fetchImage(id: cart[i].id)
        }
        return cart
    }
    func updateCountInCart(user: String, sneaker: String, value: Int = 1) async throws {
        let response: [CartResponse] = try await supabase.from("cart").select().eq("user", value: user).eq("sneaker", value: sneaker).execute().value
        if response != nil {
            try await supabase.from("cart").update(["id" : (response.count).description, "sneaker" : sneaker, "count" : "\(response.first!.count+value)", "user" : user]).eq("user", value: user).eq("sneaker", value: sneaker).execute()
        }
    }
    
    func addCart(user: String, sneaker: String) async throws {
        let response: [CartResponse] = try await supabase.from("cart").select().execute().value
        try await supabase.from("cart").insert(["id" : (response.count + 1).description, "sneaker" : sneaker, "count" : "1", "user" : user]).execute()
    }
    func deleteFromCart(user: String, sneaker: String) async throws {
        try await supabase.from("cart").delete().eq("user", value: user).eq("sneaker", value: sneaker).execute()

    }
    func fetchUser() async throws -> User {
        try await supabase.auth.session.user
    }
    
    func addToFavorite(sneaker: String, user: String) async throws {
        let response: [FavoriteResponse] = try await supabase.from("favorites").select().execute().value

        try await supabase.from("favorites").insert(["id" : (response.count + 1).description, "sneaker" : sneaker, "user" : user]).execute()
    }
    func deleteFromFavorite(sneaker: String, user: String) async throws {
        try await supabase.from("favorites").delete().eq("user", value: user).eq("sneaker", value: sneaker).execute()
    }
    
    func signUp(email: String, password: String, name: String) async throws {
        try await supabase.auth.signUp(email: email, password: password)
        try await supabase.auth.update(user: UserAttributes(data: ["name" : AnyJSON(name)]))
    }
    
    func clear() async throws {
        try await supabase.auth.signOut()
    }
    func sendCodeToEmail(for email: String) async throws {
        try await supabase.auth.resetPasswordForEmail(email)
    }
    
    func verifyCode(code: String, email: String) async throws {
        try await supabase.auth.verifyOTP(email: email, token: code, type: .recovery)
    }
    
    func updatePassword(password: String) async throws {
        try await supabase.auth.update(user: UserAttributes(password: password))
    }
 }
