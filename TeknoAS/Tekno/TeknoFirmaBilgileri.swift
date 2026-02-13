	//
//  firmaBilgileri.swift
//  Tekno AS
//
//  Created by Mehmet Gümrah on 14.01.2025.
//

import SwiftUI
let firmaBilgileri = "TEKNO İKLİMLENDİRME VE MÜHENDİSLİK A.Ş.\rGÜMÜŞÇAY MAH. FABRİKALAR CAD. NO:66 F-2 BLOK\rMERKEZEFENDİ / DENİZLİ\rGÖKPINAR VERGİ DAİRESİ\r8360461195\rinfo@teknoiklimlendirme.com\r0 258 242 31 31"

struct TeknoFirmaBilgileri: View {
    var body: some View {
        
        
        NavigationStack {
            VStack(spacing: 10) {
                
                ShareLink(item: firmaBilgileri) {
                    
                    Label("SHARE_BUTTON", systemImage:  "square.and.arrow.up")
                }
                .padding()
                
                Text("TEKNO İKLİMLENDİRME VE MÜHENDİSLİK A.Ş.")
                    .font(.headline)
                    
                
                Text("GÜMÜŞÇAY MAH. FABRİKALAR CAD. NO:66 F-2 BLOK\nMERKEZEFENDİ / DENİZLİ")
                    .multilineTextAlignment(.center)
                    .font(.body)
                    
                
                Text("GÖKPINAR VERGİ DAİRESİ\n8360461195")
                    .multilineTextAlignment(.center)
                    
                
                
                Text("info@teknoiklimlendirme.com")
                    .foregroundColor(.white)
                    
                
                Text("0 258 242 31 31")
                    .font(.title2)
                    .bold()
                    
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity) // Tüm ekranı kapla
            .multilineTextAlignment(.center) // Metni ortala
            .padding()
            .textSelection(.enabled)
            
            
        }
        
        
        
    }
   
}

#Preview {
    TeknoFirmaBilgileri()
}
