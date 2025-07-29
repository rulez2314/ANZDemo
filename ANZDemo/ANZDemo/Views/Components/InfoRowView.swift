//
//  InfoRowView.swift
//  ANZDemo
//
//  Created by Arunesh Rathore on 29/07/25.
//

import SwiftUI

struct InfoRowView: View {
    let label: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(.caption)
                .foregroundColor(.secondary)
                .textCase(.uppercase)
            
            Text(value)
                .font(.body)
                .foregroundColor(.primary)
        }
    }
}
