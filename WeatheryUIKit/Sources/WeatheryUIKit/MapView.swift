//
//  MapView.swift
//  WeatheryUIKit
//
//  Created by Phu Phong Ngo on 2/6/2023.
//

import SwiftUI
import MapKit

public struct MapView: UIViewRepresentable {
    private let coordinate: CLLocationCoordinate2D

    public init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }

    public func makeUIView(context: Context) -> some UIView {
        MKMapView()
    }

    public func updateUIView(_ uiView: UIViewType, context: Context) {
        guard let mkView = uiView as? MKMapView else { return }
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: coordinate, span: span)

        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        mkView.addAnnotation(annotation)

        mkView.setRegion(region, animated: true)
    }
}
