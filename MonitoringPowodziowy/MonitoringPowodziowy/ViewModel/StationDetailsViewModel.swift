//
//  StationDetailsViewModel.swift
//  MonitoringPowodziowy
//
//  Created by Lukasz on 20/05/2023.
//

import Foundation

class StationDetailsViewModel: ObservableObject {
    let service = ApiService()
    
    @Published var tableData: [StationTableData] = [StationTableData]()
    
    func getStationTableData(station: StationData) {
        service.getStationTableData(riverId: "mleczka",
                                    stationId: station.id_ppwr,
                                    dateTime: Date()) { tableData in
            print("rows \(tableData.count)")
        }
    }
}
