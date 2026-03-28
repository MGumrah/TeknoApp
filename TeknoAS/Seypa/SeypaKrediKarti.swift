//
//  SeypaKrediKarti.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 12.03.2026.
//

import SwiftUI
import SwiftData

@Model
class SeypaKrediKarti: Identifiable {
    var id: UUID
    var kartSahibi: String          // Kart sahibinin adı
    var kartNumarasi: String        // Kart numarası
    var sonKullanmaTarihi: String   // MM/YY formatında
    var cvv: String                 // CVV kodu
    var bankaAdi: String            // Banka adı
    var sirketAdi: String           // Hangi şirket için kullanılıyor
    var kartTipi: String            // Visa, Mastercard, Troy, vb.
    var notlar: String              // Ek notlar
    var eklemeTarihi: Date          // Eklenme tarihi
    
    init(
        id: UUID = UUID(),
        kartSahibi: String,
        kartNumarasi: String,
        sonKullanmaTarihi: String,
        cvv: String,
        bankaAdi: String,
        sirketAdi: String,
        kartTipi: String = "Diğer",
        notlar: String = "",
        eklemeTarihi: Date = Date()
    ) {
        self.id = id
        self.kartSahibi = kartSahibi
        self.kartNumarasi = kartNumarasi
        self.sonKullanmaTarihi = sonKullanmaTarihi
        self.cvv = cvv
        self.bankaAdi = bankaAdi
        self.sirketAdi = sirketAdi
        self.kartTipi = kartTipi
        self.notlar = notlar
        self.eklemeTarihi = eklemeTarihi
    }
}
