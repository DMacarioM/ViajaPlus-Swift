//
//  ContentView.swift
//  Practica2App
//
//  Created by David Macario Matarredona on 3/12/23.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @State private var isLoggedIn = false

    var body: some View {
        if isLoggedIn {
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                Text(generateData())
            }
        } else {
            LoginView(isLoggedIn: $isLoggedIn)
        }
    }
    
    /// Función de prueba que crea un usuario, un ticket, una colección de tickets, y un viaje.
    private func generateData() -> String {
        // Crear un usuario
        let usuario = Usuario(nombre: "Juan", email: "juan@example.com", contraseña: "123456")
        // Establecer el estado del usuario a ACTIVO
        usuario.setEstado(estadoAttribute: .ACTIVO)
        // Establecer el tema del usuario a DIA
        usuario.setTema(temaAttribute: .DIA)

        // Crear un ticket
        let fecha = Date()
        let ticket = Ticket(usuario: usuario, origen: "Murcia", destino: "Madrid", fecha: fecha, hora: "10:00", asiento: 15)

        // Crear una colección de tickets y añadir el ticket
        let tickets = Tickets(listaTickets: [])
        tickets.añadir(ticket: ticket)

        // Crear un viaje
        let viaje = Viaje(usuario: usuario, ticket: ticket)

        // Imprimir los detalles del viaje
        return viaje.imprimirDetalles()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .modelContainer(for: Item.self, inMemory: true)
    }
}
