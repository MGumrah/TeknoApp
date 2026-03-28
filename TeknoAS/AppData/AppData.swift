//
//  AppData.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 12.05.2025.
//

import SwiftUI
import SwiftData


struct AppData: View {
    @Environment(\.modelContext) var modelContext
    @Query private var teknoIbans: [TeknoIbans]
    @Query private var seypaIbans: [SeypaIbans]
    @Query private var scIbans: [SCIbans]
    @Query private var dcIbans: [DCIbans]
    
    var body: some View {
        List {
            if !teknoIbans.isEmpty {
                Section("Tekno İklimlendirme") {
                    ForEach(teknoIbans) { iban in
                        VStack(alignment: .leading) {
                            Text(iban.firmName).font(.headline)
                            Text(iban.bankName)
                            Text(iban.iban).font(.caption)
                        }
                    }
                }
            }
            
            if !seypaIbans.isEmpty {
                Section("Seypa Tesisat") {
                    ForEach(seypaIbans) { iban in
                        VStack(alignment: .leading) {
                            Text(iban.firmName).font(.headline)
                            Text(iban.bankName)
                            Text(iban.iban).font(.caption)
                        }
                    }
                }
            }
            
            if !scIbans.isEmpty {
                Section("Selahattin Çeliker") {
                    ForEach(scIbans) { iban in
                        VStack(alignment: .leading) {
                            Text(iban.firmName).font(.headline)
                            Text(iban.bankName)
                            Text(iban.iban).font(.caption)
                        }
                    }
                }
            }
            
            if !dcIbans.isEmpty {
                Section("Dilara Çeliker") {
                    ForEach(dcIbans) { iban in
                        VStack(alignment: .leading) {
                            Text(iban.firmName).font(.headline)
                            Text(iban.bankName)
                            Text(iban.iban).font(.caption)
                        }
                    }
                }
            }
        }
        .navigationTitle("Tüm IBAN'lar")
    }
}

