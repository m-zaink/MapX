//
//  WeatherModel.swift
//  MapX
//
//  Created by Tokyo on 31/08/23.
//

import Foundation

struct WeatherReportData: Codable {
    let descriptions: [WeatherDescriptionData]
    let temperature: WeatherTemperatureData
    
    enum CodingKeys: String, CodingKey {
        case descriptions = "weather"
        case temperature = "main"
    }
}

struct WeatherDescriptionData: Codable {
    let id: Int
    let condition: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case condition = "description"
    }
}

struct WeatherTemperatureData: Codable {
    let temperature: Double
    
    enum CodingKeys: String, CodingKey {
        case temperature = "temp"
    }
}

enum WeatherReportError : Error {
    case unknown
}
