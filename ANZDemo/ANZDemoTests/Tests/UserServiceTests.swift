//
//  UserServiceTests.swift
//  ANZDemo
//
//  Created by Arunesh Rathore on 29/07/25.
//

import XCTest
import Combine
@testable import ANZDemo

final class UserServiceTests: XCTestCase {
    var sut: UserService!
    var mockNetworkService: MockNetworkService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        sut = UserService(networkService: mockNetworkService)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        sut = nil
        mockNetworkService = nil
        cancellables = nil
        super.tearDown()
    }
    
    func testFetchUsersSuccess() async throws {
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
        mockNetworkService.mockResult = .success(expectedUsers)
        
        // When
        let users = try await sut.fetchUsers()
        
        // Then
        XCTAssertEqual(users, expectedUsers)
        XCTAssertTrue(mockNetworkService.requestCalled)
    }
    
    func testFetchUsersFailure() async {
        // Given
        mockNetworkService.mockResult = .failure(NetworkError.noData)
        
        // When/Then
        do {
            _ = try await sut.fetchUsers()
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertTrue(error is NetworkError)
        }
    }
    
    func testFetchUsersPublisherSuccess() {
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
        mockNetworkService.mockPublisherResult = .success(expectedUsers)
        
        let expectation = expectation(description: "Users fetched")
        var receivedUsers: [User]?
        
        // When
        sut.fetchUsersPublisher()
            .sink(
                receiveCompletion: { completion in
                    if case .failure = completion {
                        XCTFail("Expected success")
                    }
                    expectation.fulfill()
                },
                receiveValue: { users in
                    receivedUsers = users
                }
            )
            .store(in: &cancellables)
        
        // Then
        waitForExpectations(timeout: 1.0)
        XCTAssertEqual(receivedUsers, expectedUsers)
    }
}
