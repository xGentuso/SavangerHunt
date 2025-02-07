//
//  HuntViewModel.swift
//  SavangerHunt
//
//  Created by ryan mota on 2025-02-07.
//

import Foundation
import SwiftUI

class HuntViewModel: ObservableObject {
    @Published var clues: [Clue] = [
        Clue(title: "Table Rock Centre", description: "Start at Table Rock Centre and look for the first clue near the viewing deck.", imageName: "tablerock"),
        Clue(title: "Journey Behind the Falls", description: "Find hints at the entrance to Journey Behind the Falls.", imageName: "journey"),
        Clue(title: "Skylon Tower", description: "Search near the observation deck of Skylon Tower for your next clue.", imageName: "skylon"),
        Clue(title: "Niagara Parks Botanical Gardens", description: "Explore the Botanical Gardens and discover a hidden marker.", imageName: "garden"),
        Clue(title: "Queen Victoria Park", description: "Look for a secret near the floral displays of Queen Victoria Park.", imageName: "queen"),
        Clue(title: "White Water Walk", description: "Search along the White Water Walk for a subtle sign.", imageName: "whitewater"),
        Clue(title: "Niagara-on-the-Lake", description: "Visit a local shop in Niagara-on-the-Lake to uncover a clue.", imageName: "notl"),
        Clue(title: "Fallsview Casino Resort", description: "Find a hidden message near the entrance of Fallsview Casino.", imageName: "fallsview"),
        Clue(title: "Niagara Glen", description: "Hike the Niagara Glen Trail and spot the concealed clue.", imageName: "niagaraglen"),
        Clue(title: "Floral Clock", description: "Discover the final clue near the famous Floral Clock in Niagara Falls.", imageName: "floral")
    ]
    
    /// Computes the reward based on the number of clues found.
    var discount: String {
        let foundCount = clues.filter { $0.found }.count
        if foundCount == clues.count {
            return "20% discount & entry into $5000 draw!"
        } else if foundCount >= 7 {
            return "20% discount!"
        } else if foundCount >= 5 {
            return "10% discount!"
        } else {
            return "No discount yet."
        }
    }
}


