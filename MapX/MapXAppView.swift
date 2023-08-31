//
//  ContentView.swift
//  MapX
//
//  Created by Tokyo on 31/08/23.
//

import SwiftUI
import MapKit

struct MapXAppView: View {
    var body: some View {
        NavigationStack {
            HomeView()
        }
    }
}

struct MapXAppView_Previews: PreviewProvider {
    static var previews: some View {
        MapXAppView()
    }
}
