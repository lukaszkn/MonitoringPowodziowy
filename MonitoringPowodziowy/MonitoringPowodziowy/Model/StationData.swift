//
//  StationData.swift
//  MonitoringPowodziowy
//
//  Created by Lukasz on 20/05/2023.
//

import Foundation
import MapKit
import UIKit

enum StationWarningLevel {
    case red
    case yellow
    case white
}

struct StationData: Codable, Identifiable {
    var id: String { id_ppwr }
    var id_ppwr: String = ""
    var wartosc: Int = 0
    var czas: String = ""
    var miejsce: String = ""
    var dl_geo: String
    var szer_geo: String
    var p_ostrzegawczy: Int = 0 // yellow level
    var p_alarmowy: Int = 0 // red level
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: Double(szer_geo) ?? 0, longitude: Double(dl_geo) ?? 0)
    }
    
    var isRedWarning: Bool {
        return wartosc >= p_alarmowy
    }
    
    var isYellowWarning: Bool {
        return wartosc >= p_ostrzegawczy
    }
    
    var warningLevelProgress: Double {
        if isRedWarning {
            return 1
        } else if isYellowWarning {
            return Double(wartosc - p_ostrzegawczy) / Double(p_alarmowy - p_ostrzegawczy)
        } else {
            return Double(wartosc) / Double(p_ostrzegawczy)
        }
    }
    
    var levelPercentage: Double {
        return Double(wartosc) / Double(p_alarmowy)
    }
    
    var warningPercentage: Double {
        Double(p_alarmowy - p_ostrzegawczy) / Double(p_alarmowy)
    }
}
