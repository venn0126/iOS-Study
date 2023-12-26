//
//  MapView.swift
//  GTFoodPin
//
//  Created by Augus Venn on 2023/12/26.
//

import Foundation
import MapKit
import SwiftUI


struct MapView: View {
    
    @Environment(\.dismiss) var dismiss
    var location: String = ""
    var isNeedback: Bool = false
    
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.510357, longitude: -0.116773), span: MKCoordinateSpan(latitudeDelta: 1.0, longitudeDelta: 1.0))
    
    @State private var annotatedItem: AnnotatedItem = AnnotatedItem(coordinate: CLLocationCoordinate2D(latitude: 51.510357, longitude: -0.116773))
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: [annotatedItem]) {item in
            MapMarker(coordinate: item.coordinate, tint: .red)
        }
        .task {
            convertAddress(location: location)
        }
        
    }
    
    
    private func convertAddress(location: String) {
        // 获取位置
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(location) { placemarks, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let placemarks = placemarks, let location = placemarks[0].location else {
                print("placemarks[0] is nil")
                return
            }
            
            self.region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.0015, longitudeDelta: 0.0015))
            self.annotatedItem = AnnotatedItem(coordinate: location.coordinate)
        }
    }
}


struct AnnotatedItem: Identifiable {
    let id = UUID()
    var coordinate: CLLocationCoordinate2D
}


#Preview {
    
    MapView(location: "G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong")
    
}
