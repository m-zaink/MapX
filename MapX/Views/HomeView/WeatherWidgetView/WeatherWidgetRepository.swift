//
//  WeatherWidgetRepository.swift
//  MapX
//
//  Created by Tokyo on 31/08/23.
//

import Foundation
import MapKit

class WeatherWidgetRepository {
    func weather(
        at point: CLLocationCoordinate2D
    ) async -> Result<WeatherReportData, WeatherReportError> {
        let urlString = "https://api.openweathermap.org/data/2.5/weather?lat=\(point.latitude)&lon=\(point.longitude)&units=metric&appid=77038872edac1411d39eff16a40e18ba"
        
        guard
            let url = URL(string: urlString)
        else {
            return .failure(.unknown)
        }
        
        let session = URLSession(configuration: .default)
        
        do {
            let (json, _) = try await session.data(from: url)
            
            let decoder = JSONDecoder()
            
            let data = try decoder.decode(WeatherReportData.self, from: json)
            
            return .success(data)
        } catch {
            print(error)
            return .failure(.unknown)
        }
    }
}

