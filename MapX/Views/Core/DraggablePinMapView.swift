//
//  MapView.swift
//  MapX
//
//  Created by Tokyo on 31/08/23.
//

import Foundation
import MapKit
import SwiftUI

struct DraggablePinMapView: UIViewRepresentable {
    @Binding var pinnedPoint: CLLocationCoordinate2D
    @Binding var refocus: Bool
    
    
    private let annotation = MKPointAnnotation()
    
    func makeCoordinator() -> MapViewCoordinator {
        return MapViewCoordinator(self)
    }
    
    func makeUIView(context: UIViewRepresentableContext<DraggablePinMapView>) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        mapView.isZoomEnabled = true
        mapView.isPitchEnabled = true
        mapView.isRotateEnabled = true
        mapView.isScrollEnabled = true

        annotation.coordinate = pinnedPoint
        annotation.title = "Weather"
        mapView.addAnnotation(annotation)
        
        mapView.delegate = context.coordinator
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(
            target: context.coordinator,
            action: #selector(MapViewCoordinator.onLongPressGesture(_:))
        )
        longPressGestureRecognizer.minimumPressDuration = 0.5
        mapView.addGestureRecognizer(longPressGestureRecognizer)
        
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        let region = MKCoordinateRegion(
            center: pinnedPoint,
            span: MKCoordinateSpan(
                latitudeDelta: 0.01,
                longitudeDelta: 0.01
            )
        )
        
        mapView.setRegion(region, animated: true)
        
        if refocus {
            refocus = false
        }
        
        mapView.removeAnnotation(annotation)
        annotation.coordinate = pinnedPoint
        mapView.addAnnotation(annotation)
    }
}

class MapViewCoordinator: NSObject, MKMapViewDelegate {
    var mapView: DraggablePinMapView
    
    init(_ mapView: DraggablePinMapView) {
        self.mapView = mapView
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let markerView = MKMarkerAnnotationView(
            annotation: annotation,
            reuseIdentifier: "pin"
        )
        
        markerView.isDraggable = true
        markerView.animatesWhenAdded = true
        markerView.glyphImage = UIImage(systemName: "mappin.circle")
        
        return markerView
    }
    
    func mapView(
        _ mapView: MKMapView,
        annotationView view: MKAnnotationView,
        didChange newState: MKAnnotationView.DragState,
        fromOldState oldState: MKAnnotationView.DragState
    ) {
        guard
            let coordinate = view.annotation?.coordinate
        else {
            return
        }
        
        self.mapView.pinnedPoint = coordinate
    }
    
    @objc func onLongPressGesture(_ gestureRecognizer: UILongPressGestureRecognizer) {
        guard
            let view = gestureRecognizer.view as? MKMapView,
            gestureRecognizer.state == .began
        else {
            return
        }
        
        let point = gestureRecognizer.location(in: view)
        let coordinate = view.convert(point, toCoordinateFrom: view)
        
        mapView.pinnedPoint = coordinate
    }
}
