//
//  UserListsViewModelTests.swift
//  ANZDemo
//
//  Created by Arunesh Rathore on 29/07/25.
//

import XCTest
import Combine
@testable import ANZDemo

@MainActor
final class UserListViewModelTests: XCTestCase {
    var sut: UserListViewModel!
    var mockUserService: MockUserService!
    
    override func setUp() {
        super.setUp()
        mockUserService = MockUserService()
        sut = UserListViewModel(userService: mockUserService)
    }
    
    override func tearDown() {
        sut = nil
        mockUserService = nil
        super.tearDown()
    }
    
    func testLoadUsersSuccess() async {
        // Given
        let expectedUsers = [User(
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
        )]
        mockUserService.mockUsers = expectedUsers
        
        // When
        sut.loadUsers()
        
        // Wait for async operation
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        // Then
        XCTAssertEqual(sut.users, expectedUsers)
        XCTAssertFalse(sut.isLoading)
        XCTAssertFalse(sut.showError)
        XCTAssertTrue(mockUserService.fetchUsersCalled)
    }
    
    func testLoadUsersFailure() async {
        // Given
        mockUserService.shouldThrowError = true
        
        // When
        sut.loadUsers()
        
        // Wait for async operation
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        // Then
        XCTAssertTrue(sut.users.isEmpty)
        XCTAssertFalse(sut.isLoading)
        XCTAssertTrue(sut.showError)
        XCTAssertNotNil(sut.errorMessage)
    }
}
