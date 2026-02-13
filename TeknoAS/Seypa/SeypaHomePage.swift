//
//  SeypaHomePage.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 15.02.2025.
//

import SwiftUI


struct SeypaHomePage: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedTab: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                Image(colorScheme == .dark ? "SeyPaLogoDar": "SeyPaLogoDar")
                    .resizable()
                    .scaledToFit()
                    .padding(.top)
                    .foregroundColor(.primary)
                    
                
                
                NavigationLink("FIRM_INFORMATION", destination: SeypaFirmaBilgileri())
                    .padding()
                
                
                NavigationLink("IBAN_SPECS", destination: Seypaiban())
                    .padding()
            }
        }
        .padding()
    }
        
   
}

#Preview {
    SeypaHomePage()
}
