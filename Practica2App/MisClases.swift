//
//  MyClasses.swift
//  Practica1Tests
//
//  Created by David Macario Matarredona on 19/11/23.
//
import Foundation

// Enumeración para representar el tema de la interfaz de usuario
enum Tema {
    case DIA, NOCHE
}

// Enumeración para representar el estado del usuario
enum Estado {
    case ACTIVO, INACTIVO
}

// Clase para representar a un usuario
class Usuario {
    var nombre: String  // Nombre del usuario
    var email: String  // Email del usuario
    var contraseña: String  // Contraseña del usuario
    var urlAttribute: String?  // URL opcional asociada al usuario
    var tema: Tema  // Tema de la interfaz de usuario del usuario
    var estado: Estado  // Estado del usuario

    // Inicializador de la clase Usuario
    init(nombre: String, email: String, contraseña: String) {
        self.nombre = nombre
        self.email = email
        self.contraseña = contraseña
        self.estado = .ACTIVO
        self.tema = .DIA
    }
    
    // Método para establecer la URL del usuario
    func setUrl(url: String) {
        self.urlAttribute = url
    }
    
    // Método para eliminar la URL del usuario
    func removeUrl() {
        self.urlAttribute = nil
    }
    
    // Método para establecer el estado del usuario
    func setEstado(estadoAttribute: Estado) {
        self.estado = estadoAttribute
    }
    
    // Método para establecer el tema de la interfaz de usuario del usuario
    func setTema(temaAttribute: Tema) {
        self.tema = temaAttribute
    }
}

// Clase para representar un ticket de viaje
class Ticket {
    var usuario: Usuario  // Usuario asociado al ticket
    var origen: String  // Origen del viaje
    var destino: String  // Destino del viaje
    var fecha: Date  // Fecha del viaje
    var hora: String  // Hora del viaje
    var asiento: Int  // Número de asiento

    // Inicializador de la clase Ticket
    init(usuario: Usuario, origen: String, destino: String, fecha: Date, hora: String, asiento: Int) {
        self.usuario = usuario
        self.origen = origen
        self.destino = destino
        self.fecha = fecha
        self.hora = hora
        self.asiento = asiento
    }
}

// Clase para representar una colección de tickets
class Tickets {
    var listaTickets: [Ticket]  // Lista de tickets

    // Inicializador de la clase Tickets
    init(listaTickets: [Ticket]) {
        self.listaTickets = listaTickets
    }

    // Método para añadir un ticket a la lista
    func añadir(ticket: Ticket) {
        self.listaTickets.append(ticket)
    }

    // Método para eliminar un ticket de la lista
    func eliminar(ticket: Ticket) {
        self.listaTickets = self.listaTickets.filter { $0 !== ticket }
    }

    // Método para obtener un ticket de la lista por su índice
    func obtener(index: Int) -> Ticket? {
        return self.listaTickets.indices.contains(index) ? self.listaTickets[index] : nil
    }

    // Método para obtener la longitud de la lista de tickets
    func longitud() -> Int {
        return self.listaTickets.count
    }
}

// Clase para representar un viaje
class Viaje {
    var usuario: Usuario  // Usuario que realiza el viaje
    var ticket: Ticket  // Ticket asociado al viaje

    // Inicializador de la clase Viaje
    init(usuario: Usuario, ticket: Ticket) {
        self.usuario = usuario
        self.ticket = ticket
    }

    // Método para imprimir los detalles del viaje
    func imprimirDetalles() -> String {
        var text: String
        text="Detalles del viaje: \n"
        text+="Usuario: \(usuario.nombre)\n"
        switch usuario.estado {
        case .ACTIVO:
            text+="Ususario: Estado - Activo\n"
        case .INACTIVO:
            text+="Ususario: Estado - Inactivo\n"
        }
        switch usuario.tema {
        case .DIA:
            text+="Ususario: Tema - Dia\n"
        case .NOCHE:
            text+="Ususario: Tema - Noche\n"
        }
        text+="Ticket: Origen - \(ticket.origen), Destino - \(ticket.destino)"
        return text
    }
}
