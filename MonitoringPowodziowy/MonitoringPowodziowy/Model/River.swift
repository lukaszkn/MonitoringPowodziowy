//
//  River.swift
//  MonitoringPowodziowy
//
//  Created by Lukasz on 23/05/2023.
//

import Foundation

struct River {
    var id: String
    var name: String
    var cityId: String
    
    static var list: [River] = [
        River(id: "biala", name: "Biała", cityId: "tarnow"),
        River(id: "mleczka", name: "Mleczka", cityId: "przeworsk")
    ]
    
}
