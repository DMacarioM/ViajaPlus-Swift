//
//  MapVIew.swift
//  Practica2App
//
//  Created by RonaldRis on 12/1/24.
//

import SwiftUI
import MapKit
struct MapView: View {
    var ticket: Ticket
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.9922, longitude: -1.1307), // Placeholder
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    
    @State var citiesData: [CityCoordinates] = []

    
    var body: some View {
        
        Text("Mapa comentado por el momento")
        /**
        Map(coordinateRegion: $region, annotationItems: citiesData) { city in
            MapPin(coordinate: city.coordinate, tint: .blue)
                
        }
         .mapControls {
             MapUserLocationButton()
             MapCompass()
             MapScaleView()
         }
        .onAppear {
            // Request user's location and update region.center
            // Add annotations for the originCity and destinationCity with the times
             citiesData.append(CityCoordinatesService().getCities(searchCity: ticket.originCity))
             citiesData.append(CityCoordinatesService().getCities(searchCity: ticket.destinationCity))
        }
         
         
         */

    }
}
