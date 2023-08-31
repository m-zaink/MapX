//
//  WeatherWidgetView.swift
//  MapX
//
//  Created by Tokyo on 31/08/23.
//

import SwiftUI
import CoreLocation

struct WeatherWidgetView: View {
    @ObservedObject private var controller: WeatherWidgetController = WeatherWidgetController()
    
    @Binding var point: CLLocationCoordinate2D
    
    var body: some View {
        Container {
            HStack {
                Spacer()
                
                switch controller.state {
                case .success(let data):
                    VStack(spacing: 8.0) {
                        if let description = data.descriptions.first {
                            Image(systemName: description.image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 40, height: 40)
                        }
                        
                        Text("\(String(format: "%.2f", data.temperature.temperature)) ° C").font(.largeTitle)
                        
                        if let description = data.descriptions.first {
                            Text("\(description.condition.capitalized)")
                        }
                    }
                    
                case .failure:
                    VStack(spacing: 16.0) {
                        Text("Something Went Wrong 😢")
                        
                        Divider()
                        
                        Button {
                            controller.determineWeather(at: point)
                        } label: {
                            HStack(spacing: 16.0) {
                                Text("Try Again")
                                Image(systemName: "arrow.clockwise")
                            }
                        }
                    }
                    
                case .undetermined:
                    ProgressView("Fetching weather report ...")
                }
                
                Spacer()
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        
        .onAppear {
            controller.determineWeather(at: point)
        }
        .onChange(of: point) { point in
            controller.determineWeather(at: point)
        }
    }
}

struct WeatherWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherWidgetView(
            point: Binding {
                CLLocationCoordinate2D(
                    latitude: 41.878113,
                    longitude: -87.629799
                )
            } set: { value, transaction in
                
            }
        )
        .previewLayout(.sizeThatFits)
        .padding()
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

extension WeatherDescriptionData {
    var image: String {
        switch id {
        case 200..<600:
            return  "cloud.rain.fill"
        case 600..<700:
            return "cloud.snow.fill"
        case 801..<900:
            return  "cloud.fill"
        default:
            return  "sun.max.fill"
        }
    }
}
