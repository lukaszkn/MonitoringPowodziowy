//
//  StationData.swift
//  MonitoringPowodziowy
//
//  Created by Lukasz on 20/05/2023.
//

import Foundation
import MapKit

struct StationData: Codable, Identifiable {
    var id: String { id_ppwr }
    var id_ppwr: String = ""
    var wartosc: String = ""
    var czas: String = ""
    var miejsce: String = ""
    var dl_geo: String
    var szer_geo: String
    var p_ostrzegawczy: String = ""
    var p_alarmowy: String = ""
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: Double(szer_geo) ?? 0, longitude: Double(dl_geo) ?? 0)
    }
}
