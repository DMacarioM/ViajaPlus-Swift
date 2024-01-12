//
//  ContentView.swift
//  Practica2App
//
//  Created by David Macario Matarredona on 3/12/23.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @State private var isLoggedIn = false //Se modifica con @Binding desde el login y register
    //TODO: ? cambiar a false o leer de systempreferences
    @State private var userLogged = User(userId: "", email: "", password: "", displayName: "", profilePictureUrl: nil)
    //@State private var userLogged = User(userId: "IORa4wRN39VuwjFGNEIB9RV0W053", email: "juanw@gmail.com", password: "123456", displayName: "Juan", profilePictureUrl: nil)

    
    var body: some View {
        if isLoggedIn {
            NavigationStack{
                
                TabView {
                            
                    HomeView(userLogged: $userLogged)
                                .tabItem {
                                    Label("Home", systemImage: "list.dash")
                                        .foregroundColor(.white).tint(.gray)
                                }

                            MyTripsView(userLogged: $userLogged)
                                .tabItem {
                                    Label("My Trips", systemImage: "square.and.pencil")
                                        .foregroundColor(.white).tint(.gray)
                                }
                    
                            ProfileView(userLogged: $userLogged)
                                .tabItem{
                                    Label("Profile", systemImage: "square.and.pencil")
                                        .foregroundColor(.white).tint(.gray)
                                }
                        }
            }
           
        } else {
            LoginView(isLoggedIn: $isLoggedIn, userLogged: $userLogged)
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .modelContainer(for: Item.self, inMemory: true)
    }
}
