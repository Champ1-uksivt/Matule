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
}
