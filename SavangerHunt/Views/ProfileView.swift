//
//  ProfileView.swift
//  SavangerHunt
//
//  Created by ryan mota on 2025-02-07.
//

import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack(spacing: 24) {
            Text("Profile")
                .font(.system(size: 26, weight: .bold))
                .foregroundColor(.primary)
                .padding(.top)
            
            Text("User details and settings would appear here.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .navigationTitle("Profile")
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
        }
    }
}

