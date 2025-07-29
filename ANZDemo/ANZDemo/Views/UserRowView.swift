//
//  UserRowView.swift
//  ANZDemo
//
//  Created by Arunesh Rathore on 29/07/25.
//

import SwiftUI

struct UserRowView: View {
    let user: User
    
    var body: some View {
        HStack {
            // Profile Image
            AsyncImage(url: URL(string: user.photo)) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            } placeholder: {
                Circle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundColor(.gray)
                    )
            }
            .frame(width: 50, height: 50)
            .clipShape(Circle())
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(user.email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text(user.company)
                    .font(.caption)
                    .foregroundColor(.blue)
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}
