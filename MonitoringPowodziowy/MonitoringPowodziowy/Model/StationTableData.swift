//
//  StationTableData.swift
//  MonitoringPowodziowy
//
//  Created by Lukasz on 20/05/2023.
//

import Foundation

struct StationTableData: Codable {
    var czas: String
    var wartosc: String
    var p_ostrzegawczy: String
    var p_alarmowy: String
    var swiatlo: String
}
