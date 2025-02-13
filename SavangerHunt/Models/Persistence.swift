//
//  Presistence.swift
//  SavangerHunt
//
//  Created by ryan mota on 2025-02-13.
//


import CoreData
import UIKit


struct PersistenceController {
    // MARK: - Singleton & Preview

    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
       
        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    // MARK: - Core Data Stack

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        // Change "YourAppName" to match your .xcdatamodeld filename
        container = NSPersistentContainer(name: "YourAppName")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                // Handle errors in a production app instead of using fatalError
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        // Merge changes from multiple contexts automatically
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    // MARK: - Image Persistence (File-Based)

    
    private static func getDocumentsDirectory() -> URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }

    
    static func fileURL(for clue: Clue) -> URL {
        getDocumentsDirectory().appendingPathComponent("\(clue.id.uuidString).jpg")
    }

    static func saveImage(_ image: UIImage, for clue: Clue) {
        guard let data = image.jpegData(compressionQuality: 0.8) else { return }
        let url = fileURL(for: clue)
        do {
            try data.write(to: url)
            print("Saved image to: \(url)")
        } catch {
            print("Error saving image:", error)
        }
    }

    static func loadImage(for clue: Clue) -> UIImage? {
        let url = fileURL(for: clue)
        guard let data = try? Data(contentsOf: url) else { return nil }
        return UIImage(data: data)
    }

    static func deleteImage(for clue: Clue) {
        let url = fileURL(for: clue)
        try? FileManager.default.removeItem(at: url)
    }
}
