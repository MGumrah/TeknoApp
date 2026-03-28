//
//  iban2.swift
//  Tekno AS
//
//  Created by Mehmet Gümrah on 15.01.2025.
//
import SwiftUI
import SwiftData

class TeknoIbanViewModel: ObservableObject {
    @Published var showAddSheet = false
    @Published var ibanList: [TeknoIbans]
    private var modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.ibanList = []
        fetchIbans()
    }

    func fetchIbans() {
        do {
            let descriptor = FetchDescriptor<TeknoIbans>(
                sortBy: [SortDescriptor(\.sortOrder)]
            )
            ibanList = try modelContext.fetch(descriptor)
        } catch {
            print("IBAN'lar çekilemedi: \(error)")
        }
    }

    func addIban(bankName: String, iban: String, firmName: String) {
        let maxOrder = ibanList.map(\.sortOrder).max() ?? -1
        let newIban = TeknoIbans(bankName: bankName, iban: iban, firmName: firmName, sortOrder: maxOrder + 1)
        modelContext.insert(newIban)
        saveContext()
        fetchIbans()
    }

    func deleteIban(at offsets: IndexSet) {
        offsets.forEach { index in
            modelContext.delete(ibanList[index])
        }
        saveContext()
        fetchIbans()
    }

    func moveIbans(from: IndexSet, to: Int) {
        ibanList.move(fromOffsets: from, toOffset: to)
        for (index, iban) in ibanList.enumerated() {
            iban.sortOrder = index
        }
        saveContext()
    }

    func getAllBanksShareText() -> String {
        return ibanList.map { "\($0.firmName)\n\($0.bankName)\n\($0.iban)" }.joined(separator: "\n\n")
    }

    private func saveContext() {
        do {
            try modelContext.save()
        } catch {
            print("Kayıt başarısız: \(error)")
        }
    }
}

struct TeknoIban: View {
    @Environment(\.modelContext) var modelContext
    @StateObject private var ibanViewModel: TeknoIbanViewModel
    @State private var editMode: EditMode = .inactive

    init(modelContext: ModelContext) {
        _ibanViewModel = StateObject(wrappedValue: TeknoIbanViewModel(modelContext: modelContext))
    }

    var body: some View {
        NavigationStack {
            List {
                if editMode == .inactive {
                    // Tüm Bankalar Kartı
                    ShareLink(
                        item: ibanViewModel.getAllBanksShareText(),
                        label: {
                            HStack(spacing: 16) {
                                ZStack {
                                    Circle()
                                        .fill(
                                            LinearGradient(
                                                colors: [.blue, .purple],
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .frame(width: 50, height: 50)
                                    
                                    Image(systemName: "building.2.fill")
                                        .font(.system(size: 22))
                                        .foregroundStyle(.white)
                                }
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("TÜM BANKALAR")
                                        .font(.headline)
                                        .foregroundStyle(.primary)
                                    Text("\(ibanViewModel.ibanList.count) banka hesabı")
                                        .font(.caption)
                                        .foregroundStyle(.secondary)
                                }
                                
                                Spacer()
                                
                                Image(systemName: "square.and.arrow.up")
                                    .font(.title3)
                                    .foregroundStyle(.blue)
                            }
                            .padding(.vertical, 8)
                        }
                    )
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                    )
                }

                ForEach(ibanViewModel.ibanList) { iban in
                    if editMode == .inactive {
                        ShareLink(
                            item: "\(iban.firmName)\n\(iban.bankName)\n\(iban.iban)",
                            label: {
                                IbanCardView(iban: iban)
                            }
                        )
                        .listRowBackground(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color(.systemBackground))
                                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                        )
                    } else {
                        IbanEditCardView(iban: iban)
                    }
                }
                .onDelete(perform: ibanViewModel.deleteIban)
                .onMove(perform: ibanViewModel.moveIbans)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .background(Color(.systemGroupedBackground))
            .navigationTitle("IBAN Bilgileri")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(editMode == .inactive ? "Düzenle" : "Tamam") {
                        withAnimation {
                            editMode = editMode == .inactive ? .active : .inactive
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { ibanViewModel.showAddSheet = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .environment(\.editMode, $editMode)
            .sheet(isPresented: $ibanViewModel.showAddSheet) {
                TeknoAddIban(viewModel: ibanViewModel)
            }
        }
    }
}

// MARK: - IBAN Kart Görünümü
struct IbanCardView: View {
    let iban: TeknoIbans
    
    var body: some View {
        HStack(spacing: 16) {
            // Banka İkonu
            ZStack {
                Circle()
                    .fill(bankColor.opacity(0.15))
                    .frame(width: 50, height: 50)
                
                Text(bankInitials)
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(bankColor)
            }
            
            // Banka Bilgileri
            VStack(alignment: .leading, spacing: 6) {
                Text(iban.bankName)
                    .font(.system(size: 17, weight: .semibold))
                    .foregroundStyle(.primary)
                
                Text(iban.firmName)
                    .font(.system(size: 13))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                
                Text(formatIban(iban.iban))
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
            }
            
            Spacer()
            
            // Paylaş İkonu
            Image(systemName: "square.and.arrow.up")
                .font(.title3)
                .foregroundStyle(bankColor)
        }
        .padding(.vertical, 12)
    }
    
    // Banka için renk belirleme
    private var bankColor: Color {
        switch iban.bankName.uppercased() {
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
    
    // Banka baş harfleri
    private var bankInitials: String {
        let words = iban.bankName.split(separator: " ")
        if words.count >= 2 {
            return "\(words[0].prefix(1))\(words[1].prefix(1))".uppercased()
        }
        return String(iban.bankName.prefix(2)).uppercased()
    }
    
    // IBAN formatı düzenleme
    private func formatIban(_ iban: String) -> String {
        let cleaned = iban.replacingOccurrences(of: " ", with: "")
        var formatted = ""
        for (index, char) in cleaned.enumerated() {
            if index > 0 && index % 4 == 0 {
                formatted += " "
            }
            formatted.append(char)
        }
        return formatted
    }
}
// MARK: - Düzenleme Modu Kart Görünümü
struct IbanEditCardView: View {
    let iban: TeknoIbans
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "line.3.horizontal")
                .foregroundStyle(.secondary)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(iban.bankName)
                    .font(.headline)
                Text(iban.firmName)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text(iban.iban)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}


