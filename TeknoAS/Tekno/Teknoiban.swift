//
//  iban2.swift
//  Tekno AS
//
//  Created by Mehmet Gümrah on 15.01.2025.
//

import SwiftUI



struct bank: Identifiable {
    var id = UUID()
    var bankName: String
    var iban: String
    let firmName: String = "TEKNO İKLİMLENDİRME VE MÜHENDİSLİK A.Ş."
    
}


 var bankalar: [bank] = [
    bank(bankName: "GARANTİ BBVA", iban: "TR59 0006 2000 0470 0006 2870 61"),//tekno
    bank(bankName: "YAPIKREDİ", iban: "TR35 0006 7010 0000 0053 4137 79"),
    bank(bankName: "AKBANK", iban: "TR34 0004 6004 6988 8000 1700 78"),
    bank(bankName: "FİNANSBANK", iban: "TR26 0011 1000 0000 0072 4652 48"),
    bank(bankName: "İŞ BANKASI", iban: "TR68 0006 4000 0013 2011 3935 00"),
    bank(bankName: "VAKIFBANK", iban: "TR22 0001 5001 5800 7305 8215 87"),
    bank(bankName: "DENİZBANK", iban: "TR09 0013 4000 0601 5497 2000 01"),
    bank(bankName: "ZİRAAT", iban: "TR15 0001 0017 7484 7763 1950 01"),
    bank(bankName: "HALKBANK", iban: "TR50 0001 2001 4630 0010 1003 51"),
    bank(bankName: "ANADOLUBANK", iban: "TR62 0013 5000 0001 1062 5600 02"),
    bank(bankName: "KUVEYTTÜRK", iban: "TR91 0020 5000 0949 0992 0000 01"),
    bank(bankName: "ALBARAKA", iban: "TR 31 0020 3000 0771 9240 0000 01"),
    bank(bankName: "FİBABANK", iban: "TR 24 0010 3000 0000 0038 6172 44"),
    bank(bankName: "ZİRAAT KATILIM", iban: "TR34 0020 9000 0125 7844 0000 01"),
   
    
    ]

//"GARANTİ BBVA","YAPIKREDİ","AKBANK","FİNANSBANK","İŞ BANKASI","VAKIFBANK","DENİZBANK","ZİRAAT","HALKBANK","ANADOLUBANK","KUVEYTTÜRK","ALBARAKA","FİBABANK","ZİRAAT KATILIM",

//

struct Teknoiban: View {
    var body: some View {
        NavigationStack {
            List {
                
                ShareLink(
                    item: "TEKNO İKLİMLENDİRME VE MÜHENDİSLİK A.Ş.\n\nGARANTİ BBVA: TR59 0006 2000 0470 0006 2870 61\nYAPIKREDİ: TR35 0006 7010 0000 0053 4137 79\nAKBANK: TR34 0004 6004 6988 8000 1700 78\nFİNANSBANK: TR26 0011 1000 0000 0072 4652 48\nİŞ BANKASI: TR68 0006 4000 0013 2011 3935 00\nVAKIFBANK: TR22 0001 5001 5800 7305 8215 87\nDENİZBANK: TR09 0013 4000 0601 5497 2000 01\nZİRAAT: TR15 0001 0017 7484 7763 1950 01\nHALKBANK: TR50 0001 2001 4630 0010 1003 51\nANADOLUBANK: TR62 0013 5000 0001 1062 5600 02\nKUVEYTTÜRK: TR91 0020 5000 0949 0992 0000 01\nALBARAKA: TR 31 0020 3000 0771 9240 0000 01\nFİBABANK: TR 24 0010 3000 0000 0038 6172 44\nZİRAAT KATILIM: TR34 0020 9000 0125 7844 0000 01") {
                    
                    Label("ALL_BANKS", systemImage: "square.and.arrow.up")
                }
                
                
                
                
                ForEach(bankalar) { bank in
                    ShareLink(
                        item: "\(bank.firmName)\n\(bank.bankName)\n\(bank.iban)") {
                        Label("TEKNO \(bank.bankName)", systemImage: "square.and.arrow.up")
                        
                    }
                }
            }
            
            
            
        }
    }
}

#Preview {
    Teknoiban()
}
