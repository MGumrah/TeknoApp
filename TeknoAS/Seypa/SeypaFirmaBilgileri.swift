//
//  SeypaFirmaBilgileri.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 15.02.2025.
//

import SwiftUI

struct SeypaFirmaBilgileri: View {
    let seypaFirmaBilgileri: String = "SEYPA TESİSAT ISIT.SOĞ.SİS.İNŞ.SAN.VE TİC.LTD.ŞTİ.\nGÜMÜŞÇAY MAH. FABRİKALAR CAD. NO:66 F-2 BLOK\nMERKEZEFENDİ / DENİZLİ\nGÖKPINAR VERGİ DAİRESİ\n7670616117\ninfo@sey-pa.com\n0 258 242 31 31"
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                // Firma Adı Başlık
                VStack(spacing: 8) {
                    ZStack {
                        Circle()
                            .fill(
                                LinearGradient(
                                    colors: [.orange, .red],
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .frame(width: 70, height: 70)
                        
                        Image(systemName: "building.2.fill")
                            .font(.system(size: 30))
                            .foregroundStyle(.white)
                    }
                    
                    Text("SEYPA TESİSAT ISIT.SOĞ.SİS.İNŞ.SAN.VE TİC.LTD.ŞTİ")
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
                        icon: "doc.text",
                        title: "Vergi Dairesi",
                        value: "GÖKPINAR VERGİ DAİRESİ",
                        color: .orange
                    )
                    
                    Divider().padding(.leading, 56)
                    
                    FirmaBilgiRow(
                        icon: "number",
                        title: "Vergi No",
                        value: "7670616117",
                        color: .purple
                    )
                    
                    Divider().padding(.leading, 56)
                    
                    FirmaBilgiRow(
                        icon: "envelope.fill",
                        title: "E-Posta",
                        value: "info@sey-pa.com",
                        color: .blue
                    )
                    
                    Divider().padding(.leading, 56)
                    
                    FirmaBilgiRow(
                        icon: "phone.fill",
                        title: "Telefon",
                        value: "0 258 242 31 31",
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
                ShareLink(item: seypaFirmaBilgileri) {
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
        .navigationTitle("Firma Bilgileri")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        SeypaFirmaBilgileri()
    }
}
