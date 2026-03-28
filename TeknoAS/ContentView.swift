//
//  ContentView.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 16.01.2025.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        TabView{
            TeknoHomePage()
                .tabItem{
                Label("Tekno A.Ş", image: "TeknoLogoSF")
                }
            SeypaHomePage()
                .tabItem {
                    Label("Seypa Ltd", image: "SeypaLogoSF")
                }
            SelahattinCelikerHomePage()
                .tabItem {
                    Label("S. Çeliker", systemImage: "person")
                }
            DilaraCelikerHomePage()
                .tabItem {
                    Label("D. Çeliker", systemImage: "person")
                }
            MapView()
                .tabItem {
                    Label("MAPS_", systemImage: "map")
                }
        }
    }
}

#Preview {
    ContentView()
}
