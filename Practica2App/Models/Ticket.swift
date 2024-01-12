//
//  Ticket.swift
//  Practica2App
//
//  Created by RonaldRis on 9/1/24.			
//

import Foundation

struct Ticket : Identifiable, Codable, Hashable {
    
    let id: String // Conform to Identifiable
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
        self.id = ticketId

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
    
    func descriptionMini() -> String {
        return "from \(originCity) to \(destinationCity) on \(travelDate)"
    }
    
    
    func getJsonString() -> String {
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601 // Use ISO8601 format for dates

        do {
            let jsonData = try encoder.encode(self.ticketId)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
                return jsonString
            }
        } catch {
            print(error)
        }
        return "{}"
    }
}
