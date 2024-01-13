//
//  ContentView.swift
//  Practica2App
//
//  Created by David Macario Matarredona on 3/12/23.
//

import SwiftUI
import SwiftData
import Firebase

struct MainView: View {
    @State var isLoggedIn : Bool
    //TODO: ? cambiar a false o leer de systempreferences
    @State var userLogged = User(userId: "", email: "", password: "", displayName: "", profilePictureUrl: nil)
    //@State var userLogged = User(userId: "IORa4wRN39VuwjFGNEIB9RV0W053", email: "juanw@gmail.com", password: "123456", displayName: "Juan", profilePictureUrl: nil)

    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    //PERSISTENCIA DE DATOS
    init() {
        if let savedUserData = UserDefaults.standard.object(forKey: "userId") as? Data {
            if let decodedUser = try? JSONDecoder().decode(User.self, from: savedUserData) {
                self.userLogged = decodedUser
                self.isLoggedIn = true
                
                print("sessionPersistence FOUND + \(decodedUser)")
                print("\(userLogged)")
            } else {
                self.isLoggedIn = false
                
                print("sessionPersistence NOT FOUND")
            }
        } else {
            self.isLoggedIn = false
            
            print("sessionPersistence NOT FOUND")
        }
    }

    
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
                    
                            ProfileView(isLoggedIn: $isLoggedIn, userLogged: $userLogged)
                                .tabItem{
                                    Label("Profile", systemImage: "square.and.pencil")
                                        .foregroundColor(.white).tint(.gray)
                                }
                        }.alert(isPresented: $showingAlert) {
                            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                        }
            }
            
           
        } else {
            LoginView(isLoggedIn: $isLoggedIn, userLogged: $userLogged)
            
            
        }
    }
    
    
    //Logic, but not used here, it's on login success and logout button pasted
    func sessionPersistence() {
        if isLoggedIn {
            if let encoded = try? JSONEncoder().encode(userLogged) {
                UserDefaults.standard.set(encoded, forKey: "userId")
                print("sessionPersistence SAVED")
            }
        } else {
            UserDefaults.standard.removeObject(forKey: "userId")
            
            print("sessionPersistence REMOVED")
        }
    }

    
    
    
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .modelContainer(for: Item.self, inMemory: true)
    }
}
