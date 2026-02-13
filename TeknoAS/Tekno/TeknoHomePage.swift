//
//  TeknoHomePage.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 14.02.2025.
//

import SwiftUI


struct TeknoHomePage: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var selectedTab: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 25) {
                Image(colorScheme == .dark ? "TeknoLogo~dark": "TeknoLogo")
                    .resizable()
                    .scaledToFit()
                    .padding(.top)
                    .foregroundColor(.primary)
                    
                
                
                NavigationLink("FIRM_INFORMATION", destination: TeknoFirmaBilgileri())
                    .padding()
                
                
                NavigationLink("IBAN_SPECS", destination: Teknoiban())
                    .padding()
                
                ShareLink(item: "whatsapp test") {
                    Text("SHARE_BUTTON")
                }
                
                NavigationLink("iban ekleme", destination: AddIBan())
                
            }
        }
        .padding()
    }
        
   
}

#Preview {
    TeknoHomePage()
}
