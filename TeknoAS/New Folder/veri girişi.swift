//
//  veri girişi.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 11.03.2025.
//

import SwiftUI


class ibanbilgileri: ObservableObject, Identifiable {
    let id = UUID()
    var bankaIsmi: [String] = ["GARANTİ BBVA","YAPIKREDİ","AKBANK","FİNANSBANK","İŞ BANKASI","VAKIFBANK","DENİZBANK","ZİRAAT","HALKBANK","ANADOLUBANK","KUVEYTTÜRK","ALBARAKA","FİBABANK","ZİRAAT KATILIM"]
    var ibanNo: [String]
    var ibanSahibi: [String] = ["TEKNO İKLİMLENDİRME VE MÜHENDİSLİK A.Ş.", "SEYPA TESİSAT ISIT.SOĞ.SİS.İNŞ.SAN.VE TİC.LTD.ŞTİ", "SELAHATTİN ÇELİKER"]
    
    init(bankaIsmi: [String], ibanNo: [String], ibanSahibi: [String]) {
        self.bankaIsmi = bankaIsmi
        self.ibanNo = ibanNo
        self.ibanSahibi = ibanSahibi
    }
    
  
      
}
