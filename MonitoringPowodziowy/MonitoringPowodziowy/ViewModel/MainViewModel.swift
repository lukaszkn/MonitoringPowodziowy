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
    
    var selectedRiver: River
    var selectedStation: StationData?
    
    @Published var lastUpdated: Date?
    @Published var stations = [StationData]()
    @Published var mapRegion: MKCoordinateRegion
    
    init() {
        if let riverId = UserDefaults.standard.string(forKey: "selectedRiver") {
            selectedRiver = River.list.filter { $0.id == riverId }[0]
        } else {
            selectedRiver = River.list.filter { $0.id == "mleczka" }[0]
        }
        
        mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 50.037, longitude: 22.50528),
                                       span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    }
    
    func getStations() {
        service.getStations(riverId: "mleczka", cityId: "przeworsk") { [weak self] (result: Result<[StationData], ApiService.APIError>) in
            switch result {
            case .success(let stations):
                self?.stations = stations
                self?.lastUpdated = Date()
                
            case .failure(_):
                self?.stations = Bundle.main.decode([StationData].self, from: "mleczka.json")
            }
            
            let coordinates = self?.stations.map { $0.coordinate }
            
            // calculate center and span
            if let coords = coordinates {
                self?.mapRegion = MKCoordinateRegion(center: coords.center(),
                                               span: MKCoordinateSpan(latitudeDelta: coords.span().latitudeDelta * 1.15,
                                                                      longitudeDelta: coords.span().longitudeDelta * 1.15))
            }
        }
        
    }
    
    func refresh() {
        getStations()
    }
}

extension Array where Element == CLLocationCoordinate2D {
    func center() -> CLLocationCoordinate2D {
        var maxLatitude: Double = -.greatestFiniteMagnitude
        var maxLongitude: Double = -.greatestFiniteMagnitude
        var minLatitude: Double = .greatestFiniteMagnitude
        var minLongitude: Double = .greatestFiniteMagnitude

        for location in self {
            maxLatitude = Swift.max(maxLatitude, location.latitude)
            maxLongitude = Swift.max(maxLongitude, location.longitude)
            minLatitude = Swift.min(minLatitude, location.latitude)
            minLongitude = Swift.min(minLongitude, location.longitude)
        }

        let centerLatitude = CLLocationDegrees((maxLatitude + minLatitude) * 0.5)
        let centerLongitude = CLLocationDegrees((maxLongitude + minLongitude) * 0.5)
        return .init(latitude: centerLatitude, longitude: centerLongitude)
    }
    
    func span() -> MKCoordinateSpan {
        var maxLatitude: Double = -.greatestFiniteMagnitude
        var maxLongitude: Double = -.greatestFiniteMagnitude
        var minLatitude: Double = .greatestFiniteMagnitude
        var minLongitude: Double = .greatestFiniteMagnitude

        for location in self {
            maxLatitude = Swift.max(maxLatitude, location.latitude)
            maxLongitude = Swift.max(maxLongitude, location.longitude)
            minLatitude = Swift.min(minLatitude, location.latitude)
            minLongitude = Swift.min(minLongitude, location.longitude)
        }
        
        return .init(latitudeDelta: CLLocationDegrees(maxLatitude - minLatitude),
                     longitudeDelta: CLLocationDegrees(maxLongitude - minLongitude))
    }
}
