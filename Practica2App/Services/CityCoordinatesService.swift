//
//  CoordinatesService.swift
//  Practica2App
//
//  Created by RonaldRis on 12/1/24.
//

import Foundation
import MapKit

struct CityCoordinates : Identifiable{
    let id : UUID
    let name : String
    let coordinate: CLLocationCoordinate2D

    init(ciudad: String, latitude: Double, longitude: Double) {
        self.id = UUID()
        self.name = ciudad
        self.coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
    }
}


class CityCoordinatesService{
    
    func getCities (searchCity: String)  -> CityCoordinates
    {
        let murciaCoordinates = CityCoordinates(ciudad: "Murcia", latitude: 37.9922, longitude: -1.1307)
        let alicanteCoordinates = CityCoordinates(ciudad: "Alicante", latitude: 38.3452, longitude: -0.4810)
        let valenciaCoordinates = CityCoordinates(ciudad: "Valencia", latitude: 39.4699, longitude: -0.3763)
        let granadaCoordinates = CityCoordinates(ciudad: "Granada", latitude: 37.1773, longitude: -3.5986)

        let citiesCoordinatesDictionary = [
            "Murcia": murciaCoordinates,
            "Alicante": alicanteCoordinates,
            "Valencia": valenciaCoordinates,
            "Granada": granadaCoordinates
        ]
        
        return citiesCoordinatesDictionary[searchCity]!
        
    }
}


