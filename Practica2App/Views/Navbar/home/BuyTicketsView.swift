//
//  BuyTicketsView.swift
//  Practica2App
//
//  Created by RonaldRis on 12/1/24.
//
import SwiftUI

struct BuyTicketsView: View {
    var tickets: [Ticket]
    @Environment(\.presentationMode) var presentationMode //util para regresar a la pantalla anterior

    
    @State private var showAlert = false
    
    var totalPrice: Double {
        tickets.reduce(0) { $0 + $1.price }
    }
    
    var body: some View {
        VStack {
            List(tickets) { ticket in
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Fecha de viaje: \(ticket.travelDate, formatter: itemFormatter)")
                        .font(.headline)
                        .bold()
                    
                    HStack {
                        VStack(alignment: .leading) {
                            Text(ticket.departureTime, formatter: timeFormatter)
                                .font(.title2)
                                .bold()
                            Text(ticket.originCity)
                                .font(.subheadline)
                        }
                        
                        Spacer()
                        
                        Text(">")
                            .font(.title)
                            .bold()
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text(ticket.arrivalTime, formatter: timeFormatter)
                                .font(.title2)
                                .bold()
                            Text(ticket.destinationCity)
                                .font(.subheadline)
                        }
                    }
                    
                    Text("Costo €\(ticket.price, specifier: "%.2f")")
                        .bold()
                }
                .padding()
            }
            
            HStack {
                Spacer()
                Text("Total: €\(totalPrice, specifier: "%.2f")")
                    .bold()
                    .font(.title)
                Spacer()
            }
            
            Button("Confirmar compra") {
                tickets.forEach { ticketItem in
                    FirebaseTicketsService().uploadTicket(ticket: ticketItem)
                }
                showAlert = true
            }
            .font(.title)
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(10)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Compra realizada"),
                      message: Text("Los tickets han sido comprados correctamente."),
                      dismissButton: .default(Text("OK")) {
                          self.presentationMode.wrappedValue.dismiss()
                      })
            }
        }
        .navigationBarTitle("Comprar Tickets")
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    return formatter
}()

private let timeFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    return formatter
}()
