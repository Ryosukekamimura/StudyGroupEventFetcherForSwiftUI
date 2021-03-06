//
//  MapView.swift
//  StudyGroupEventFetcherForSwiftUI
//
//  Created by Takuya Aso on 2019/12/23.
//  Copyright © 2019 Takuya Aso. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {

    let eventData: Event!
    @Binding var zoomValue: CLLocationDegrees

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView(frame: .zero)
        return mapView
    }

    // Required
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<MapView>) {
        // If address is オンライン, the location data are nil.
        guard let lat = eventData.lat, let lon = eventData.lon else {
            return
        }
        let center = CLLocationCoordinate2DMake(Double(lat)!, Double(lon)!)
        let span = MKCoordinateSpan(latitudeDelta: zoomValue, longitudeDelta: zoomValue)
        let region = MKCoordinateRegion(center: center, span: span)
        uiView.setRegion(region, animated: true)
        uiView.showsUserLocation = true
        uiView.userTrackingMode = .follow

        // POI Filtering
        let category: [MKPointOfInterestCategory] = [.parking, .publicTransport]
        let filter = MKPointOfInterestFilter(including: category)
        uiView.pointOfInterestFilter = filter

        // Put Annotaion on event place
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = "ココ！"
        annotation.subtitle = eventData.place
        uiView.addAnnotation(annotation)
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView(eventData: mockEventsData.first, zoomValue: .constant(0.01))
    }
}
