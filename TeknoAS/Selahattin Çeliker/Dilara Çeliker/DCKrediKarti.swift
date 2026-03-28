//
//  DCKrediKarti.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 16.03.2026.
//

import SwiftUI
import SwiftData

@Model
class DCKrediKarti: Identifiable {
    var id: UUID
    var kartSahibi: String
    var kartNumarasi: String
    var sonKullanmaTarihi: String
    var cvv: String
    var bankaAdi: String
    var sirketAdi: String
    var kartTipi: String
    var notlar: String
    var eklemeTarihi: Date
    
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
