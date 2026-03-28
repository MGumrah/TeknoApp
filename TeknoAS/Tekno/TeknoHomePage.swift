//
//  TeknoHomePage.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 14.02.2025.
//

import SwiftUI


struct TeknoHomePage: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Logo
                    Image(colorScheme == .dark ? "TeknoLogo~dark" : "TeknoLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 100)
                        .padding(.top, 8)
                    
                    // Menü Kartları
                    VStack(spacing: 14) {
                        NavigationLink(destination: TeknoFirmaBilgileri()) {
                            HomeMenuCard(
                                title: String(localized: "FIRM_INFORMATION"),
                                subtitle: "Tekno İklimlendirme ve Müh. A.Ş.",
                                icon: "building.2.fill",
                                color: .blue
                            )
                        }
                        
                        NavigationLink(destination: TeknoIban(modelContext: modelContext)) {
                            HomeMenuCard(
                                title: String(localized: "IBAN_SPECS"),
                                subtitle: "Banka hesap bilgileri",
                                icon: "banknote.fill",
                                color: .green
                            )
                        }
                        
                        NavigationLink(destination: TeknoKrediKartiListesi(modelContext: modelContext)) {
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

// MARK: - Ortak Menü Kartı
struct HomeMenuCard: View {
    let title: String
    let subtitle: String
    let icon: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(color.opacity(0.15))
                    .frame(width: 50, height: 50)
                
                Image(systemName: icon)
                    .font(.system(size: 22))
                    .foregroundStyle(color)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundStyle(.primary)
                Text(subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(.tertiary)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.systemBackground))
                .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 3)
        )
    }
}

#Preview {
    TeknoHomePage()
}
