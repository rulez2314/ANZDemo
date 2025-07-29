//
//  UserListViewModel.swift
//  ANZDemo
//
//  Created by Arunesh Rathore on 29/07/25.
//

import Foundation
import Combine
import SwiftUI

@MainActor
final class UserListViewModel: ObservableObject {
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var showError = false
    @Published var searchText: String = ""
    var filteredUsers: [User] {
        guard !searchText.isEmpty else {
            return users
        }
        return users.filter {
            $0.name.localizedCaseInsensitiveContains(searchText) ||
            $0.username.localizedCaseInsensitiveContains(searchText) ||
            $0.email.localizedCaseInsensitiveContains(searchText) ||
            $0.company.localizedCaseInsensitiveContains(searchText)
        }
    }
    
    private let userService: UserServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    init(userService: UserServiceProtocol = DependencyContainer.shared.userService) {
        self.userService = userService
    }
    
    func loadUsers() {
        isLoading = true
        errorMessage = nil
        showError = false
        
        Task {
            do {
                let fetchedUsers = try await userService.fetchUsers()
                await MainActor.run {
                    self.users = fetchedUsers
                    self.isLoading = false
                }
            } catch {
                await MainActor.run {
                    self.errorMessage = error.localizedDescription
                    self.showError = true
                    self.isLoading = false
                }
            }
        }
    }
    
    func loadUsersWithCombine() {
        isLoading = true
        errorMessage = nil
        showError = false
        
        userService.fetchUsersPublisher()
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoading = false
                    if case .failure(let error) = completion {
                        self?.errorMessage = error.localizedDescription
                        self?.showError = true
                    }
                },
                receiveValue: { [weak self] users in
                    self?.users = users
                }
            )
            .store(in: &cancellables)
    }
}
