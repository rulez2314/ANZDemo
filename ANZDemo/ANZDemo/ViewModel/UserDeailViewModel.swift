//
//  UserDeailViewModel.swift
//  ANZDemo
//
//  Created by Arunesh Rathore on 29/07/25.
//

import Foundation
import SwiftUI

@MainActor
final class UserDetailViewModel: ObservableObject {
    @Published var user: User
    
    init(user: User) {
        self.user = user
    }
    
    var fullAddress: String {
        var addressComponents: [String] = []
        
        if !user.address.isEmpty {
            addressComponents.append(user.address)
        }
        
        if !user.state.isEmpty {
            addressComponents.append(user.state)
        }
        
        if !user.zip.isEmpty {
            addressComponents.append(user.zip)
        }
        
        if !user.country.isEmpty {
            addressComponents.append(user.country)
        }
        
        return addressComponents.isEmpty ? "No address available" : addressComponents.joined(separator: ", ")
    }
    
    var companyInfo: String {
        return user.company.isEmpty ? "No company information" : user.company
    }
}
