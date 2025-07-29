//
//  UserDetailViewModelTests.swift
//  ANZDemo
//
//  Created by Arunesh Rathore on 29/07/25.
//

import XCTest
@testable import ANZDemo

@MainActor
final class UserDetailViewModelTests: XCTestCase {
    var sut: UserDetailViewModel!
    var testUser: User!
    
    override func setUp() {
        super.setUp()
        testUser = User(
            id: 1,
            name: "Test User",
            company: "Test Company",
            username: "testuser",
            email: "test@example.com",
            address: "123 Test St",
            zip: "12345",
            state: "Test State",
            country: "Test Country",
            phone: "123-456-7890",
            photo: "https://example.com/photo.jpg"
        )
        sut = UserDetailViewModel(user: testUser)
    }
    
    override func tearDown() {
        sut = nil
        testUser = nil
        super.tearDown()
    }
    
    func testFullAddressWithCompleteAddress() {
        // When
        let fullAddress = sut.fullAddress
        
        // Then
        XCTAssertEqual(fullAddress, "123 Test St, Test State, 12345, Test Country")
    }
    
    func testFullAddressWithEmptyValues() {
        // Given
        let userWithEmptyAddress = User(
            id: 1,
            name: "Test",
            company: "Test Company",
            username: "test",
            email: "test@example.com",
            address: "",
            zip: "",
            state: "",
            country: "",
            phone: "123-456-7890",
            photo: "https://example.com/photo.jpg"
        )
        sut = UserDetailViewModel(user: userWithEmptyAddress)
        
        // When
        let fullAddress = sut.fullAddress
        
        // Then
        XCTAssertEqual(fullAddress, "No address available")
    }
    
    func testCompanyInfoWithCompany() {
        // When
        let companyInfo = sut.companyInfo
        
        // Then
        XCTAssertEqual(companyInfo, "Test Company")
    }
    
    func testCompanyInfoWithEmptyCompany() {
        // Given
        let userWithEmptyCompany = User(
            id: 1,
            name: "Test",
            company: "",
            username: "test",
            email: "test@example.com",
            address: "123 Test St",
            zip: "12345",
            state: "Test State",
            country: "Test Country",
            phone: "123-456-7890",
            photo: "https://example.com/photo.jpg"
        )
        sut = UserDetailViewModel(user: userWithEmptyCompany)
        
        // When
        let companyInfo = sut.companyInfo
        
        // Then
        XCTAssertEqual(companyInfo, "No company information")
    }
}
