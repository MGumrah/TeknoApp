//
//  map.swift
//  TeknoAS
//
//  Created by Mehmet Gümrah on 26.02.2025.
//

import MapKit
import SwiftUI

struct MapView: View {
    
    struct ShowroomLocation: Identifiable {
        let id = UUID()
        let name: String
        let subtitle: String
        let icon: String
        let color: Color
        let coordinate: CLLocationCoordinate2D
        let region: MKCoordinateRegion
    }
    
    private let locations: [ShowroomLocation] = [
        ShowroomLocation(
            name: NSLocalizedString("CENTER_OFFICE", comment: ""),
            subtitle: "Gümüşçay Mah. Fabrikalar Cad. No:66",
            icon: "building.2.fill",
            color: .blue,
            coordinate: CLLocationCoordinate2D(latitude: 37.801371, longitude: 29.064850),
            region: MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 37.801371, longitude: 29.064850),
                span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            )
        ),
        ShowroomLocation(
            name: NSLocalizedString("VİTRA_SHOWROOM", comment: ""),
            subtitle: "Vitra Bayii",
            icon: "storefront.fill",
            color: .orange,
            coordinate: CLLocationCoordinate2D(latitude: 37.805720, longitude: 29.071892),
            region: MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 37.805720, longitude: 29.071892),
                span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
            )
        )
    ]
    
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.801371, longitude: 29.064850),
            span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
        )
    )
    @State private var selectedIndex = 0
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                // Harita
                Map(position: $cameraPosition) {
                    ForEach(locations) { location in
                        Marker(location.name, systemImage: location.icon, coordinate: location.coordinate)
                            .tint(location.color)
                    }
                }
                .mapStyle(.standard(elevation: .realistic))
                .ignoresSafeArea(edges: .bottom)
                
                // Alt konum kartları
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(Array(locations.enumerated()), id: \.element.id) { index, location in
                            Button(action: {
                                selectedIndex = index
                                withAnimation {
                                    cameraPosition = .region(location.region)
                                }
                            }) {
                                HStack(spacing: 12) {
                                    ZStack {
                                        Circle()
                                            .fill(location.color.opacity(selectedIndex == index ? 1.0 : 0.15))
                                            .frame(width: 44, height: 44)
                                        
                                        Image(systemName: location.icon)
                                            .font(.system(size: 18))
                                            .foregroundStyle(selectedIndex == index ? .white : location.color)
                                    }
                                    
                                    VStack(alignment: .leading, spacing: 2) {
                                        Text(location.name)
                                            .font(.subheadline)
                                            .fontWeight(.semibold)
                                            .foregroundStyle(.primary)
                                        Text(location.subtitle)
                                            .font(.caption2)
                                            .foregroundStyle(.secondary)
                                    }
                                }
                                .padding(.horizontal, 14)
                                .padding(.vertical, 10)
                                .background(
                                    RoundedRectangle(cornerRadius: 14)
                                        .fill(.ultraThinMaterial)
                                        .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 14)
                                        .stroke(selectedIndex == index ? location.color : .clear, lineWidth: 2)
                                )
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 20)
                }
            }
            .navigationTitle(String(localized: "MAPS_"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MapView()
}
