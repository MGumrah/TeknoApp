//
//  SelahattinCeliker.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 15.02.2025.
//

import SwiftUI

struct SelahattinCelikerBilgileri: View {
    let scBilgileri: String = "SELAHATTİN ÇELİKER\nGÜMÜŞÇAY MAH. FABRİKALAR CAD. NO:66 F-2 BLOK\nMERKEZEFENDİ / DENİZLİ\nGÖKPINAR VERGİ DAİRESİ\n10361095072\ninfo@teknoiklimlendirme.com\n0 534 540 57 37"
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Kişi Başlık
                VStack(spacing: 8) {
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [.green, .teal],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 70, height: 70)
                        
                        Image(systemName: "person.fill")
                            .font(.system(size: 30))
                            .foregroundStyle(.white)
                    }
                    
                    Text("SELAHATTİN ÇELİKER")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 8)
                
                // Bilgi Kartları
                VStack(spacing: 0) {
                    FirmaBilgiRow(
                        icon: "mappin.and.ellipse",
                        title: "Adres",
                        value: "GÜMÜŞÇAY MAH. FABRİKALAR CAD. NO:66 F-2 BLOK\nMERKEZEFENDİ / DENİZLİ",
                        color: .red
                    )
                    
                    Divider().padding(.leading, 56)
                    
                    FirmaBilgiRow(
                        icon: "person.text.rectangle",
                        title: "T.C. Kimlik No",
                        value: "10361095072",
                        color: .orange
                    )
                    
                    Divider().padding(.leading, 56)
                    
                    FirmaBilgiRow(
                        icon: "envelope.fill",
                        title: "E-Posta",
                        value: "info@teknoiklimlendirme.com",
                        color: .blue
                    )
                    
                    Divider().padding(.leading, 56)
                    
                    FirmaBilgiRow(
                        icon: "phone.fill",
                        title: "Telefon",
                        value: "0 534 540 57 37",
                        color: .green
                    )
                }
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemBackground))
                        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 3)
                )
                .padding(.horizontal)
                
                // Paylaş Butonu
                ShareLink(item: scBilgileri) {
                    Label("Bilgileri Paylaş", systemImage: "square.and.arrow.up")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundStyle(.white)
                        .cornerRadius(12)
                }
                .padding(.horizontal)
            }
            .padding(.bottom, 20)
            .textSelection(.enabled)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Şahıs Bilgileri")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SelahattinCelikerBilgileri()
    }
}
