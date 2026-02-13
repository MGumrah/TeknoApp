//
//  SCIbanShow.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 15.03.2025.
//

import SwiftUI
import SwiftData

class IbanViewModel: ObservableObject {
    @Published var showAddSheet = false
    @Published var ibanList: [SCIbans]
    private var modelContext: ModelContext

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        self.ibanList = []
        fetchIbans()
    }

    func fetchIbans() {
        do {
            let descriptor = FetchDescriptor<SCIbans>()
            ibanList = try modelContext.fetch(descriptor)
        } catch {
            print("IBAN'lar çekilemedi: \(error)")
        }
    }

    func addIban(bankName: String, iban: String, firmName: String) {
        let newIban = SCIbans(bankName: bankName, iban: iban, firmName: firmName)
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

struct SCIban: View {
    @Environment(\.modelContext) var modelContext
    @StateObject private var ibanViewModel: IbanViewModel
    @State private var editMode: EditMode = .inactive

    init(modelContext: ModelContext) {
        _ibanViewModel = StateObject(wrappedValue: IbanViewModel(modelContext: modelContext))
    }

    var body: some View {
        NavigationStack {
            List {
                if editMode == .inactive {
                    ShareLink(
                        item: ibanViewModel.getAllBanksShareText(),
                        label: { Label("TÜM BANKALAR", systemImage: "square.and.arrow.up") }
                    )
                }

                ForEach(ibanViewModel.ibanList) { iban in
                    if editMode == .inactive {
                        ShareLink(
                            item: "\(iban.firmName)\n\(iban.bankName)\n\(iban.iban)",
                            label: { Label("\(iban.firmName) \(iban.bankName)", systemImage: "square.and.arrow.up") }
                        )
                    } else {
                        VStack(alignment: .leading) {
                            Text(iban.firmName).font(.headline)
                            Text(iban.bankName)
                            Text(iban.iban).font(.caption)
                        }
                    }
                }
                .onDelete(perform: ibanViewModel.deleteIban)
                .onMove(perform: ibanViewModel.moveIbans)
            }
            .navigationTitle("IBAN Bilgileri")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { ibanViewModel.showAddSheet = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .environment(\.editMode, $editMode)
            .sheet(isPresented: $ibanViewModel.showAddSheet) {
                SCAddIban(viewModel: ibanViewModel)
            }
        }
    }
}


