//
//  SelahattinCelikerHomePage.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 15.02.2025.
//

import SwiftUI


struct SelahattinCelikerHomePage: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.modelContext) var modelContext
    @State private var selectedTab: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                Text("Selahattin Çeliker")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.primary)
                    
                
                
                NavigationLink("PERSONAL_INFORMATION", destination: SelahattinCelikerBilgileri())
                    .padding()
                
                
                NavigationLink("IBAN_SPECS", destination: SCIban(modelContext: modelContext))
                   .padding()
            }
        }
        .padding()
    }
        
   
}

#Preview {
    SelahattinCelikerHomePage()
}
