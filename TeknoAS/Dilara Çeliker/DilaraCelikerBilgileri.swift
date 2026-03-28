//
//  DilaraCelikerBilgileri.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 16.03.2026.
//

import SwiftUI

struct DilaraCelikerBilgileri: View {
    let dcBilgileri: String = "DİLARA ÇELİKER\nGÜMÜŞÇAY MAH. FABRİKALAR CAD. NO:66 F-2 BLOK\nMERKEZEFENDİ / DENİZLİ\nGÖKPINAR VERGİ DAİRESİ\n10361095072\ninfo@teknoiklimlendirme.com\n0 534 540 57 37"
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
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
                            .frame(width: 70, height: 70)
                        
                        Image(systemName: "person.fill")
                            .font(.system(size: 30))
                            .foregroundStyle(.white)
                    }
                    
                    Text("DİLARA ÇELİKER")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                }
                .padding(.top, 8)
                
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
                        value: "29536955240",
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
                        value: "0 530 159 53 19",
                        color: .green
                    )
                }
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color(.systemBackground))
                        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 3)
                )
                .padding(.horizontal)
                
                ShareLink(item: dcBilgileri) {
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
        DilaraCelikerBilgileri()
    }
}
