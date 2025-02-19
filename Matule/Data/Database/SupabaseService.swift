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
}
