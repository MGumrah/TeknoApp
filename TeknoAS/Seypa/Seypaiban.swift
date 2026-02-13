//
//  Seypaiban.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 15.02.2025.
//

import SwiftUI



struct bank2: Identifiable {
    var id = UUID()
    var bankName: String
    var iban: String
    let firmName: String = "SEYPA TESİSAT ISIT.SOĞ.SİS.İNŞ.SAN.VE TİC.LTD.ŞTİ"
    
}


 let bankalar2: [bank2] = [
    bank2(bankName: "GARANTİ BBVA", iban: "TR54 0006 2001 3950 0006 2993 26"),
    bank2(bankName: "YAPIKREDİ", iban: "TR85 0006 7010 0000 0043 7230 64"),
    bank2(bankName: "VAKIFBANK", iban: "TR39 0001 5001 5800 7302 9009 02"),
    bank2(bankName: "DENİZBANK", iban: "TR90 0013 4000 0137 3450 0000 01"),
    bank2(bankName: "ALBARAKA", iban: "TR63 0020 30 00 0771 9251 0000 01"),
    
    ]

struct Seypaiban: View {
    var body: some View {
        NavigationStack {
            List {
                
                ShareLink(
                    item: "SEYPA TESİSAT ISIT.SOĞ.SİS.İNŞ.SAN.VE TİC.LTD.ŞTİ.\n\nGARANTİ BBVA: TR54 0006 2001 3950 0006 2993 26\nYAPIKREDİ: TR85 0006 7010 0000 0043 7230 64\nVAKIFBANK: TR39 0001 5001 5800 7302 9009 02\nDENİZBANK: TR90 0013 4000 0137 3450 0000 01\nALBARAKA: TR63 0020 30 00 0771 9251 0000 01") {
                    
                    Label("ALL_BANKS", systemImage: "square.and.arrow.up")
                }
                
                
                
                
                ForEach(bankalar2) { bank2 in
                    ShareLink(
                        item: "\(bank2.firmName)\n\(bank2.bankName)\n\(bank2.iban)") {
                        Label("SEYPA \(bank2.bankName)", systemImage: "square.and.arrow.up")
                        
                    }
                }
            }
            
            
            
        }
    }
}

#Preview {
    Seypaiban()
}

