//
//  ContentView.swift
//  Practica2App
//
//  Created by David Macario Matarredona on 3/12/23.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @State private var isLoggedIn = true //TODO: cambiar a false o leer de systempreferences
    @State private var userLogger = Usuario(nombre: "Ronald", email: "Ris@example.com", contraseña: "123456")

    
    var body: some View {
        if isLoggedIn {
            TabView {
                        
                HomeView(userLogged: $userLogger)
                            .tabItem {
                                Label("Home", systemImage: "list.dash")
                                    .foregroundColor(.white).tint(.gray)
                            }

                        SelectRouteView()
                            .tabItem {
                                Label("My Trips", systemImage: "square.and.pencil")
                                    .foregroundColor(.white).tint(.gray)
                            }
                
                        ProfileView()
                            .tabItem{
                                Label("Profile", systemImage: "square.and.pencil")
                                    .foregroundColor(.white).tint(.gray)
                            }
                    }
           
        } else {
            LoginView(isLoggedIn: $isLoggedIn, userLogged: $userLogger)
        }
    }
    
    
    
    
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .modelContainer(for: Item.self, inMemory: true)
    }
}
