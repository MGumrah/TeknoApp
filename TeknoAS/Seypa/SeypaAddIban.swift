//
//  SeypaAddIban.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 13.02.2026.
//
import SwiftUI

struct SeypaAddIban: View {
    @State private var iban: String = "TR"
    @State private var firmName: String = "SEYPA TESİSAT ISIT.SOĞ.SİS.İNŞ.SAN.VE TİC.LTD.ŞTİ."
    @State private var bankName: String = ""
    @State private var showBankPicker = false
    
    private let bankOptions = [
        "AKBANK", "ALBARAKA", "ALTERNATİF", "ANADOLUBANK", "BURGAN", 
        "DENİZBANK", "EMLAK KATILIM", "FİBABANKA", "GARANTİ BBVA", 
        "HALKBANK", "HSBC", "ICBC", "ING", "İŞBANK", "KUVEYT TÜRK", 
        "ODEA", "QNB", "ŞEKERBANK", "TEB", "TÜRKİYE FİNANS", 
        "VAKIFBANK", "VAKIF KATILIM", "YAPI KREDİ", "ZİRAAT", "ZİRAAT KATILIM"
    ]
    
    let viewModel: SeypaIbanViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    // Header İkon
                    VStack(spacing: 12) {
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [.blue.opacity(0.2), .purple.opacity(0.2)],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 80, height: 80)
                            
                            Image(systemName: "plus.circle.fill")
                                .font(.system(size: 40))
                                .foregroundStyle(
                                    LinearGradient(
                                        colors: [.blue, .purple],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                        }
                        
                        Text("Yeni IBAN Ekle")
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                    .padding(.top, 20)
                    
                    // Firma Adı Bölümü
                    VStack(alignment: .leading, spacing: 12) {
                        Label {
                            Text("IBAN Sahibi")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.secondary)
                        } icon: {
                            Image(systemName: "building.2.fill")
                                .foregroundStyle(.blue)
                        }
                        
                        TextField("Firma Adı", text: $firmName, axis: .vertical)
                            .textFieldStyle(.plain)
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .lineLimit(2...4)
                    }
                    .padding(.horizontal)
                    
                    // Banka Seçimi
                    VStack(alignment: .leading, spacing: 12) {
                        Label {
                            Text("Banka Bilgileri")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.secondary)
                        } icon: {
                            Image(systemName: "banknote.fill")
                                .foregroundStyle(.green)
                        }
                        
                        Button(action: { showBankPicker = true }) {
                            HStack {
                                Text(bankName.isEmpty ? "Banka Seçiniz" : bankName)
                                    .foregroundStyle(bankName.isEmpty ? .secondary : .primary)
                                    .fontWeight(bankName.isEmpty ? .regular : .semibold)
                                
                                Spacer()
                                
                                if !bankName.isEmpty {
                                    ZStack {
                                        Circle()
                                            .fill(bankColor.opacity(0.15))
                                            .frame(width: 32, height: 32)
                                        
                                        Text(bankInitials)
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundStyle(bankColor)
                                    }
                                }
                                
                                Image(systemName: "chevron.down")
                                    .foregroundStyle(.secondary)
                                    .font(.caption)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                    }
                    .padding(.horizontal)
                    
                    // IBAN Girişi
                    VStack(alignment: .leading, spacing: 12) {
                        Label {
                            Text("IBAN Numarası")
                                .font(.subheadline)
                                .fontWeight(.semibold)
                                .foregroundStyle(.secondary)
                        } icon: {
                            Image(systemName: "creditcard.fill")
                                .foregroundStyle(.purple)
                        }
                        
                        TextField("TR00 0000 0000 0000 0000 0000 00", text: $iban)
                            .textFieldStyle(.plain)
                            .keyboardType(.default)
                            .textContentType(.none)
                            .autocapitalization(.allCharacters)
                            .font(.system(.body, design: .monospaced))
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                            .onChange(of: iban) { oldValue, newValue in
                                iban = formatIbanInput(newValue)
                            }
                        
                        if !iban.isEmpty {
                            HStack(spacing: 4) {
                                Image(systemName: isValidIban ? "checkmark.circle.fill" : "exclamationmark.circle.fill")
                                    .foregroundStyle(isValidIban ? .green : .orange)
                                Text(isValidIban ? "IBAN formatı doğru" : "IBAN 26 karakter olmalı")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.horizontal, 4)
                        }
                    }
                    .padding(.horizontal)
                    
                    // Önizleme Kartı
                    if !bankName.isEmpty || !iban.isEmpty {
                        VStack(alignment: .leading, spacing: 12) {
                            Label {
                                Text("Önizleme")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.secondary)
                            } icon: {
                                Image(systemName: "eye.fill")
                                    .foregroundStyle(.orange)
                            }
                            
                            VStack(spacing: 0) {
                                HStack(spacing: 16) {
                                    if !bankName.isEmpty {
                                        ZStack {
                                            Circle()
                                                .fill(bankColor.opacity(0.15))
                                                .frame(width: 50, height: 50)
                                            
                                            Text(bankInitials)
                                                .font(.system(size: 16, weight: .bold))
                                                .foregroundStyle(bankColor)
                                        }
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 6) {
                                        if !bankName.isEmpty {
                                            Text(bankName)
                                                .font(.system(size: 17, weight: .semibold))
                                        }
                                        
                                        Text(firmName)
                                            .font(.system(size: 13))
                                            .foregroundStyle(.secondary)
                                            .lineLimit(2)
                                        
                                        if !iban.isEmpty {
                                            Text(iban)
                                                .font(.system(size: 12, design: .monospaced))
                                                .foregroundStyle(.secondary)
                                        }
                                    }
                                    
                                    Spacer()
                                }
                                .padding()
                                .background(Color(.systemBackground))
                                .cornerRadius(12)
                                .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 2)
                            }
                        }
                        .padding(.horizontal)
                        .transition(.scale.combined(with: .opacity))
                    }
                    
                    Spacer(minLength: 20)
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("IBAN Ekle")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("İptal") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Ekle") {
                        viewModel.addIban(bankName: bankName, iban: iban.replacingOccurrences(of: " ", with: ""), firmName: firmName)
                        dismiss()
                    }
                    .fontWeight(.semibold)
                    .disabled(!isFormValid)
                }
            }
            .sheet(isPresented: $showBankPicker) {
                BankPickerView(selectedBank: $bankName, banks: bankOptions)
            }
        }
    }
    
    // MARK: - Helper Properties
    
    private var isFormValid: Bool {
        !iban.isEmpty && !bankName.isEmpty && !firmName.isEmpty && isValidIban && iban != "TR"
    }
    
    private var isValidIban: Bool {
        let cleaned = iban.replacingOccurrences(of: " ", with: "")
        return cleaned.count == 26 && cleaned.hasPrefix("TR")
    }
    
    private var bankColor: Color {
        switch bankName.uppercased() {
        case let name where name.contains("GARANTİ"):
            return .green
        case let name where name.contains("YAPI"):
            return .blue
        case let name where name.contains("AKBANK"):
            return .red
        case let name where name.contains("FİNANS"):
            return .orange
        case let name where name.contains("İŞ"):
            return .indigo
        case let name where name.contains("VAKIF"):
            return .cyan
        case let name where name.contains("DENİZ"):
            return .teal
        case let name where name.contains("ZİRAAT"):
            return .green
        case let name where name.contains("HALK"):
            return .red
        case let name where name.contains("ANADOLU"):
            return .purple
        case let name where name.contains("KUVEYT"):
            return .green
        case let name where name.contains("ALBARAKA"):
            return .mint
        case let name where name.contains("FİBA"):
            return .pink
        default:
            return .blue
        }
    }
    
    private var bankInitials: String {
        let words = bankName.split(separator: " ")
        if words.count >= 2 {
            return "\(words[0].prefix(1))\(words[1].prefix(1))".uppercased()
        }
        return String(bankName.prefix(2)).uppercased()
    }
    
    // MARK: - Helper Functions
    
    private func formatIbanInput(_ input: String) -> String {
        // Sadece harf ve rakamları al
        var cleaned = input.uppercased().filter { $0.isLetter || $0.isNumber }
        
        // Eğer boş ise TR döndür
        if cleaned.isEmpty {
            return "TR"
        }
        
        // Eğer TR'nin bir kısmını silmeye çalışıyorsa, TR'yi koru
        if cleaned.count < 2 {
            if cleaned == "T" {
                return "TR"
            } else if cleaned.hasPrefix("T") {
                return "TR"
            } else {
                // T ile başlamayan bir karakter girildiyse TR'den sonra ekle
                return "TR" + cleaned
            }
        }
        
        // TR ile başlamıyorsa otomatik ekle
        if !cleaned.hasPrefix("TR") {
            // Eğer sadece "T" varsa
            if cleaned.hasPrefix("T") && cleaned.count == 1 {
                cleaned = "TR"
            }
            // TR'nin ikinci harfini silmeye çalıştıysa
            else if cleaned.hasPrefix("T") && !cleaned.hasPrefix("TR") {
                cleaned = "TR" + cleaned.dropFirst()
            }
            // Hiç T yoksa başına TR ekle
            else if !cleaned.hasPrefix("T") {
                cleaned = "TR" + cleaned
            }
        }
        
        // 26 karakterle sınırla
        let limited = String(cleaned.prefix(26))
        
        // Her 4 karakterde bir boşluk ekle
        var formatted = ""
        for (index, char) in limited.enumerated() {
            if index > 0 && index % 4 == 0 {
                formatted += " "
            }
            formatted.append(char)
        }
        
        return formatted
    }
}
// MARK: - Banka Seçim Görünümü
struct BankPickerView: View {
    @Binding var selectedBank: String
    let banks: [String]
    @Environment(\.dismiss) var dismiss
    @State private var searchText = ""
    
    var filteredBanks: [String] {
        if searchText.isEmpty {
            return banks
        }
        return banks.filter { $0.localizedCaseInsensitiveContains(searchText) }
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(filteredBanks, id: \.self) { bank in
                    Button(action: {
                        selectedBank = bank
                        dismiss()
                    }) {
                        HStack {
                            ZStack {
                                Circle()
                                    .fill(colorForBank(bank).opacity(0.15))
                                    .frame(width: 40, height: 40)
                                
                                Text(initialsForBank(bank))
                                    .font(.system(size: 14, weight: .bold))
                                    .foregroundStyle(colorForBank(bank))
                            }
                            
                            Text(bank)
                                .foregroundStyle(.primary)
                            
                            Spacer()
                            
                            if selectedBank == bank {
                                Image(systemName: "checkmark")
                                    .foregroundStyle(.blue)
                                    .fontWeight(.semibold)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
            }
            .navigationTitle("Banka Seçiniz")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText, prompt: "Banka Ara")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("İptal") {
                        dismiss()
                    }
                }
            }
        }
    }
    
    private func colorForBank(_ bank: String) -> Color {
        switch bank.uppercased() {
        case let name where name.contains("GARANTİ"): return .green
        case let name where name.contains("YAPI"): return .blue
        case let name where name.contains("AKBANK"): return .red
        case let name where name.contains("FİNANS"): return .orange
        case let name where name.contains("İŞ"): return .indigo
        case let name where name.contains("VAKIF"): return .cyan
        case let name where name.contains("DENİZ"): return .teal
        case let name where name.contains("ZİRAAT"): return .green
        case let name where name.contains("HALK"): return .red
        case let name where name.contains("ANADOLU"): return .purple
        case let name where name.contains("KUVEYT"): return .green
        case let name where name.contains("ALBARAKA"): return .mint
        case let name where name.contains("FİBA"): return .pink
        default: return .blue
        }
    }
    
    private func initialsForBank(_ bank: String) -> String {
        let words = bank.split(separator: " ")
        if words.count >= 2 {
            return "\(words[0].prefix(1))\(words[1].prefix(1))".uppercased()
        }
        return String(bank.prefix(2)).uppercased()
    }
}

