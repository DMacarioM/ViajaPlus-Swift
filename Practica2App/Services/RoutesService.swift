//
//  RoutesService.swift
//  Practica2App
//
//  Created by RonaldRis on 9/1/24.
//

import Foundation

class RoutesService {
    static let shared = RoutesService()
    var routes: [Route] = []
    private var routesOrderByCheaper: [Route] = []

    init() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

        // Añadir rutas
        
        routes.append(Route(routeId: 1, originCity: "Murcia", destinationCity: "Alicante", departureTime: dateFormatter.date(from: "08:00")!, arrivalTime: dateFormatter.date(from: "10:30")!, price: 25.50))
        routes.append(Route(routeId: 2, originCity: "Alicante", destinationCity: "Murcia", departureTime: dateFormatter.date(from: "16:00")!, arrivalTime: dateFormatter.date(from: "18:30")!, price: 25.50))
        routes.append(Route(routeId: 3, originCity: "Alicante", destinationCity: "Valencia", departureTime: dateFormatter.date(from: "09:15")!, arrivalTime: dateFormatter.date(from: "11:45")!, price: 30.00))
        routes.append(Route(routeId: 4, originCity: "Valencia", destinationCity: "Alicante", departureTime: dateFormatter.date(from: "16:00")!, arrivalTime: dateFormatter.date(from: "18:30")!, price: 30.00))
        routes.append(Route(routeId: 5, originCity: "Murcia", destinationCity: "Granada", departureTime: dateFormatter.date(from: "07:30")!, arrivalTime: dateFormatter.date(from: "11:00")!, price: 40.75))
        routes.append(Route(routeId: 6, originCity: "Granada", destinationCity: "Murcia", departureTime: dateFormatter.date(from: "16:30")!, arrivalTime: dateFormatter.date(from: "20:00")!, price: 40.75))
        routes.append(Route(routeId: 7, originCity: "Valencia", destinationCity: "Murcia", departureTime: dateFormatter.date(from: "21:30")!, arrivalTime: dateFormatter.date(from: "23:45")!, price: 40.75))
        routes.append(Route(routeId: 8, originCity: "Murcia", destinationCity: "Valencia", departureTime: dateFormatter.date(from: "02:00")!, arrivalTime: dateFormatter.date(from: "04:15")!, price: 40.75))
        routes.append(Route(routeId: 9, originCity: "Alicante", destinationCity: "Valencia", departureTime: dateFormatter.date(from: "12:45")!, arrivalTime: dateFormatter.date(from: "15:15")!, price: 30.00))
        routes.append(Route(routeId: 10, originCity: "Valencia", destinationCity: "Alicante", departureTime: dateFormatter.date(from: "18:00")!, arrivalTime: dateFormatter.date(from: "20:30")!, price: 30.00))
        routes.append(Route(routeId: 11, originCity: "Murcia", destinationCity: "Alicante", departureTime: dateFormatter.date(from: "05:30")!, arrivalTime: dateFormatter.date(from: "08:00")!, price: 25.50))
        routes.append(Route(routeId: 12, originCity: "Alicante", destinationCity: "Murcia", departureTime: dateFormatter.date(from: "13:00")!, arrivalTime: dateFormatter.date(from: "15:30")!, price: 25.50))
        routes.append(Route(routeId: 13, originCity: "Alicante", destinationCity: "Valencia", departureTime: dateFormatter.date(from: "10:30")!, arrivalTime: dateFormatter.date(from: "12:00")!, price: 30.00))
        routes.append(Route(routeId: 14, originCity: "Valencia", destinationCity: "Alicante", departureTime: dateFormatter.date(from: "14:30")!, arrivalTime: dateFormatter.date(from: "17:00")!, price: 30.00))
        routes.append(Route(routeId: 15, originCity: "Murcia", destinationCity: "Valencia", departureTime: dateFormatter.date(from: "21:45")!, arrivalTime: dateFormatter.date(from: "00:15")!, price: 30.00))
        routes.append(Route(routeId: 16, originCity: "Valencia", destinationCity: "Murcia", departureTime: dateFormatter.date(from: "02:30")!, arrivalTime: dateFormatter.date(from: "05:00")!, price: 30.00))
        routes.append(Route(routeId: 17, originCity: "Alicante", destinationCity: "Granada", departureTime: dateFormatter.date(from: "09:00")!, arrivalTime: dateFormatter.date(from: "12:00")!, price: 40.75))
        routes.append(Route(routeId: 18, originCity: "Granada", destinationCity: "Alicante", departureTime: dateFormatter.date(from: "14:30")!, arrivalTime: dateFormatter.date(from: "17:30")!, price: 40.75))
        routes.append(Route(routeId: 19, originCity: "Murcia", destinationCity: "Granada", departureTime: dateFormatter.date(from: "05:45")!, arrivalTime: dateFormatter.date(from: "09:15")!, price: 50.25))
        routes.append(Route(routeId: 20, originCity: "Granada", destinationCity: "Murcia", departureTime: dateFormatter.date(from: "14:00")!, arrivalTime: dateFormatter.date(from: "17:30")!, price: 50.25))
        routes.append(Route(routeId: 21, originCity: "Valencia", destinationCity: "Alicante", departureTime: dateFormatter.date(from: "06:15")!, arrivalTime: dateFormatter.date(from: "08:45")!, price: 35.75))
        routes.append(Route(routeId: 22, originCity: "Alicante", destinationCity: "Valencia", departureTime: dateFormatter.date(from: "15:30")!, arrivalTime: dateFormatter.date(from: "18:00")!, price: 35.75))
        routes.append(Route(routeId: 23, originCity: "Murcia", destinationCity: "Valencia", departureTime: dateFormatter.date(from: "09:30")!, arrivalTime: dateFormatter.date(from: "12:00")!, price: 45.50))
        routes.append(Route(routeId: 24, originCity: "Valencia", destinationCity: "Murcia", departureTime: dateFormatter.date(from: "17:45")!, arrivalTime: dateFormatter.date(from: "20:15")!, price: 45.50))
        routes.append(Route(routeId: 25, originCity: "Alicante", destinationCity: "Murcia", departureTime: dateFormatter.date(from: "05:30")!, arrivalTime: dateFormatter.date(from: "08:00")!, price: 20.00))
        routes.append(Route(routeId: 26, originCity: "Murcia", destinationCity: "Alicante", departureTime: dateFormatter.date(from: "14:00")!, arrivalTime: dateFormatter.date(from: "16:30")!, price: 20.00))
        routes.append(Route(routeId: 27, originCity: "Valencia", destinationCity: "Granada", departureTime: dateFormatter.date(from: "09:00")!, arrivalTime: dateFormatter.date(from: "12:00")!, price: 35.75))
        routes.append(Route(routeId: 28, originCity: "Granada", destinationCity: "Valencia", departureTime: dateFormatter.date(from: "14:30")!, arrivalTime: dateFormatter.date(from: "17:30")!, price: 35.75))
        routes.append(Route(routeId: 29, originCity: "Murcia", destinationCity: "Granada", departureTime: dateFormatter.date(from: "06:30")!, arrivalTime: dateFormatter.date(from: "09:15")!, price: 45.50))
        routes.append(Route(routeId: 30, originCity: "Granada", destinationCity: "Murcia", departureTime: dateFormatter.date(from: "15:00")!, arrivalTime: dateFormatter.date(from: "17:45")!, price: 45.50))
        routes.append(Route(routeId: 31, originCity: "Alicante", destinationCity: "Valencia", departureTime: dateFormatter.date(from: "07:45")!, arrivalTime: dateFormatter.date(from: "10:45")!, price: 25.50))
        routes.append(Route(routeId: 32, originCity: "Valencia", destinationCity: "Alicante", departureTime: dateFormatter.date(from: "16:00")!, arrivalTime: dateFormatter.date(from: "18:30")!, price: 25.50))
        routes.append(Route(routeId: 33, originCity: "Valencia", destinationCity: "Murcia", departureTime: dateFormatter.date(from: "12:00")!, arrivalTime: dateFormatter.date(from: "14:30")!, price: 20.00))
        routes.append(Route(routeId: 34, originCity: "Murcia", destinationCity: "Valencia", departureTime: dateFormatter.date(from: "20:00")!, arrivalTime: dateFormatter.date(from: "22:30")!, price: 20.00))
        routes.append(Route(routeId: 35, originCity: "Alicante", destinationCity: "Granada", departureTime: dateFormatter.date(from: "08:00")!, arrivalTime: dateFormatter.date(from: "10:30")!, price: 40.75))
        routes.append(Route(routeId: 36, originCity: "Granada", destinationCity: "Alicante", departureTime: dateFormatter.date(from: "16:00")!, arrivalTime: dateFormatter.date(from: "18:30")!, price: 40.75))
        routes.append(Route(routeId: 37, originCity: "Valencia", destinationCity: "Alicante", departureTime: dateFormatter.date(from: "13:00")!, arrivalTime: dateFormatter.date(from: "15:30")!, price: 30.00))
        routes.append(Route(routeId: 38, originCity: "Alicante", destinationCity: "Valencia", departureTime: dateFormatter.date(from: "19:15")!, arrivalTime: dateFormatter.date(from: "21:45")!, price: 30.00))
        routes.append(Route(routeId: 39, originCity: "Murcia", destinationCity: "Alicante", departureTime: dateFormatter.date(from: "10:45")!, arrivalTime: dateFormatter.date(from: "13:15")!, price: 45.50))
        routes.append(Route(routeId: 40, originCity: "Alicante", destinationCity: "Murcia", departureTime: dateFormatter.date(from: "18:30")!, arrivalTime: dateFormatter.date(from: "21:00")!, price: 45.50))
        routes.append(Route(routeId: 41, originCity: "Alicante", destinationCity: "Murcia", departureTime: dateFormatter.date(from: "00:15")!, arrivalTime: dateFormatter.date(from: "02:45")!, price: 40.75))
        routes.append(Route(routeId: 42, originCity: "Murcia", destinationCity: "Alicante", departureTime: dateFormatter.date(from: "05:00")!, arrivalTime: dateFormatter.date(from: "07:30")!, price: 40.75))
        routes.append(Route(routeId: 43, originCity: "Valencia", destinationCity: "Murcia", departureTime: dateFormatter.date(from: "21:00")!, arrivalTime: dateFormatter.date(from: "23:30")!, price: 30.00))
        routes.append(Route(routeId: 44, originCity: "Murcia", destinationCity: "Valencia", departureTime: dateFormatter.date(from: "02:45")!, arrivalTime: dateFormatter.date(from: "05:15")!, price: 30.00))
        routes.append(Route(routeId: 45, originCity: "Alicante", destinationCity: "Valencia", departureTime: dateFormatter.date(from: "12:00")!, arrivalTime: dateFormatter.date(from: "14:30")!, price: 35.75))
        routes.append(Route(routeId: 46, originCity: "Valencia", destinationCity: "Alicante", departureTime: dateFormatter.date(from: "18:30")!, arrivalTime: dateFormatter.date(from: "21:00")!, price: 35.75))
        routes.append(Route(routeId: 47, originCity: "Murcia", destinationCity: "Alicante", departureTime: dateFormatter.date(from: "03:30")!, arrivalTime: dateFormatter.date(from: "06:00")!, price: 50.25))
        routes.append(Route(routeId: 48, originCity: "Alicante", destinationCity: "Murcia", departureTime: dateFormatter.date(from: "16:30")!, arrivalTime: dateFormatter.date(from: "19:00")!, price: 50.25))

        routes = routes.sorted(by: { $0.departureTime < $1.departureTime })
        
        routesOrderByCheaper = routes.sorted(by: { $0.price < $1.price })

        
        // Repetir para cada ruta...
        // Se omite agregar todas las rutas para brevedad.
    }

    func getRoutes(sorterType: String, startCity:String, endCity:String) -> [Route] {
        return sorterType == "Cheaper" ? getRoutesOrderByPrice(startCity: startCity, endCity: endCity) : getRoutesOrderByDepartureTime(startCity: startCity, endCity: endCity)
    }
    
    func getRoutesOrderByDepartureTime(startCity:String, endCity:String) -> [Route]{
        return routes.filter { $0.originCity == startCity && $0.destinationCity == endCity }

    }
    
    func getRoutesOrderByPrice(startCity:String, endCity:String) -> [Route]{
        return routesOrderByCheaper.filter { $0.originCity == startCity && $0.destinationCity == endCity }

    }

    // Método auxiliar para crear una fecha (ignorar zona horaria por simplicidad)
    private func createTime(hour: Int, minute: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.hour = hour
        dateComponents.minute = minute
        return Calendar.current.date(from: dateComponents)!
    }
}
