//
//  MockNetworkService.swift
//  ANZDemo
//
//  Created by Arunesh Rathore on 29/07/25.
//

import Foundation
import Combine
@testable import ANZDemo

final class MockNetworkService: NetworkServiceProtocol {
    var requestCalled = false
    var mockResult: Result<Any, NetworkError> = .failure(.noData)
    var mockPublisherResult: Result<Any, NetworkError> = .failure(.noData)
    
    func request<T: Decodable>(url: URL, type: T.Type) async throws -> T {
        requestCalled = true
        
        switch mockResult {
        case .success(let data):
            guard let typedData = data as? T else {
                throw NetworkError.decodingError
            }
            return typedData
        case .failure(let error):
            throw error
        }
    }
    
    func requestPublisher<T: Decodable>(url: URL, type: T.Type) -> AnyPublisher<T, NetworkError> {
        switch mockPublisherResult {
        case .success(let data):
            guard let typedData = data as? T else {
                return Fail(error: NetworkError.decodingError)
                    .eraseToAnyPublisher()
            }
            return Just(typedData)
                .setFailureType(to: NetworkError.self)
                .eraseToAnyPublisher()
        case .failure(let error):
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
    }
}
