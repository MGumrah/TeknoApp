//
//  ContentView.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 16.01.2025.
//

import SwiftUI










struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedTab: Int = 0
    
    var body: some View {
        TabView{
            TeknoHomePage()
                .tabItem{
                Label("Tekno", image: "TeknoLogoSF")
                }
            SeypaHomePage()
                .tabItem {
                    Label("Seypa", image: "SeypaLogoSF")
                }
            SelahattinCelikerHomePage()
                .tabItem {
                    Label("Selahattin Çeliker", systemImage: "person")
                }
            MapView()
                .tabItem {
                    Label("Map", systemImage: "map")
                }
        }
    }
}

    
    




#Preview {
    ContentView()
}
