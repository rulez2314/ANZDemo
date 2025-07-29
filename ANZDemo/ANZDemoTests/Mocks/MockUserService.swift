//
//  MockUserService.swift
//  ANZDemo
//
//  Created by Arunesh Rathore on 29/07/25.
//

import Foundation
import Combine
@testable import ANZDemo

final class MockUserService: UserServiceProtocol {
    var fetchUsersCalled = false
    var shouldThrowError = false
    var mockUsers: [User] = []
    
    func fetchUsers() async throws -> [User] {
        fetchUsersCalled = true
        
        if shouldThrowError {
            throw NetworkError.noData
        }
        
        return mockUsers
    }
    
    func fetchUsersPublisher() -> AnyPublisher<[User], NetworkError> {
        if shouldThrowError {
            return Fail(error: NetworkError.noData)
                .eraseToAnyPublisher()
        }
        
        return Just(mockUsers)
            .setFailureType(to: NetworkError.self)
            .eraseToAnyPublisher()
    }
}
