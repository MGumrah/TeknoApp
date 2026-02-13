//
//  SeypaFirmaBilgileri.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 15.02.2025.
//


import SwiftUI




struct SeypaFirmaBilgileri: View {
    let firmaBilgileri: String = "SEYPA TESİSAT ISIT.SOĞ.SİS.İNŞ.SAN.VE TİC.LTD.ŞTİ.\nGÜMÜŞÇAY MAH. FABRİKALAR CAD. NO:66 F-2 BLOK\nMERKEZEFENDİ / DENİZLİ\nGÖKPINAR VERGİ DAİRESİ\n7670616117\ninfo@sey-pa.com\n0 258 242 31 31"
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 10) {
                
                ShareLink(item: firmaBilgileri) {
                    Label("SHARE_BUTTON", systemImage: "square.and.arrow.up")
                }
                .padding()
                
                            
                Text("SEYPA TESİSAT ISIT.SOĞ.SİS.İNŞ.SAN.VE TİC.LTD.ŞTİ")
                    .font(.headline)
                    
                
                Text("GÜMÜŞÇAY MAH. FABRİKALAR CAD. NO:66 F-2 BLOK\nMERKEZEFENDİ / DENİZLİ")
                    .multilineTextAlignment(.center)
                    .font(.body)
                    
                
                Text("GÖKPINAR VERGİ DAİRESİ\n7670616117")
                    .multilineTextAlignment(.center)
                   
                
                Text("info@sey-pa.com")
                    .foregroundColor(.white)
                    
                
                Text("0 258 242 31 31")
                    .font(.title2)
                    .bold()
                    
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .multilineTextAlignment(.center)
            .padding()
            .textSelection(.enabled)
        }
    }
   
                    }
    



#Preview {
    SeypaFirmaBilgileri()
}
