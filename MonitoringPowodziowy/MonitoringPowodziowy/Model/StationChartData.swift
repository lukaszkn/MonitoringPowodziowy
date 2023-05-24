//
//  StationChartData.swift
//  MonitoringPowodziowy
//
//  Created by Lukasz on 24/05/2023.
//

import Foundation

struct StationChartData: Codable, Identifiable {
    var wartosc: String
    var czas: String
    var npm: String?
    var p_ostrzegawczy: String?
    var p_alarmowy: String?
    var zero: String?
    var swiatlo: String?
    
    var id: String {
        czas
    }
}
