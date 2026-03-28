//
//  SeypaKrediKartiListesi.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 12.03.2026.
//

import SwiftUI
import SwiftData

class SeypaKrediKartiViewModel: ObservableObject {
    @Published var showAddSheet = false
    @Published var krediKartiList: [SeypaKrediKarti]
    @Published var searchText = ""
    @Published var maskedCards = true
    private var modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.krediKartiList = []
        fetchKrediKartlari()
    }

    func fetchKrediKartlari() {
        do {
            let descriptor = FetchDescriptor<SeypaKrediKarti>(
                sortBy: [SortDescriptor(\.eklemeTarihi, order: .reverse)]
            )
            krediKartiList = try modelContext.fetch(descriptor)
        } catch {
            print("❌ Seypa kredi kartları çekilemedi: \(error)")
        }
    }
    
    var filteredKartlar: [SeypaKrediKarti] {
        if searchText.isEmpty {
            return krediKartiList
        }
        return krediKartiList.filter { kart in
            kart.kartSahibi.localizedCaseInsensitiveContains(searchText) ||
            kart.bankaAdi.localizedCaseInsensitiveContains(searchText) ||
            kart.sirketAdi.localizedCaseInsensitiveContains(searchText) ||
            kart.kartNumarasi.contains(searchText)
        }
    }

    func addKrediKarti(
        kartSahibi: String,
        kartNumarasi: String,
        sonKullanmaTarihi: String,
        cvv: String,
        bankaAdi: String,
        sirketAdi: String,
        kartTipi: String,
        notlar: String
    ) {
        let newKart = SeypaKrediKarti(
            kartSahibi: kartSahibi,
            kartNumarasi: kartNumarasi,
            sonKullanmaTarihi: sonKullanmaTarihi,
            cvv: cvv,
            bankaAdi: bankaAdi,
            sirketAdi: sirketAdi,
            kartTipi: kartTipi,
            notlar: notlar
        )
        
        modelContext.insert(newKart)
        saveContext()
        fetchKrediKartlari()
    }

    func deleteKrediKarti(at offsets: IndexSet) {
        let kartlarToDelete = offsets.map { filteredKartlar[$0] }
        kartlarToDelete.forEach { kart in
            modelContext.delete(kart)
        }
        saveContext()
        fetchKrediKartlari()
    }

    func getKartShareText(kart: SeypaKrediKarti) -> String {
        """
        💳 Kredi Kartı Bilgileri
        
        Şirket: \(kart.sirketAdi)
        Kart Sahibi: \(kart.kartSahibi)
        Banka: \(kart.bankaAdi)
        Kart Tipi: \(kart.kartTipi)
        
        Kart No: \(kart.kartNumarasi)
        Son Kullanma: \(kart.sonKullanmaTarihi)
        CVV: \(kart.cvv)
        
        \(kart.notlar.isEmpty ? "" : "Not: \(kart.notlar)")
        """
    }

    private func saveContext() {
        do {
            try modelContext.save()
        } catch {
            print("❌ Seypa kayıt başarısız: \(error)")
        }
    }
}

struct SeypaKrediKartiListesi: View {
    @Environment(\.modelContext) var modelContext
    @StateObject private var viewModel: SeypaKrediKartiViewModel
    @State private var editMode: EditMode = .inactive
    @State private var selectedKart: SeypaKrediKarti?
    @State private var showDetail = false

    init(modelContext: ModelContext) {
        _viewModel = StateObject(wrappedValue: SeypaKrediKartiViewModel(modelContext: modelContext))
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                if viewModel.filteredKartlar.isEmpty {
                    bosEkran
                } else {
                    kartListesi
                }
            }
            .navigationTitle("Kredi Kartları")
            .searchable(text: $viewModel.searchText, prompt: "Kart, banka veya şirket ara")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    if !viewModel.krediKartiList.isEmpty {
                        Button(editMode == .inactive ? "Düzenle" : "Tamam") {
                            withAnimation {
                                editMode = editMode == .inactive ? .active : .inactive
                            }
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    HStack {
                        Button(action: {
                            withAnimation {
                                viewModel.maskedCards.toggle()
                            }
                        }) {
                            Image(systemName: viewModel.maskedCards ? "eye.slash" : "eye")
                        }
                        
                        Button(action: { viewModel.showAddSheet = true }) {
                            Image(systemName: "plus")
                        }
                    }
                }
            }
            .environment(\.editMode, $editMode)
            .sheet(isPresented: $viewModel.showAddSheet) {
                SeypaKrediKartiEkle(viewModel: viewModel)
            }
            .sheet(item: $selectedKart) { kart in
                SeypaKrediKartiDetayView(kart: kart, viewModel: viewModel)
            }
        }
    }
    
    private var bosEkran: some View {
        VStack(spacing: 20) {
            Image(systemName: "creditcard")
                .font(.system(size: 70))
                .foregroundStyle(.secondary)
            
            Text("Henüz Kart Eklenmemiş")
                .font(.title2)
                .fontWeight(.semibold)
            
            Text("Mail order için kredi kartı bilgilerini ekleyerek kolayca yönetin")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
            
            Button(action: { viewModel.showAddSheet = true }) {
                Label("Kart Ekle", systemImage: "plus.circle.fill")
                    .font(.headline)
                    .padding()
                    .background(Color.blue)
                    .foregroundStyle(.white)
                    .cornerRadius(12)
            }
            .padding(.top)
        }
    }
    
    private var kartListesi: some View {
        List {
            if editMode == .inactive {
                Section {
                    HStack(spacing: 16) {
                        ZStack {
                            Circle()
                                .fill(
                                    LinearGradient(
                                        colors: [.purple, .pink],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 50, height: 50)
                            
                            Image(systemName: "creditcard.fill")
                                .font(.system(size: 22))
                                .foregroundStyle(.white)
                        }
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Toplam Kredi Kartı")
                                .font(.headline)
                                .foregroundStyle(.primary)
                            Text("\(viewModel.krediKartiList.count) kayıtlı kart")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "creditcard.and.123")
                            .font(.title3)
                            .foregroundStyle(.purple)
                    }
                    .padding(.vertical, 8)
                }
            }
            
            ForEach(viewModel.filteredKartlar) { kart in
                if editMode == .inactive {
                    Button(action: {
                        selectedKart = kart
                    }) {
                        SeypaKrediKartiCardView(kart: kart, masked: viewModel.maskedCards)
                    }
                    .listRowBackground(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color(.systemBackground))
                            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
                    )
                } else {
                    SeypaKrediKartiEditView(kart: kart)
                }
            }
            .onDelete(perform: viewModel.deleteKrediKarti)
        }
        .listStyle(.insetGrouped)
    }
}

// MARK: - Kart Görünümü
struct SeypaKrediKartiCardView: View {
    let kart: SeypaKrediKarti
    let masked: Bool
    
    var body: some View {
        HStack(spacing: 16) {
            ZStack {
                Circle()
                    .fill(kartRengi.opacity(0.15))
                    .frame(width: 55, height: 55)
                
                Image(systemName: kartIkonu)
                    .font(.system(size: 24))
                    .foregroundStyle(kartRengi)
            }
            
            VStack(alignment: .leading, spacing: 6) {
                Text(kart.sirketAdi)
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(.primary)
                
                Text(kart.bankaAdi)
                    .font(.system(size: 14))
                    .foregroundStyle(.secondary)
                
                Text(masked ? maskKartNumarasi(kart.kartNumarasi) : kart.kartNumarasi)
                    .font(.system(size: 12, design: .monospaced))
                    .foregroundStyle(.secondary)
                
                HStack(spacing: 12) {
                    Label(kart.sonKullanmaTarihi, systemImage: "calendar")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                    
                    Label(kart.kartTipi, systemImage: "creditcard")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                }
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.caption)
                .foregroundStyle(.tertiary)
        }
        .padding(.vertical, 12)
    }
    
    private var kartRengi: Color {
        switch kart.kartTipi {
        case "Visa": return .blue
        case "Mastercard": return .orange
        case "Troy": return .green
        case "American Express": return .indigo
        default: return .gray
        }
    }
    
    private var kartIkonu: String {
        switch kart.kartTipi {
        case "Visa", "Mastercard", "Troy": return "creditcard.fill"
        case "American Express": return "creditcard.and.123"
        default: return "creditcard"
        }
    }
    
    private func maskKartNumarasi(_ numara: String) -> String {
        let cleaned = numara.replacingOccurrences(of: " ", with: "")
        guard cleaned.count >= 4 else { return "•••• •••• •••• ••••" }
        let son4 = String(cleaned.suffix(4))
        return "•••• •••• •••• \(son4)"
    }
}

// MARK: - Düzenleme Görünümü
struct SeypaKrediKartiEditView: View {
    let kart: SeypaKrediKarti
    
    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: "line.3.horizontal")
                .foregroundStyle(.secondary)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(kart.sirketAdi)
                    .font(.headline)
                Text(kart.bankaAdi)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                Text("•••• •••• •••• \(String(kart.kartNumarasi.suffix(4)))")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

// MARK: - Detay Görünümü
struct SeypaKrediKartiDetayView: View {
    let kart: SeypaKrediKarti
    let viewModel: SeypaKrediKartiViewModel
    @Environment(\.dismiss) var dismiss
    @State private var showMasked = true
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    kartGorseli
                    
                    VStack(spacing: 16) {
                        seypaDetayBilgi(baslik: "Şirket", icerik: kart.sirketAdi, ikon: "building.2")
                        seypaDetayBilgi(baslik: "Kart Sahibi", icerik: kart.kartSahibi, ikon: "person")
                        seypaDetayBilgi(baslik: "Banka", icerik: kart.bankaAdi, ikon: "building.columns")
                        seypaDetayBilgi(baslik: "Kart Tipi", icerik: kart.kartTipi, ikon: "creditcard")
                        
                        Divider()
                        
                        seypaGizlenebilirBilgi(baslik: "Kart Numarası", icerik: kart.kartNumarasi, ikon: "number")
                        seypaGizlenebilirBilgi(baslik: "Son Kullanma", icerik: kart.sonKullanmaTarihi, ikon: "calendar")
                        seypaGizlenebilirBilgi(baslik: "CVV", icerik: kart.cvv, ikon: "lock")
                        
                        if !kart.notlar.isEmpty {
                            Divider()
                            seypaDetayBilgi(baslik: "Notlar", icerik: kart.notlar, ikon: "note.text")
                        }
                    }
                    .padding()
                    
                    ShareLink(item: viewModel.getKartShareText(kart: kart)) {
                        Label("Bilgileri Paylaş", systemImage: "square.and.arrow.up")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundStyle(.white)
                            .cornerRadius(12)
                    }
                    .padding(.horizontal)
                }
                .padding(.vertical)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Kart Detayları")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Kapat") {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .primaryAction) {
                    Button(action: { showMasked.toggle() }) {
                        Image(systemName: showMasked ? "eye.slash" : "eye")
                    }
                }
            }
        }
    }
    
    private var kartGorseli: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    LinearGradient(
                        colors: kartRenkleri,
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(height: 200)
                .shadow(color: .black.opacity(0.2), radius: 10, x: 0, y: 5)
            
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Image(systemName: "creditcard.fill")
                        .font(.title)
                    Spacer()
                    Text(kart.kartTipi)
                        .font(.caption)
                        .fontWeight(.semibold)
                }
                
                Spacer()
                
                Text(showMasked ? maskKartNumarasi(kart.kartNumarasi) : kart.kartNumarasi)
                    .font(.system(size: 22, design: .monospaced))
                    .fontWeight(.medium)
                
                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("KART SAHİBİ")
                            .font(.caption2)
                            .opacity(0.8)
                        Text(kart.kartSahibi)
                            .font(.caption)
                            .fontWeight(.semibold)
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .trailing, spacing: 4) {
                        Text("GEÇERLİLİK")
                            .font(.caption2)
                            .opacity(0.8)
                        Text(kart.sonKullanmaTarihi)
                            .font(.caption)
                            .fontWeight(.semibold)
                    }
                }
            }
            .padding(24)
            .foregroundStyle(.white)
        }
        .padding(.horizontal)
    }
    
    private var kartRenkleri: [Color] {
        switch kart.kartTipi {
        case "Visa": return [.blue, .purple]
        case "Mastercard": return [.orange, .red]
        case "Troy": return [.green, .teal]
        case "American Express": return [.indigo, .blue]
        default: return [.gray, .secondary]
        }
    }
    
    private func seypaDetayBilgi(baslik: String, icerik: String, ikon: String) -> some View {
        HStack(spacing: 16) {
            Image(systemName: ikon)
                .font(.title3)
                .foregroundStyle(.blue)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(baslik)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(icerik)
                    .font(.body)
                    .fontWeight(.medium)
            }
            
            Spacer()
        }
    }
    
    private func seypaGizlenebilirBilgi(baslik: String, icerik: String, ikon: String) -> some View {
        HStack(spacing: 16) {
            Image(systemName: ikon)
                .font(.title3)
                .foregroundStyle(.red)
                .frame(width: 30)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(baslik)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Text(showMasked ? String(repeating: "•", count: icerik.count) : icerik)
                    .font(.system(.body, design: .monospaced))
                    .fontWeight(.medium)
            }
            
            Spacer()
        }
    }
    
    private func maskKartNumarasi(_ numara: String) -> String {
        let cleaned = numara.replacingOccurrences(of: " ", with: "")
        guard cleaned.count >= 4 else { return "•••• •••• •••• ••••" }
        let son4 = String(cleaned.suffix(4))
        return "•••• •••• •••• \(son4)"
    }
}

#Preview {
    SeypaKrediKartiListesi(modelContext: ModelContext(try! ModelContainer(for: SeypaKrediKarti.self)))
}
