//
//  StationDetailsViewModel.swift
//  MonitoringPowodziowy
//
//  Created by Lukasz on 20/05/2023.
//

import Foundation
import SwiftUI

class StationDetailsViewModel: ObservableObject {
    let service = ApiService()
    
    @Published var tableData: [StationTableData] = [StationTableData]()
    @Published var chartData: [StationChartData] = [StationChartData]()
    
    func getStationTableData(station: StationData) {
        service.getStationTableData(riverId: "mleczka",
                                    stationId: station.id_ppwr,
                                    dateTime: Date()) { [weak self] (result: Result<[StationTableData], ApiService.APIError>) in
            
            switch result {
            case .success(let tableData):
                print("rows \(tableData.count)")
                self?.tableData = tableData
                
            case .failure(_):
                _ = Alert.init(title: Text("Bląd pobierania danych"))
            }
        }
    }
    
    func getStationChartData(station: StationData) {
        service.getStationChartData(riverId: "mleczka",
                                    stationId: station.id_ppwr,
                                    dateTime: Date()) { [weak self] (result: Result<[StationChartData], ApiService.APIError>) in
            switch result {
            case .success(let chartData):
                
                self?.chartData = chartData.filter { $0.zero != nil }
                print("chart points \(chartData.count)")
                
            case .failure(_):
                _ = Alert.init(title: Text("Bląd pobierania danych"))
            }
        }
    }
    
    func refreshData(station: StationData) {
        self.getStationTableData(station: station)
        self.getStationChartData(station: station)
    }
}
