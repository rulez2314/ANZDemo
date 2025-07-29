//
//  DependencyContainer.swift
//  ANZDemo
//
//  Created by Arunesh Rathore on 29/07/25.
//

import Foundation

protocol DependencyContainerProtocol {
    var userService: UserServiceProtocol { get }
}

final class DependencyContainer: DependencyContainerProtocol {
    lazy var userService: UserServiceProtocol = UserService(networkService: networkService)
    
    private lazy var networkService: NetworkServiceProtocol = NetworkService()
    
    static let shared = DependencyContainer()
    
    private init() {}
}
