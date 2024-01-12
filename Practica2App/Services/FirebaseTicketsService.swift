//
//  FirebaseTicketsService.swift
//  Practica2App
//
//  Created by RonaldRis on 12/1/24.
//


import Foundation
import FirebaseFirestore
import SwiftUI
import FirebaseFirestore
import FirebaseFirestoreSwift


class FirebaseTicketsService {
    private let db = Firestore.firestore()
    
    // This function uploads a ticket to Firestore
    func uploadTicket( ticket: Ticket) {
        
        print(ticket.description())
        
        db.collection("Tickets").addDocument(data:[
            "tickedId": UUID().uuidString,
            "userId": ticket.userId,
            "purchaseDate": ticket.purchaseDate.timeIntervalSince1970,
            "travelDate": ticket.travelDate.timeIntervalSince1970, //para convertirlo a milisegundos porque asi funciona en kotlin
            "originCity": ticket.originCity,
            "destinationCity": ticket.destinationCity,
            "departureTime": ticket.departureTime,
            "arrivalTime": ticket.arrivalTime,
            "price": ticket.price
        ]) { error in
            if let error = error {
                print("Error uploading ticket: \(error.localizedDescription)")
            } else {
                print("Ticket successfully uploaded!")
            }
        }
    }
    
    
    // This function downloads all tickets and stores them in a given state array
    func downloadAllTickets(userId:String, completion: @escaping ([Ticket]) -> Void) {
        db.collection("Tickets").whereField("userId", isEqualTo: userId).getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error getting all tickets: \(error.localizedDescription)")
                completion([])
            } else {
                var tickets: [Ticket] = []
                for document in querySnapshot!.documents {
                    let data = document.data()
                    
                    let purchaseTimestamp = data["purchaseDate"] as? TimeInterval ?? 0
                    let purchaseDate = Date(timeIntervalSince1970: purchaseTimestamp)

                    let travelTimestamp = data["travelDate"] as? TimeInterval ?? 0
                    let travelDate = Date(timeIntervalSince1970: travelTimestamp)

                    let id: UUID = data["ticketId"] as? UUID ?? UUID()

                    
                    let ticket = Ticket(
                        ticketId: id.uuidString,
                        userId: data["userId"] as? String ?? "",
                        purchaseDate: purchaseDate,
                        travelDate: travelDate,
                        originCity: data["originCity"] as? String ?? "",
                        destinationCity: data["destinationCity"] as? String ?? "",
                        departureTime: (data["departureTime"] as? Timestamp)?.dateValue() ?? Date(),
                        arrivalTime: (data["arrivalTime"] as? Timestamp)?.dateValue() ?? Date(),
                        price: data["price"] as? Double ?? 0
                    )
                    tickets.append(ticket)
                }
                
                tickets = tickets.sorted(by: { $0.travelDate > $1.travelDate })
                
                print("FIREBASE GET QUERY")
                tickets.forEach{
                    ticke in print(ticke.description())
                }

                completion(tickets)
            }
        }
    }
}
