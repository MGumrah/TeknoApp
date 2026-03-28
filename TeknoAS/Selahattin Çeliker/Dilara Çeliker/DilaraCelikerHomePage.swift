//
//  DilaraCelikerHomePage.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 16.03.2026.
//

import SwiftUI


struct DilaraCelikerHomePage: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.modelContext) var modelContext
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    VStack(spacing: 8) {
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [.pink, .purple],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 80, height: 80)
                            
                            Text("DÇ")
                                .font(.system(size: 30, weight: .bold, design: .rounded))
                                .foregroundStyle(.white)
                        }
                        .padding(.top, 8)
                        
                        Text("Dilara Çeliker")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.primary)
                    }
                    
                    VStack(spacing: 14) {
                        NavigationLink(destination: DilaraCelikerBilgileri()) {
                            HomeMenuCard(
                                title: String(localized: "PERSONAL_INFORMATION"),
                                subtitle: "Kişisel bilgiler",
                                icon: "person.text.rectangle.fill",
                                color: .orange
                            )
                        }
                        
                        NavigationLink(destination: DCIban(modelContext: modelContext)) {
                            HomeMenuCard(
                                title: String(localized: "IBAN_SPECS"),
                                subtitle: "Banka hesap bilgileri",
                                icon: "banknote.fill",
                                color: .green
                            )
                        }
                        
                        NavigationLink(destination: DCKrediKartiListesi(modelContext: modelContext)) {
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
    DilaraCelikerHomePage()
}
