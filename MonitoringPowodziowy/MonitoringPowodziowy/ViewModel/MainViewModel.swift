//
//  MainViewModel.swift
//  MonitoringPowodziowy
//
//  Created by Lukasz on 20/05/2023.
//

import Foundation
import MapKit

class MainViewModel: ObservableObject {
    let service = ApiService()
    
    @Published var stations = [StationData]()
    @Published var mapRegion: MKCoordinateRegion
    
    init() {
        mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50.037, longitude: 22.50528),
                                       span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    }
    
    func getStations() {
        self.stations = service.getStations()
        
        // calculate center and span
    }
}
