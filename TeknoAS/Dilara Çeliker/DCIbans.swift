//
//  DCIbans.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 16.03.2026.
//

import SwiftUI
import SwiftData


struct DCIbansView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var ibans: [DCIbans]
    
    var body: some View {
        List(ibans) { iban in
                    VStack(alignment: .leading) {
                        Text(iban.firmName).font(.headline)
                        Text(iban.bankName)
                        Text(iban.iban).font(.caption)
                    }
                }
                .navigationTitle("IBAN Listesi")
            }
        }


@Model
class DCIbans: Identifiable {
    var id: UUID
    var bankName: String
    var iban: String
    var firmName: String
    var sortOrder: Int
    
    init(id: UUID = UUID(), bankName: String, iban: String, firmName: String, sortOrder: Int = 0) {
        self.id = id
        self.bankName = bankName
        self.iban = iban
        self.firmName = firmName
        self.sortOrder = sortOrder
    }
    
}

#Preview {
    DCIbansView()
}
