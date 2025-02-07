//
//  SavangerHuntApp.swift
//  SavangerHunt
//
//  Created by ryan mota on 2025-02-07.
//

import SwiftUI

@main
struct ScavengerHuntApp: App {
    @StateObject var viewModel = HuntViewModel()
    
    var body: some Scene {
        WindowGroup {
            MainTabView()
                .environmentObject(viewModel)
        }
    }
}
