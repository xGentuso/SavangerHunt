//
//  ClueDetailView.swift
//  SavangerHunt
//
//  Created by ryan mota on 2025-02-07.
//

import SwiftUI
import PhotosUI

struct ClueDetailView: View {
    @EnvironmentObject var viewModel: HuntViewModel
    @Environment(\.presentationMode) var presentationMode
    let clue: Clue

    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var selectedImage: UIImage? = nil
    
    // State to control camera sheet presentation
    @State private var showCamera = false

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                // Display either the user-selected photo or the default asset image.
                if let image = selectedImage ?? clue.photo {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .shadow(radius: 4)
                } else {
                    Image(clue.imageName)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .shadow(radius: 4)
                }

                Text(clue.title)
                    .font(.system(size: 26, weight: .bold))
                Text(clue.description)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                
                if clue.found {
                    foundClueIndicator
                } else {
                    photoSelectionButtons
                }

                Spacer()

                if !clue.found && (selectedImage != nil || clue.photo != nil) {
                    markFoundButton
                }
            }
            .padding()
            .background(Color(.systemBackground))
        }
        .navigationTitle("Clue Detail")
        .onAppear {
            // Try loading a previously saved image for this clue.
            if let savedImage = PersistenceController.loadImage(for: clue) {
                updateCluePhoto(savedImage)
            }
        }
        .onChange(of: selectedItem) {_, newItem in
            Task {
                if let newItem = newItem,
                   let data = try? await newItem.loadTransferable(type: Data.self),
                   let uiImage = UIImage(data: data) {
                    selectedImage = uiImage
                    updateCluePhoto(uiImage)
                    PersistenceController.saveImage(uiImage, for: clue)
                }
            }
        }
        // Present the camera when showCamera = true
        .sheet(isPresented: $showCamera) {
            CameraView(image: $selectedImage) { capturedImage in
                // Update the clue in view model
                updateCluePhoto(capturedImage)
                // Save the image to disk
                PersistenceController.saveImage(capturedImage, for: clue)
            }
        }
    }
    
    // MARK: - Subviews

    
    private var foundClueIndicator: some View {
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
    }

    private var photoSelectionButtons: some View {
        VStack(spacing: 16) {
            PhotosPicker("Select from Gallery", selection: $selectedItem, matching: .images)
                .padding()
                .buttonStyle(.borderedProminent)

            Button("Take Photo") {
                showCamera = true
            }
            .padding()
            .buttonStyle(.borderedProminent)
            .disabled(!CameraView.supportsCamera)
        }
    }

    private var markFoundButton: some View {
        Button("Mark as Found") {
            markClueFound()
        }
        .font(.headline)
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.accentColor)
        .foregroundColor(.white)
        .cornerRadius(10)
        .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: 2)
        .padding(.horizontal)
    }

    // MARK: - Methods

    private func updateCluePhoto(_ image: UIImage) {
        if let index = viewModel.clues.firstIndex(where: { $0.id == clue.id }) {
            viewModel.clues[index].photo = image
        }
    }

    private func markClueFound() {
        if let index = viewModel.clues.firstIndex(where: { $0.id == clue.id }) {
            viewModel.clues[index].found = true
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

