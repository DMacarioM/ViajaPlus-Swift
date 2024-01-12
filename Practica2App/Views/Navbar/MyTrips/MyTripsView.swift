//
//  MyTripsView.swift
//  Practica2App
//
//  Created by RonaldRis on 9/1/24.
//
import SwiftUI

struct MyTripsView: View {
    
    @Binding var userLogged: User
    @State private var tickets: [Ticket] = []
    
    @State var isPresented: Bool = false

    var body: some View {
        NavigationView {
            List(tickets) { ticket in
                NavigationLink(destination: TicketQrView(ticket: ticket)) {
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
                        HStack {
                            Text("Costo €\(ticket.price, specifier: "%.2f")")
                                .bold()
                            
                            Spacer()
                            
                            StatusChipView(travelDate: ticket.travelDate, departureTime: ticket.departureTime)
                        }
                    }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.gray, lineWidth: 1))
                .padding(.vertical, 4)
            }
            .navigationTitle(tickets.count > 0 ?  "My Trips" : "no trips yet")
            .onAppear {
                FirebaseTicketsService().downloadAllTickets(userId: userLogged.userId) { downloadedTickets in
                    self.tickets = downloadedTickets
                }
            }
            .refreshable {
                FirebaseTicketsService().downloadAllTickets(userId: userLogged.userId) { downloadedTickets in
                    self.tickets = downloadedTickets
                }
            }
        }
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




struct StatusChipView: View {
    var travelDate: Date
    var departureTime: Date
    
    
    func calculateMinutesSinceMidnight(from date: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: date)
        let hours = components.hour ?? 0
        let minutes = components.minute ?? 0
        return hours * 60 + minutes
    }
    
    
    
    private var statusColor: Color {
        let current = Date()
        let calendar = Calendar.current
        
        if calendar.isDateInToday(travelDate), calculateMinutesSinceMidnight(from:departureTime) > calculateMinutesSinceMidnight(from: current) {
            return Color.green.opacity(0.3)
        } else if current > travelDate {
            return Color.red.opacity(0.3)
        } else {
            return Color.clear
        }
    }
    
    private var statusText: String {
        let current = Date()
        let calendar = Calendar.current
        
        print("")
        print(["travelDate",travelDate])
        print(["departure",departureTime])
        print(["current",current])
        print(["calendar",calendar])
        print(["istodayDate",calendar.isDateInToday(travelDate)])
        print(["travelDate",travelDate])
        
        if calendar.isDateInToday(travelDate), calculateMinutesSinceMidnight(from:departureTime) > calculateMinutesSinceMidnight(from: current) {
            return "ON TIME"
        } else if current > travelDate {
            return "OLD"
        } else {
            return ""
        }
        
        
    }
    
    var body: some View {
        Text(statusText)
            .foregroundColor(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(statusColor)
            .cornerRadius(8)
    }
}
