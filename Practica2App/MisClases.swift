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

