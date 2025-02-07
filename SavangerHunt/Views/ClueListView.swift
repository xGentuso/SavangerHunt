//
//  ClueListView.swift
//  SavangerHunt
//
//  Created by ryan mota on 2025-02-07.
//

import SwiftUI

struct ClueListView: View {
    @EnvironmentObject var viewModel: HuntViewModel

    var body: some View {
        List {
            ForEach(viewModel.clues) { clue in
                NavigationLink(destination: ClueDetailView(clue: clue)) {
                    HStack {
                        Text(clue.title)
                            .font(.body)
                            .foregroundColor(.primary)
                        Spacer()
                        if clue.found {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                    .padding(.vertical, 8)
                }
                .listRowBackground(Color(.systemGray6))
            }
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Clues")
        .background(Color(.systemBackground))
    }
}

struct ClueListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ClueListView().environmentObject(HuntViewModel())
        }
    }
}

