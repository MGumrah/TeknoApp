//
//  SelahattinCeliker.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 15.02.2025.
//

import SwiftUI

struct SelahattinCelikerBilgileri: View {
    var body: some View {
        
        
        NavigationStack {
            VStack{
               
                
                
               
                   
                VStack(spacing: 10) {
                    ShareLink (
                        item: "SELAHATTİN ÇELİKER.\rGÜMÜŞÇAY MAH. FABRİKALAR CAD. NO:66 F-2 BLOK\rMERKEZEFENDİ / DENİZLİ\rGÖKPINAR VERGİ DAİRESİ\r10361095072\rinfo@teknoiklimlendirme.com\r0 532 540 57 37")
                     {Label("SHARE_BUTTON", systemImage:  "square.and.arrow.up")
                    }
                    .padding()
                    
                    Text("SELAHATTİN ÇELİKER")
                        .font(.headline)
                        
                    
                    Text("GÜMÜŞÇAY MAH. FABRİKALAR CAD. NO:66 F-2 BLOK\nMERKEZEFENDİ / DENİZLİ")
                        .multilineTextAlignment(.center)
                        .font(.body)
                        
                    
                    Text("T.C.\n10361095072")
                        .multilineTextAlignment(.center)
                        
                    
                    Text("info@teknoiklimlendirme.com")
                        .foregroundColor(.white)
                        
                    
                    Text("0 534 540 57 37")
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
}

#Preview {
    SelahattinCelikerBilgileri()
}
