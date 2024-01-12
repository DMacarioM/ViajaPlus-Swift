//
//  TicketQrView.swift
//  Practica2App
//
//  Created by RonaldRis on 12/1/24.
//
import SwiftUI
import QRCode // Make sure to import the library
import SwiftUI
import QRCode

struct TicketQrView: View {
    let ticket: Ticket
    @State private var showingMap = false
    @State private var showMap = false

    var body: some View {
        ScrollView {
            VStack {
                // Display ticket details
                Text("Fecha de viaje: \(ticket.travelDate, formatter: itemFormatter)")
                Text("Hora de salida: \(ticket.departureTime, formatter: timeFormatter)")
                Text("Origen: \(ticket.originCity)")
                // More ticket details here...

                // Display QR Code
                if let qrImage = generateQRCode(ticket: ticket) {
                    Image(uiImage: qrImage)
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 350)
                } else {
                    Image(systemName: "xmark.circle")
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 350, height: 350)
                }

                // Checkbox
                Toggle("Mostrar en mapa", isOn: $showMap)
                    .padding()
                
                // MapView (conditional based on the checkbox)
                if showMap {
                    MapView(ticket: ticket)
                        .frame(height: UIScreen.main.bounds.height * 0.6) // Max 60% of the screen height
                }
            }
        }
    }
    
    func generateQRCode(ticket: Ticket) -> UIImage? {
        let qrCodeF = QRCode(string: ticket.descriptionMini(),
                             color: UIColor.white,
                             backgroundColor: UIColor.black,
                             size: CGSize(width: 350, height: 350)
                            )
        
        return qrCodeF?.unsafeImage
    }
}

// Resto del código de MapView...


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
