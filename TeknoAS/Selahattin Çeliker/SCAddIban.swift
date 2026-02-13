//
//  ibaneklemeclaude.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 15.03.2025.
//
import SwiftUI

struct SCAddIban: View {
    @State private var iban: String = ""
    @State private var firmName: String = "SELAHATTİN ÇELİKER"
    @State private var bankName: String = ""
    private let bankOptions = ["GARANTİ BBVA", "YAPIKREDİ", "AKBANK", "FİNANSBANK", "İŞ BANKASI", "VAKIFBANK", "DENİZBANK", "ZİRAAT", "HALKBANK", "ANADOLUBANK", "KUVEYTTÜRK", "ALBARAKA", "FİBABANK", "ZİRAAT KATILIM"]
    let viewModel: IbanViewModel // Tür açıkça belirtildi
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("IBAN Sahibi")) {
                    TextField("Firma Adı", text: $firmName)
                }
                Section(header: Text("Banka Bilgileri")) {
                    Picker("Banka Seçiniz", selection: $bankName) {
                        Text("Seçiniz").tag("")
                        ForEach(bankOptions, id: \.self) { bank in
                            Text(bank).tag(bank)
                        }
                    }
                    TextField("IBAN", text: $iban)
                        .keyboardType(.numberPad)
                        .textContentType(.none)
                        .onChange(of: iban) { oldValue, newValue in
                            let filtered = newValue.filter { $0.isNumber || $0.isLetter || $0 == " " }
                            if filtered != newValue {
                                iban = filtered
                            }
                        }
                }
                Section(header: Text("Önizleme")) {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(firmName).font(.headline)
                        if !bankName.isEmpty { Text("Banka: \(bankName)") }
                        if !iban.isEmpty { Text("IBAN: \(iban)") }
                    }
                    .padding(.vertical, 5)
                }
            }
            .navigationTitle("IBAN Ekle")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("İptal") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Ekle") {
                        viewModel.addIban(bankName: bankName, iban: iban, firmName: firmName)
                        dismiss()
                    }
                    .disabled(iban.isEmpty || bankName.isEmpty || firmName.isEmpty)
                }
            }
        }
    }
}

