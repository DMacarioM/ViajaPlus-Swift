//
//  ContentView.swift
//  Practica2App
//
//  Created by David Macario Matarredona on 3/12/23.
//

import SwiftUI
import SwiftData
//import FirebaseAuth

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @Binding var userLogged: Usuario
    @State private var showAlert = false
    @State private var errorText = ""
    //@Environment(\.dismiss) var dismiss
    @State private var selection: Int? = nil
    
    @State private var username = "" //(TODO: Singleton)
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingLoginScreen = false
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.blue.ignoresSafeArea()
                Circle().scale(1.7).foregroundColor(.white.opacity(0.15))
                Circle().scale(1.35).foregroundColor(.white)
                VStack{
                    Text("Login").font(.largeTitle).bold().padding()
                    TextField("Username", text: $username).padding().frame(width: 300,height: 50).background(Color.black.opacity(0.05)).cornerRadius(10).border(.red,width: CGFloat(wrongUsername))
                    SecureField("Password", text: $password).padding().frame(width: 300,height: 50).background(Color.black.opacity(0.05)).cornerRadius(10).border(.red,width: CGFloat(wrongPassword))
                    
                    HStack{
                        
                        NavigationLink(destination: RegisterView()) {
                            Text("Register")
                        }.foregroundColor(.white).frame(width: 150.0,height: 50).background(Color.blue).cornerRadius(10)
                        
                        
                        Button("Login"){
                            
                            performLogin()

                            
                        }.foregroundColor(.white).frame(width: 159.0,height: 50).background(Color.blue).cornerRadius(10).alert(isPresented: $showAlert) {
                            Alert(title: Text("Error"), message: Text("\(errorText)"), dismissButton: .default(Text("OK")))
                        }
                    }.padding(10)
                }
            }
        }.navigationBarHidden(true)
    }
    
    
    func performLogin(){
        //Comprobar Strings
        //Auth user
        wrongPassword=0
        wrongUsername=0
        
        
        
        if username.isEmpty {
            showAlert = true
            errorText = "Empty Email"
            wrongUsername = 2
        } else if password.isEmpty {
            showAlert = true
            errorText = "Empty Password"
            wrongPassword = 2
        } else {
            authenticateUser(email: username, password: password)
        }
    }
    
    func authenticateUser(email:String, password:String){
        if(email.lowercased() == "admin") {
            wrongUsername = 0
            if(password.lowercased() == "admin"){
                wrongPassword = 0
                userLogged.nombre = username
                userLogged.contraseña = password
                isLoggedIn = true

                //dismiss()
            }else{
                //alert
                showAlert = true
                errorText = "Incorrect Password"
                wrongPassword = 2
            }
        }else{
            showAlert = true
            errorText = "Incorrect Username"
            wrongUsername = 2
        }
        
        
        /**
         Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                    if let error = error {
                        self.showAlert = true
                        self.errorText = error.localizedDescription
                        // Aquí puedes agregar lógica para manejar tipos específicos de errores
                    } else {
                        // Manejo del éxito del inicio de sesión
                        guard let user = authResult?.user else { return }
                        self.userLogged = Usuario(nombre: user.email ?? "No Email", contraseña: "")
                        self.isLoggedIn = true
                    }
                }
         */
    }
}

/**
 
#Preview {
    LoginView(isLoggedIn: .constant(false), userLogged: .constant(nil)    
        .modelContainer(for: Item.self, inMemory: true)
}
 */
