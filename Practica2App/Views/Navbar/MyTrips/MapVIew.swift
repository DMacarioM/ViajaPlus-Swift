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
    var deltaMap : Double
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.9922, longitude: -1.1307), // Placeholder
        span: MKCoordinateSpan(latitudeDelta: 3.0, longitudeDelta: 3.0)
    )

    let locationManager = CLLocationManager()

    @State var citiesData: [CityCoordinates] = []

    
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $region, annotationItems: citiesData) { city in
                MapAnnotation(coordinate: city.coordinate, content: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .fill(Color.teal)
                        Text(city.name)
                            .padding(5)
                    }
                })
            }
            .mapControls {
                MapCompass()
                MapScaleView()
            }
            .onAppear {
                
                locationManager.requestAlwaysAuthorization()
                var currentPosition = locationManager.requestLocation()
                
                citiesData.append(CityCoordinatesService().getCities(searchCity: ticket.originCity))
                citiesData.append(CityCoordinatesService().getCities(searchCity: ticket.destinationCity))
                
                
                region = MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: 37.9922, longitude: -1.1307), // Placeholder
                    span: MKCoordinateSpan(latitudeDelta: deltaMap, longitudeDelta: deltaMap)
                )
                
                
            }
            
            // Zoom In and Zoom Out Buttons
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button(action: {
                        zoomIn()
                    }) {
                        Image(systemName: "plus")
                            .frame(width: 50, height: 50)
                    }
                    Button(action: {
                        zoomOut()
                    }) {
                        Image(systemName: "minus")
                            .frame(width: 30, height: 30)
                            .background(.white)

                    }
                }
            }
        }
        
    }
    
    
    
    
    
    private func zoomIn() {
       region.span.latitudeDelta /= 2.0
       region.span.longitudeDelta /= 2.0
   }

   private func zoomOut() {
       region.span.latitudeDelta *= 2.0
       region.span.longitudeDelta *= 2.0
   }
}
