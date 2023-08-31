//
//  WeatherWidgetController.swift
//  MapX
//
//  Created by Tokyo on 31/08/23.
//

import Foundation
import MapKit

enum WeatherWidgetState {
    case undetermined
    case success(data: WeatherReportData)
    case failure
}

class WeatherWidgetController: ObservableObject {
    private let repository = WeatherWidgetRepository()
    
    @Published var state: WeatherWidgetState = .undetermined
    
    func determineWeather(at point: CLLocationCoordinate2D)  {
        Task {
            onMainQueue {
                [weak self] in
                guard let `self` = self else {
                    return
                }
                
                self.state = .undetermined
            }
           
            let result = await repository.weather(at: point)
            
            switch result {
            case .success(let data):
                onMainQueue {
                    [weak self] in
                    guard let `self` = self else {
                        return
                    }
                    
                    self.state = .success(data: data)
                }
            case .failure:
                onMainQueue {
                    [weak self] in
                    guard let `self` = self else {
                        return
                    }
                    
                    self.state = .failure
                }
            }
        }
    }
}
