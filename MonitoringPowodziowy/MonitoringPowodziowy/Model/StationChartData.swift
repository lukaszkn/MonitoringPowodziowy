//
//  StationChartData.swift
//  MonitoringPowodziowy
//
//  Created by Lukasz on 24/05/2023.
//

import Foundation

struct StationChartData: Codable, Identifiable {
    var wartosc: Double
    var czas: String
    var npm: Int?
    var p_ostrzegawczy: Int?
    var p_alarmowy: Int?
    var zero: Double?
    var swiatlo: Int?
    
    var id: String {
        czas
    }
    
    public static let scale = 100.0
    
    var scaledWartosc: Double {
        return wartosc / StationChartData.scale
    }
    
    var dateTime: Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter.date(from: czas)
    }
}
