//
//  HomeView.swift
//  SavangerHunt
//
//  Created by ryan mota on 2025-02-07.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var viewModel: HuntViewModel

    var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Spacer()
                
                Text("Scavenger Hunt")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.primary)
                
                VStack(spacing: 4) {
                    Text("Clues Found")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                    Text("\(viewModel.clues.filter { $0.found }.count) / \(viewModel.clues.count)")
                        .font(.title)
                        .fontWeight(.semibold)
                        .foregroundColor(.accentColor)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color(.systemGray6))
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                )
                
                NavigationLink(destination: ClueListView()) {
                    Text("View Clues")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                }
                .padding(.horizontal)
                
                Text(viewModel.discount)
                    .font(.title2)
                    .fontWeight(.medium)
                    .foregroundColor(.green)
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemGray6))
                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                    )
                
                Spacer()
            }
            .padding()
            .background(Color(.systemBackground))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView().environmentObject(HuntViewModel())
    }
}
