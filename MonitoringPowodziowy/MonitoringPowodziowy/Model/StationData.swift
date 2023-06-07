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
    var wartosc: String = ""
    var czas: String = ""
    var miejsce: String = ""
    var dl_geo: String
    var szer_geo: String
    var p_ostrzegawczy: String = "" // yellow level
    var p_alarmowy: String = "" // red level
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: Double(szer_geo) ?? 0, longitude: Double(dl_geo) ?? 0)
    }
    
    var wartoscInt: Int { Int(wartosc) ?? 0 }
    private var wartoscOstrzegawczy: Int { Int(p_ostrzegawczy) ?? 0 }
    private var wartoscAlarmowy: Int { Int(p_alarmowy) ?? 0 }
    
    var isRedWarning: Bool {
        return wartoscInt >= wartoscAlarmowy
    }
    
    var isYellowWarning: Bool {
        return wartoscInt >= wartoscOstrzegawczy
    }
    
    var warningLevelProgress: Double {
        if isRedWarning {
            return 1
        } else if isYellowWarning {
            return Double(wartoscInt - wartoscOstrzegawczy) / Double(wartoscAlarmowy - wartoscOstrzegawczy)
        } else {
            return Double(wartoscInt) / Double(wartoscOstrzegawczy)
        }
    }
    
    var levelPercentage: Double {
        return Double(wartoscInt) / Double(wartoscAlarmowy)
    }
    
    var warningPercentage: Double {
        Double(wartoscAlarmowy - wartoscOstrzegawczy) / Double(wartoscAlarmowy)
    }
}
