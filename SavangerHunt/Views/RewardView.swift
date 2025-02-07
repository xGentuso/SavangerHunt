//
//  RewardView.swift
//  SavangerHunt
//
//  Created by ryan mota on 2025-02-07.
//

import SwiftUI

struct RewardView: View {
    @EnvironmentObject var viewModel: HuntViewModel

    var body: some View {
        VStack(spacing: 24) {
            Text("Your Reward")
                .font(.system(size: 26, weight: .bold))
                .foregroundColor(.primary)
                .padding(.top)
            
            Text(viewModel.discount)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.orange)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemGray6))
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                )
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .navigationTitle("Rewards")
    }
}

struct RewardView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RewardView().environmentObject(HuntViewModel())
        }
    }
}
