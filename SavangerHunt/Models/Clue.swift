//
//  Clue.swift
//  SavangerHunt
//
//  Created by ryan mota on 2025-02-07.
//

import Foundation

struct Clue: Identifiable {
    let id = UUID()
    var title: String
    var description: String
    var imageName: String
    var found: Bool = false
}
