//
//  UserDetailView.swift
//  ANZDemo
//
//  Created by Arunesh Rathore on 29/07/25.
//

import SwiftUI

struct UserDetailView: View {
    @StateObject private var viewModel: UserDetailViewModel
    
    init(user: User) {
        self._viewModel = StateObject(wrappedValue: UserDetailViewModel(user: user))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Header Section with Profile Image
                VStack(spacing: 16) {
                    AsyncImage(url: URL(string: viewModel.user.photo)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .overlay(
                                Image(systemName: "person.fill")
                                    .font(.system(size: 40))
                                    .foregroundColor(.gray)
                            )
                    }
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                    .shadow(radius: 8)
                    
                    VStack(spacing: 4) {
                        Text(viewModel.user.name)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text("@\(viewModel.user.username)")
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.bottom)
                
                // Contact Information
                GroupedInfoView(title: "Contact Information") {
                    InfoRowView(label: "Email", value: viewModel.user.email)
                    InfoRowView(label: "Phone", value: viewModel.user.phone)
                }
                
                // Address Information
                GroupedInfoView(title: "Address") {
                    InfoRowView(label: "Street Address", value: viewModel.user.address)
                    InfoRowView(label: "State", value: viewModel.user.state)
                    InfoRowView(label: "ZIP Code", value: viewModel.user.zip)
                    InfoRowView(label: "Country", value: viewModel.user.country)
                }
                
                // Company Information
                GroupedInfoView(title: "Company") {
                    InfoRowView(label: "Company", value: viewModel.user.company)
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

