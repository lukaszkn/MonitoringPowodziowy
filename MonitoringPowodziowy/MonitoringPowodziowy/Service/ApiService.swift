//
//  ApiService.swift
//  MonitoringPowodziowy
//
//  Created by Lukasz on 20/05/2023.
//

import Foundation

class ApiService {
    
    func getStations() -> [StationData] {
        if let url = Bundle.main.url(forResource: "mleczka", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let stations = try JSONDecoder().decode([StationData].self, from: data)
                return stations
            } catch let error {
                print("error: \(error.localizedDescription)")
            }
        }
        return []
    }
    
    func getStationTableData(riverId: String, stationId: String, dateTime: Date, completion: @escaping ([StationTableData]) -> Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd%20HH:mm"
        let dateTimeString = dateFormatter.string(from: dateTime)
        
        guard let url = URL(string: "https://monitoring.prospect.pl/app/\(riverId)/przeworsk/data.php?table=\(stationId)&czas=\(dateTimeString)") else {
            completion([])
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let responseData = data, error == nil else {
                completion([])
                return
            }
            
            do {
                let tableData = try JSONDecoder().decode([StationTableData].self, from: responseData)
                DispatchQueue.main.async {
                    completion(tableData)
                }
            } catch {
                completion([])
            }
        }
        
        task.resume()
    }
}
