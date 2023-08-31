//
//  HomeView.swift
//  MapX
//
//  Created by Tokyo on 31/08/23.
//

import SwiftUI
import MapKit

struct HomeView: View {
    @State private var isInfoBottomSheetVisible: Bool = false
    
    @State private var pinnedPoint = CLLocationCoordinate2D(
        latitude: 12.917070121429408,
        longitude: 77.6603876534314
    )
    @State private var refocus: Bool = false
    
    var body: some View {
        Page {
            ZStack(alignment: .center) {
                DraggablePinMapView(
                    pinnedPoint: $pinnedPoint,
                    refocus: $refocus
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack(spacing: 16.0) {
                        WeatherWidgetView(
                            point: $pinnedPoint
                        )
                        .shadow(radius: 12, x: 0, y: 0)
                    }.padding()
                    
                    Spacer()
                }
                
                VStack {
                    Spacer()
                    Spacer()
                    
                    HStack {
                        Spacer()
                        VStack(spacing: 16.0) {
                            Button {
                                isInfoBottomSheetVisible = true
                            } label: {
                                Image(systemName: "info").padding()
                            }
                            .background(.ultraThinMaterial)
                            .cornerRadius(12)
                            .shadow(radius: 12, x: 0, y: 0)
                            
                            Button {
                                refocus = true
                            } label: {
                                Image(systemName: "mappin").padding()
                            }
                            .background(.ultraThinMaterial)
                            .cornerRadius(12)
                            .shadow(radius: 12, x: 0, y: 0)
                        }
                        .padding(.horizontal)
                    }
                    
                    Spacer()
                }
            }
        }
        .sheet(isPresented: $isInfoBottomSheetVisible) {
            Page {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Overview")
                        .font(.title)
                    
                    Text("➔ Drag & drop the red pin around to obtain the selected point's weather report.")
                        .font(.body)
                    
                    Text("➔ You can long press on any point on map to select it instead.")
                        .font(.body)
                    
                    
                    Text("➔ If the red pin goes out of view, click on \(Text(Image(systemName: "mappin"))) button to bring it back to center.").font(.body)
                    
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical, 36)
            }.presentationDetents([
                .medium,
                .large
            ])
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            HomeView()
        }
    }
}
