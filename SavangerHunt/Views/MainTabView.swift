//
//  MainTabView.swift
//  SavangerHunt
//
//  Created by ryan mota on 2025-02-07.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            NavigationView { HomeView() }
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            NavigationView { ClueListView() }
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Clues")
                }
            
            NavigationView { RewardView() }
                .tabItem {
                    Image(systemName: "gift.fill")
                    Text("Rewards")
                }
            
            NavigationView { ProfileView() }
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(HuntViewModel())
    }
}
