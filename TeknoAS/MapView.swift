//
//  map.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 26.02.2025.
//

import MapKit
import SwiftUI




struct MapView: View {
    
    static var regions: [MKCoordinateRegion] = [
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.801371, longitude: 29.064850),
            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        ),
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.735938, longitude: 29.119204),
            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
           ),
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.805720, longitude: 29.071892),
            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
           ),
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.756448, longitude: 29.096547),
            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
           ),    ]
    
    struct Location: Identifiable {
        let id = UUID()
        let name: String
        let coordinate: CLLocationCoordinate2D
    }
    
    private let locations: [Location] = [
        Location(name: NSLocalizedString("CENTER_OFFICE", comment:""), coordinate: regions[0].center),
        Location(name: NSLocalizedString("EGE_SHOWROOM", comment: ""), coordinate: regions[1].center),
        Location(name: NSLocalizedString("VİTRA_SHOWROOM", comment: ""), coordinate: regions[2].center),
        Location(name: NSLocalizedString("GÜRAL_SHOWROOM", comment: ""), coordinate: regions[3].center),
    ]
        
    
    
    @State private var cameraPosition: MapCameraPosition = .region(regions[0])
    @State private var selectedIndex = 0
    
    
    
    var body: some View {
            Map(position: $cameraPosition) {
                ForEach(locations) { location in
                    Marker(location.name, coordinate: location.coordinate)
                }
            }
            .overlay(
                VStack{
                    Picker("picker", selection: $selectedIndex) {
                        Text("CENTER_OFFICE").tag(0)
                        Text("EGE_SHOWROOM").tag(1)
                        Text("VİTRA_SHOWROOM").tag(2)
                        Text("GÜRAL_SHOWROOM").tag(3)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    .onChange(of: selectedIndex) { oldValue, newValue in
                        cameraPosition = .region(MapView.regions[newValue])
                    }
                     
                    Spacer()
                }
            )
        
        
    }    }

    
    
    


struct map_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

