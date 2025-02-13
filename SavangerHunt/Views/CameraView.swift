//
//  CameraView.swift
//  SavangerHunt
//
//  Created by ryan mota on 2025-02-13.
//

import SwiftUI
import UIKit
import Photos

struct CameraView: UIViewControllerRepresentable {
    @Binding var image: UIImage?               // The captured image will be bound here
    var onImageCaptured: ((UIImage) -> Void)?  // Optional callback for when the photo is captured
    
    @Environment(\.presentationMode) var presentationMode
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: CameraView

        init(parent: CameraView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                Task { @MainActor in
                    parent.image = uiImage
                    parent.onImageCaptured?(uiImage)
                    // Optionally save to the user's photo library:
                    saveImageToPhotoLibrary(uiImage)
                }
            }
            parent.presentationMode.wrappedValue.dismiss()
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        /// Saves the captured image to the user's Photo Library, if authorized.
        private func saveImageToPhotoLibrary(_ image: UIImage) {
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized || status == .limited {
                    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
                } else {
                    print("Photo Library access denied.")
                }
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }

    @MainActor
    func makeUIViewController(context: Context) -> UIImagePickerController {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("Camera not available on this device.")
            return UIImagePickerController()
        }

        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) { }

    static var supportsCamera: Bool {
        UIImagePickerController.isSourceTypeAvailable(.camera)
    }
}


#Preview {
    CameraView(image: .constant(nil))
}
