//
//  TeknoASApp.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 16.01.2025.
//

import SwiftUI
import SwiftData

@main
struct TeknoASApp: App {
    let modelContainer: ModelContainer

    init() {
        do {
            modelContainer = try ModelContainer(for: TeknoIbans.self, SCIbans.self, SeypaIbans.self, DCIbans.self, TeknoKrediKarti.self, SeypaKrediKarti.self, SCKrediKarti.self, DCKrediKarti.self)
            // Sadece ilk açılışta varsayılan IBAN'ları ekle
            insertDefaultIbansOnFirstLaunch()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(modelContainer)
    }
    
    /// SADECE uygulamanın ilk açılışında varsayılan IBAN'ları ekler
    /// Bir kere çalıştıktan sonra bir daha asla çalışmaz
    private func insertDefaultIbansOnFirstLaunch() {
        let context = ModelContext(modelContainer)
        
        // TeknoIbans için kontrol
        let hasTeknoIbans = UserDefaults.standard.bool(forKey: "HasInsertedTeknoIbans")
        if !hasTeknoIbans {
            // TEKNO İKLİMLENDİRME VE MÜHENDİSLİK A.Ş. için varsayılan IBAN'lar
            let defaultTeknoIbans: [(bank: String, iban: String)] = [
                ("GARANTİ BBVA", "TR59 0006 2000 0470 0006 2870 61"),
                ("YAPIKREDİ", "TR35 0006 7010 0000 0053 4137 79"),
                ("AKBANK", "TR34 0004 6004 6988 8000 1700 78"),
                ("FİNANSBANK", "TR26 0011 1000 0000 0072 4652 48"),
                ("İŞ BANKASI", "TR68 0006 4000 0013 2011 3935 00"),
                ("VAKIFBANK", "TR22 0001 5001 5800 7305 8215 87"),
                ("DENİZBANK", "TR09 0013 4000 0601 5497 2000 01"),
                ("ZİRAAT", "TR15 0001 0017 7484 7763 1950 01"),
                ("HALKBANK", "TR50 0001 2001 4630 0010 1003 51"),
                ("ANADOLUBANK", "TR62 0013 5000 0001 1062 5600 02"),
                ("KUVEYTTÜRK", "TR91 0020 5000 0949 0992 0000 01"),
                ("ALBARAKA", "TR 31 0020 3000 0771 9240 0000 01"),
                ("FİBABANK", "TR 24 0010 3000 0000 0038 6172 44"),
                ("ZİRAAT KATILIM", "TR34 0020 9000 0125 7844 0000 01")
            ]
            
            for (index, defaultIban) in defaultTeknoIbans.enumerated() {
                let newIban = TeknoIbans(
                    bankName: defaultIban.bank,
                    iban: defaultIban.iban,
                    firmName: "TEKNO İKLİMLENDİRME VE MÜHENDİSLİK A.Ş.",
                    sortOrder: index
                )
                context.insert(newIban)
            }
            
            do {
                try context.save()
                UserDefaults.standard.set(true, forKey: "HasInsertedTeknoIbans")
                print("✅ TeknoIbans varsayılan IBAN'ları eklendi")
            } catch {
                print("❌ TeknoIbans eklenirken hata: \(error)")
            }
        }
        
        // SCIbans için kontrol
        let hasSCIbans = UserDefaults.standard.bool(forKey: "HasInsertedSCIbans")
        if !hasSCIbans {
            // SELAHATTİN ÇELİKER için varsayılan IBAN'lar
            let defaultSCIbans: [(bank: String, iban: String)] = [
                ("YAPIKREDİ", "TR08 0006 7010 0000 0044 8552 76"),
                ("ZİRAAT", "TR15 0001 0017 7470 2212 7550 01"),
                ("HALKBANK", "TR47 0001 2001 4630 0001 1235 40"),
                ("İŞBANK", "TR95 0006 4000 0013 2011 3977 67")
            ]
            
            for (index, defaultIban) in defaultSCIbans.enumerated() {
                let newIban = SCIbans(
                    bankName: defaultIban.bank,
                    iban: defaultIban.iban,
                    firmName: "SELAHATTİN ÇELİKER",
                    sortOrder: index
                )
                context.insert(newIban)
            }
            
            do {
                try context.save()
                UserDefaults.standard.set(true, forKey: "HasInsertedSCIbans")
                print("✅ SCIbans varsayılan IBAN'ları eklendi")
            } catch {
                print("❌ SCIbans eklenirken hata: \(error)")
            }
        }
        
        // SeypaIbans için kontrol
        let hasSeypaIbans = UserDefaults.standard.bool(forKey: "HasInsertedSeypaIbans")
        if !hasSeypaIbans {
            // SEYPA için varsayılan IBAN'lar
            let defaultSeypaIbans: [(bank: String, iban: String)] = [
                ("YAPIKREDİ", "TR85 0006 7010 0000 0043 7230 64"),
                ("DENİZBANK", "TR90 0013 4000 0137 3450 0000 01"),
                ("VAKIFBANK", "TR39 0001 5001 5800 7302 9009 02"),
                ("GARANTİ BBVA", "TR54 0006 2001 3950 0006 2993 26"),
                ("ALBARAKA", "TR63 0020 30 00 0771 9251 0000 01")
            ]
            
            for (index, defaultIban) in defaultSeypaIbans.enumerated() {
                let newIban = SeypaIbans(
                    bankName: defaultIban.bank,
                    iban: defaultIban.iban,
                    firmName: "SEYPA TESİSAT ISIT.SOĞ.SİS.İNŞ.SAN.VE TİC.LTD.ŞTİ",
                    sortOrder: index
                )
                context.insert(newIban)
            }
            
            do {
                try context.save()
                UserDefaults.standard.set(true, forKey: "HasInsertedSeypaIbans")
                print("✅ SeypaIbans varsayılan IBAN'ları eklendi")
            } catch {
                print("❌ SeypaIbans eklenirken hata: \(error)")
            }
        }
    }
}
