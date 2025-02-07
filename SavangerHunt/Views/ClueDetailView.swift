//
//  ClueDetailView.swift
//  SavangerHunt
//
//  Created by ryan mota on 2025-02-07.
//

import SwiftUI

struct ClueDetailView: View {
    @EnvironmentObject var viewModel: HuntViewModel
    @Environment(\.presentationMode) var presentationMode  // Added to allow dismissing the view
    let clue: Clue

    var body: some View {
        VStack(spacing: 24) {
            Image(clue.imageName)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .cornerRadius(10)
                .shadow(radius: 4)
            
            Text(clue.title)
                .font(.system(size: 26, weight: .bold))
                .foregroundColor(.primary)
                .padding(.top)
            
            Text(clue.description)
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            if clue.found {
                HStack(spacing: 8) {
                    Image(systemName: "checkmark.seal.fill")
                        .foregroundColor(.green)
                        .font(.title)
                    Text("This item has been found!")
                        .font(.headline)
                        .foregroundColor(.green)
                }
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color(.systemGray6))
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                )
            } else {
                Button(action: markClueFound) {
                    Text("Mark as Found")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
                }
                .padding(.horizontal)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .navigationTitle("Clue Detail")
    }
    
    func markClueFound() {
        if let index = viewModel.clues.firstIndex(where: { $0.id == clue.id }) {
            viewModel.clues[index].found = true
            // Dismiss the detail view to automatically return to the Clues list.
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ClueDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ClueDetailView(clue: HuntViewModel().clues[0])
                .environmentObject(HuntViewModel())
        }
    }
}
