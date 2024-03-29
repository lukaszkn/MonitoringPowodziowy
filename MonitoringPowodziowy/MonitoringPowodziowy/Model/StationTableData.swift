//
//  StationTableData.swift
//  MonitoringPowodziowy
//
//  Created by Lukasz on 20/05/2023.
//

import Foundation

struct StationTableData: Codable, Identifiable, Hashable {
    var czas: String
    var wartosc: Int
    var p_ostrzegawczy: Int
    var p_alarmowy: Int
    var swiatlo: Int
    
    var id: String {
        czas
    }
    
    enum CodingKeys: CodingKey {
        case czas
        case wartosc
        case p_ostrzegawczy
        case p_alarmowy
        case swiatlo
    }
    
    var wartoscInt: Int { Int(wartosc) ?? 0 }
    var diff: Int = 0
}
