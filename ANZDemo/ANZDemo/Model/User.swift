//
//  User.swift
//  ANZDemo
//
//  Created by Arunesh Rathore on 29/07/25.
//

import Foundation

struct User: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
    let company: String
    let username: String
    let email: String
    let address: String
    let zip: String
    let state: String
    let country: String
    let phone: String
    let photo: String
}

