//
//  NetworkService.swift
//  ANZDemo
//
//  Created by Arunesh Rathore on 29/07/25.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func request<T: Decodable>(url: URL, type: T.Type) async throws -> T
    func requestPublisher<T: Decodable>(url: URL, type: T.Type) -> AnyPublisher<T, NetworkError>
}

final class NetworkService: NetworkServiceProtocol {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(url: URL, type: T.Type) async throws -> T {
        do {
            let (data, _) = try await session.data(from: url)
            let decoder = JSONDecoder()
            return try decoder.decode(type, from: data)
        } catch let decodingError as DecodingError {
            throw NetworkError.decodingError
        } catch {
            throw NetworkError.networkError(error)
        }
    }
    
    func requestPublisher<T: Decodable>(url: URL, type: T.Type) -> AnyPublisher<T, NetworkError> {
        session.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError { error in
                if error is DecodingError {
                    return NetworkError.decodingError
                }
                return NetworkError.networkError(error)
            }
            .eraseToAnyPublisher()
    }
}
