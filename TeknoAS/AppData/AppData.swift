//
//  AppData.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 12.05.2025.
//

import SwiftUI
import SwiftData


protocol IbanProtocol: Identifiable {
    var firmName: String { get }
    var bankName: String { get }
    var iban: String { get }
}

extension TeknoIbans2: IbanProtocol {}
extension SeypaIbans2: IbanProtocol {}
extension SCIbans2: IbanProtocol {}



struct AppData: View {
    @Environment(\.modelContext) var modelContext
    @Query private var Teknoiban: [TeknoIbans2]  // Veritabanından IBAN'ları çek
    @Query private var Seypaiban: [SeypaIbans2]
    @Query private var SCiban: [SCIbans2]
    
    var combinedIbans: [any IbanProtocol] {
        Teknoiban + Seypaiban + SCiban
    }
    
    
    
    var body: some View {
        List(combinedIbans as! [TeknoIbans2]) { iban in
            VStack(alignment: .leading) {
                Text(iban.firmName).font(.headline)
                Text(iban.bankName)
                Text(iban.iban).font(.caption)
            }
        }
        .navigationTitle("Tüm IBAN'lar")
    }
}
    

@Model
class TeknoIbans2: Identifiable {
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

@Model
class SeypaIbans2: Identifiable {
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

@Model
class SCIbans2: Identifiable {
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
