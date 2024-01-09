//
//  Ticket.swift
//  Practica2App
//
//  Created by RonaldRis on 9/1/24.
//

import Foundation

struct Ticket {
    let ticketId: String
    let userId: String
    let purchaseDate: Date
    let travelDate: Date

    let originCity: String
    let destinationCity: String
    let departureTime: Date
    let arrivalTime: Date
    let price: Double

    init(ticketId: String, userId: String, purchaseDate: Date, travelDate: Date, originCity: String, destinationCity: String, departureTime: Date, arrivalTime: Date, price: Double) {
        self.ticketId = ticketId
        self.userId = userId
        self.purchaseDate = purchaseDate
        self.travelDate = travelDate

        self.originCity = originCity
        self.destinationCity = destinationCity
        self.departureTime = departureTime
        self.arrivalTime = arrivalTime
        self.price = price
    }
    
    
    func description() -> String {
            return "Ticket ID: \(ticketId), User ID: \(userId), Purchase Date: \(purchaseDate), Travel Date: \(travelDate), Origin City: \(originCity), Destination City: \(destinationCity), Departure Time: \(departureTime), Arrival Time: \(arrivalTime), Price: \(price)"
        }
}
