//
//  ContentView.swift
//  Practica2App
//
//  Created by David Macario Matarredona on 3/12/23.
//

import SwiftUI
import SwiftData
import FirebaseAuth
import Firebase


struct LoginView: View {
    @State private var showAlert = false
    @State private var errorText = ""
    
    @State private var selection: Int? = nil
    
    @State private var email = ""
    @State private var password = ""
    
    @Binding var isLoggedIn: Bool
    @Binding var userLogged: User //Singleton
    
    //Variables para mostrar errores
    @State private var wrongEmail = 0
    @State private var wrongPassword = 0
    
    
    @State private var showRegisterView = false
    
    let db = Firestore.firestore()
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.blue.ignoresSafeArea()
                Circle().scale(1.7).foregroundColor(.white.opacity(0.15))
                Circle().scale(1.35).foregroundColor(.white)
                VStack{
                    Text("Login").font(.largeTitle).bold().padding()
                    TextField("Email", text: $email).padding().frame(width: 300,height: 50).background(Color.black.opacity(0.05)).cornerRadius(10).border(.red,width: CGFloat(wrongEmail))
                    SecureField("Password", text: $password).padding().frame(width: 300,height: 50).background(Color.black.opacity(0.05)).cornerRadius(10).border(.red,width: CGFloat(wrongPassword))
                    
                    HStack{
                        Button(action: {
                                    // Muestra la vista de registro
                                    self.showRegisterView = true
                                }){
                                    Text("Register")
                                }.foregroundColor(.white).frame(width: 150.0,height: 50).background(Color.blue).cornerRadius(10)
                                .sheet(isPresented: $showRegisterView) {
                                    RegisterView(isLoggedIn: $isLoggedIn, userLogged: $userLogged)
                                }
                        
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
        wrongEmail=0
        
        
        
        if email.isEmpty {
            showAlert = true
            errorText = "Empty Email"
            wrongEmail = 2
        } else if password.isEmpty {
            showAlert = true
            errorText = "Empty Password"
            wrongPassword = 2
        } else {
            authenticateUser(email: email, password: password)
        }
    }
    
    func authenticateUser(email:String, password:String){
        Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
            if let error = error {
                self.showAlert = true
                self.errorText = error.localizedDescription

                showAlert = true
                errorText = "Error en la autenticación"
            } else {
                // Manejo del éxito del inicio de sesión
                guard let user = authResult?.user else { return }
                self.isLoggedIn = true
                
                //Acceso a firebase Firestore para traer los datos del User
                db.collection("Users").whereField("userId", isEqualTo: user.uid)
                    .getDocuments() { (querySnapshot, err) in
                        if let err = err {
                            print("Error obteniendo documentos: \(err)")
                            showAlert = true
                            errorText = "Error al cargar el Usuario"
                            
                        } else {
                            for document in querySnapshot!.documents {
                                print("\(document.documentID) => \(document.data())")
                                let data = document.data()
                                
                                if let userId = data["userId"] as? String,
                                   let email = data["email"] as? String,
                                   let displayName = data["displayName"] as? String,
                                   let profilePictureUrl = data["profilePictureUrl"] as? String {
                                    self.userLogged = User(userId: userId, email: email, password: "", displayName: displayName, profilePictureUrl: profilePictureUrl)
                                }
                                
                                if let encoded = try? JSONEncoder().encode(userLogged) {
                                    UserDefaults.standard.set(encoded, forKey: "userId")
                                    print("sessionPersistence SAVED")
                                }
                                
                                self.isLoggedIn=true
                                
                                break
                            }
                        }
                    }
            }
        }
    }
}

 
#Preview {
    LoginView(isLoggedIn: .constant(false), userLogged: .constant(User(userId: "", email: "String", password: "String", displayName: "String", profilePictureUrl: nil)))
        .modelContainer(for: Item.self, inMemory: true)
}
 
