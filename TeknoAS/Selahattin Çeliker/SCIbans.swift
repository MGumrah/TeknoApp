//
//  SelahattinCelikeriban.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 15.02.2025.
//

import SwiftUI
import SwiftData


struct SCIbansView: View {
    @Environment(\.modelContext) var modelContext
    @Query private var ibans: [SCIbans] // Veritabanından IBAN'ları çek
    
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
class SCIbans: Identifiable {
    var id: UUID
    var bankName: String
    var iban: String
    var firmName: String
    
    init(id: UUID = UUID(), bankName: String, iban: String, firmName: String) {
        self.id = id
        self.bankName = bankName
        self.iban = iban
        self.firmName = firmName
    }
    
}



