//
//  MatuleTests.swift
//  MatuleTests
//
//  Created by Михайлов Евгений on 18.02.2025.
//  Модульные тесты

import Testing
import XCTest
@testable import Matule

struct MatuleTests {
    
    @Test func testValidateCorrectEmail() async throws {
        let emails = ["qwe@qwe.qwe", "e.mikhaylov2006@gmail.com", "qwe-qwe@qwe.qwe"]
        for i in emails {
            XCTAssertTrue(i.validateEmail())
        }
    }
    @Test func testValidateIncorrectEmail() async throws {
        let emails = ["qwe@qwe.", "e.mikhaylov2006gmail.com", "qwe-qwe@.qwe"]
        for i in emails {
            XCTAssertFalse(i.validateEmail())
        }
    }
    
    @Test func testValidateCorrectPassword() async throws {
        let passwords = ["qweQWE123", "qW123e", "123qWE"]
        for i in passwords {
            XCTAssertTrue(i.validatePassword())
        }
    }
    
    @Test func testValidateIncorrectPassword() async throws {
            let passwords = ["qweQWE", "qW123", "123WE"]
            for i in passwords {
                XCTAssertFalse(i.validatePassword())
            }
        }
    
}
