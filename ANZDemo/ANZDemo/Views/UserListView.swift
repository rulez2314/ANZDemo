//
//  UserListView.swift
//  ANZDemo
//
//  Created by Arunesh Rathore on 29/07/25.
//


import SwiftUI

struct UserListView: View {
    @StateObject private var viewModel = UserListViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                if viewModel.isLoading {
                    ProgressView("Loading users...")
                        .progressViewStyle(CircularProgressViewStyle())
                } else {
                    List(viewModel.filteredUsers) { user in
                        NavigationLink(destination: UserDetailView(user: user)) {
                            UserRowView(user: user)
                        }
                    }
                    .refreshable {
                        viewModel.loadUsers()
                    }
                }
            }
            .navigationTitle("Users")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Refresh") {
                        viewModel.loadUsers()
                    }
                }
            }
            .searchable(text: $viewModel.searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search users")
            .onAppear {
                if viewModel.users.isEmpty {
                    viewModel.loadUsers()
                }
            }
            .alert("Error", isPresented: $viewModel.showError) {
                Button("OK") { }
                Button("Retry") {
                    viewModel.loadUsers()
                }
            } message: {
                Text(viewModel.errorMessage ?? "Unknown error occurred")
            }
        }
    }
}
