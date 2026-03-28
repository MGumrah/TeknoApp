//
//  SeypaKrediKartiEkle.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 12.03.2026.
//

import SwiftUI
import SwiftData

struct SeypaKrediKartiEkle: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: SeypaKrediKartiViewModel
    
    @State private var kartSahibi = ""
    @State private var kartNumarasi = ""
    @State private var sonKullanmaTarihi = ""
    @State private var cvv = ""
    @State private var bankaAdi = ""
    @State private var sirketAdi = "SEYPA TESİSAT ISIT.SOĞ.SİS.İNŞ.SAN.VE TİC.LTD.ŞTİ"
    @State private var kartTipi = "Visa"
    @State private var notlar = ""
    
    let kartTipleri = ["Visa", "Mastercard", "Troy", "American Express", "Diğer"]
    
    let bankaListesi = [
        "AKBANK", "ALBARAKA", "ALTERNATİF", "ANADOLUBANK", "BURGAN",
        "DENİZBANK", "EMLAK KATILIM", "FİBABANKA", "GARANTİ BBVA",
        "HALKBANK", "HSBC", "ICBC", "ING", "İŞBANK", "KUVEYT TÜRK",
        "ODEA", "QNB", "ŞEKERBANK", "TEB", "TÜRKİYE FİNANS",
        "VAKIFBANK", "VAKIF KATILIM", "YAPI KREDİ", "ZİRAAT", "ZİRAAT KATILIM"
    ]
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Kart Bilgileri")) {
                    TextField("Kart Sahibi", text: $kartSahibi)
                        .textContentType(.name)
                    
                    TextField("Kart Numarası", text: $kartNumarasi)
                        .keyboardType(.numberPad)
                        .onChange(of: kartNumarasi) { _, newValue in
                            kartNumarasi = formatKartNumarasi(newValue)
                        }
                    
                    HStack {
                        TextField("MM/YY", text: $sonKullanmaTarihi)
                            .keyboardType(.numberPad)
                            .onChange(of: sonKullanmaTarihi) { _, newValue in
                                sonKullanmaTarihi = formatSonKullanmaTarihi(newValue)
                            }
                        
                        Divider()
                        
                        TextField("CVV", text: $cvv)
                            .keyboardType(.numberPad)
                            .onChange(of: cvv) { _, newValue in
                                cvv = String(newValue.prefix(4))
                            }
                    }
                }
                
                Section(header: Text("Banka ve Şirket")) {
                    Picker("Banka Adı", selection: $bankaAdi) {
                        Text("Seçiniz").tag("")
                        ForEach(bankaListesi, id: \.self) { banka in
                            Text(banka).tag(banka)
                        }
                    }
                    
                    HStack {
                        Text("Şirket Adı")
                            .foregroundColor(.secondary)
                        Spacer()
                        Text(sirketAdi)
                    }
                    
                    Picker("Kart Tipi", selection: $kartTipi) {
                        ForEach(kartTipleri, id: \.self) { tip in
                            Text(tip).tag(tip)
                        }
                    }
                }
                
                Section(header: Text("Notlar (Opsiyonel)")) {
                    TextEditor(text: $notlar)
                        .frame(minHeight: 100)
                }
            }
            .navigationTitle("Yeni Kredi Kartı")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("İptal") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Kaydet") {
                        kaydet()
                    }
                    .disabled(!isFormValid)
                }
            }
        }
    }
    
    private var isFormValid: Bool {
        !kartSahibi.isEmpty &&
        !kartNumarasi.isEmpty &&
        !sonKullanmaTarihi.isEmpty &&
        !cvv.isEmpty &&
        !bankaAdi.isEmpty &&
        !sirketAdi.isEmpty
    }
    
    private func kaydet() {
        viewModel.addKrediKarti(
            kartSahibi: kartSahibi,
            kartNumarasi: kartNumarasi,
            sonKullanmaTarihi: sonKullanmaTarihi,
            cvv: cvv,
            bankaAdi: bankaAdi,
            sirketAdi: sirketAdi,
            kartTipi: kartTipi,
            notlar: notlar
        )
        dismiss()
    }
    
    private func formatKartNumarasi(_ numara: String) -> String {
        let cleaned = numara.replacingOccurrences(of: " ", with: "")
        let limited = String(cleaned.prefix(16))
        var formatted = ""
        
        for (index, char) in limited.enumerated() {
            if index > 0 && index % 4 == 0 {
                formatted += " "
            }
            formatted.append(char)
        }
        return formatted
    }
    
    private func formatSonKullanmaTarihi(_ tarih: String) -> String {
        let cleaned = tarih.replacingOccurrences(of: "/", with: "")
        let limited = String(cleaned.prefix(4))
        
        if limited.count >= 2 {
            let ay = String(limited.prefix(2))
            let yil = String(limited.dropFirst(2))
            return yil.isEmpty ? ay : "\(ay)/\(yil)"
        }
        return limited
    }
}

#Preview {
    SeypaKrediKartiEkle(viewModel: SeypaKrediKartiViewModel(modelContext: ModelContext(try! ModelContainer(for: SeypaKrediKarti.self))))
}
