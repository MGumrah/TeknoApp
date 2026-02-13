//
//  EmptyDataEnter.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 12.03.2025.
//

import SwiftUI


struct Ibandeneme1: Identifiable {
    let id = UUID()
    var iban: String
    var ibanSahibi: String
    var bankaAdi: String
}

struct AddIBan: View {
    @State var iban: String = ""
    @State var ibanSahibi: String = ""
    @State var bankaAdi: String = ""
    
    @State var ibanlar: [Ibandeneme1] = []
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                
                
                Section {
                    Picker("iban Sahibi", selection: $ibanSahibi) {
                        ForEach(["TEKNO İKLİMLENDİRME VE MÜH.A.Ş.", "SEYPA TESİSAT ISIT.SOĞ.SİS.LTD.ŞTİ", "SELAHATTİN ÇELİKER"], id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    Picker("Banka Seçiniz", selection: $bankaAdi) {
                        ForEach(["GARANTİ","YAPIKREDİ","AKBANK"], id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextField("IBAN", text: $iban)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("IBAN Ekle")) {
                    
                    Text(ibanSahibi)
                    Text(bankaAdi)
                    Text(iban)
                    
                }
                
                Section(header: Text("ibanlar")) {
                    List {
                        VStack {
                            ForEach(ibanlar, id: \.id) { item in
                                Text(item.ibanSahibi)
                                Text(item.bankaAdi)
                                Text(item.iban)
                                Spacer()
                            }
                        }
                    }
                    
                }
                
            }
            .navigationBarTitle("IBAN Ekle")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("İptal") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Ekle") {
                        ibanlar.append(Ibandeneme1(iban: iban, ibanSahibi: ibanSahibi, bankaAdi: bankaAdi))
                        dismiss()
                    }
                    .disabled(iban.isEmpty || bankaAdi.isEmpty || ibanSahibi.isEmpty )            }
               
                
            }
        }
    }
    
} 


#Preview {
    AddIBan()
}
