//
//  SeypaHomePage.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 15.02.2025.
//

import SwiftUI
import SwiftData

struct SeypaHomePage: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Logo
                    Image(colorScheme == .dark ? "SeyPaLogoDar" : "SeyPaLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 100)
                        .padding(.top, 8)
                    
                    // Menü Kartları
                    VStack(spacing: 14) {
                        NavigationLink(destination: SeypaFirmaBilgileri()) {
                            HomeMenuCard(
                                title: String(localized: "FIRM_INFORMATION"),
                                subtitle: "Seypa Tesisat Ltd. Şti.",
                                icon: "building.2.fill",
                                color: .blue
                            )
                        }
                        
                        NavigationLink(destination: SeypaIban(modelContext: modelContext)) {
                            HomeMenuCard(
                                title: String(localized: "IBAN_SPECS"),
                                subtitle: "Banka hesap bilgileri",
                                icon: "banknote.fill",
                                color: .green
                            )
                        }
                        
                        NavigationLink(destination: SeypaKrediKartiListesi(modelContext: modelContext)) {
                            HomeMenuCard(
                                title: String(localized: "CREDIT_CARD"),
                                subtitle: "Mail order kart bilgileri",
                                icon: "creditcard.fill",
                                color: .purple
                            )
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 20)
            }
            .background(Color(.systemGroupedBackground))
        }
    }
}

#Preview {
    SeypaHomePage()
}
