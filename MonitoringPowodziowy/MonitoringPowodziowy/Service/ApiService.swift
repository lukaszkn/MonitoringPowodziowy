//
//  ApiService.swift
//  MonitoringPowodziowy
//
//  Created by Lukasz on 20/05/2023.
//

import Foundation

class ApiService {
    
    private func getJSON<T: Decodable>(url: String, completion: @escaping(Result<T, APIError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(.decodingFailed))
            }
        }.resume()
    }
    
    func getStations(riverId: String, cityId: String, completion: @escaping(Result<[StationData], APIError>) -> Void) {
        let url = "https://monitoring.prospect.pl/app/\(riverId)/\(cityId)/data.php?station_values=all"
        
        getJSON(url: url) { (result: Result<[StationData], APIError>) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func getStationTableData(riverId: String, stationId: String, dateTime: Date, completion: @escaping (Result<[StationTableData], APIError>) -> Void) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd%20HH:mm"
        let dateTimeString = dateFormatter.string(from: dateTime)
        
        let url = "https://monitoring.prospect.pl/app/\(riverId)/przeworsk/data.php?table=\(stationId)&czas=\(dateTimeString)"
        
        getJSON(url: url) { (result: Result<[StationTableData], APIError>) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
    }
    
    func getStationChartData(riverId: String, stationId: String, dateTime: Date, completion: @escaping (Result<[StationChartData], APIError>) -> Void) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd%20HH:mm"
        let dateTimeNowString = dateFormatter.string(from: dateTime)
        
        dateFormatter.dateFormat = "yyyy-MM-dd%2000:00"
        let midnight = dateFormatter.string(from: dateTime)
        
        let url = "https://monitoring.prospect.pl/app/\(riverId)/przeworsk/data.php?stacja=\(stationId)&czas=\(dateTimeNowString))&midnight=\(midnight)&24hourchart=yes"
        
        getJSON(url: url) { (result: Result<[StationChartData], APIError>) in
            DispatchQueue.main.async {
                completion(result)
            }
        }
        
    }
    
    enum APIError: Error {
        case invalidUrl
        case invalidData
        case decodingFailed
    }
}
