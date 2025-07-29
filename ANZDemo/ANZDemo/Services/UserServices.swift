//
//  UserServices.swift
//  ANZDemo
//
//  Created by Arunesh Rathore on 29/07/25.
//

import Foundation
import Combine

protocol UserServiceProtocol {
    func fetchUsers() async throws -> [User]
    func fetchUsersPublisher() -> AnyPublisher<[User], NetworkError>
}

final class UserService: UserServiceProtocol {
    private let networkService: NetworkServiceProtocol
    private let baseURL = "https://fake-json-api.mock.beeceptor.com/users"
    
    init(networkService: NetworkServiceProtocol = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchUsers() async throws -> [User] {
        guard let url = URL(string: baseURL) else {
            throw NetworkError.invalidURL
        }
        
        return try await networkService.request(url: url, type: [User].self)
    }
    
    func fetchUsersPublisher() -> AnyPublisher<[User], NetworkError> {
        guard let url = URL(string: baseURL) else {
            return Fail(error: NetworkError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        return networkService.requestPublisher(url: url, type: [User].self)
    }
}
