//
//  ContentView.swift
//  Practica2App
//
//  Created by David Macario Matarredona on 3/12/23.
//

import SwiftUI
import SwiftData

import Firebase
import FirebaseAuth

//Referencia a la base de datos
let db = Firestore.firestore()

struct RegisterView: View {
    @Binding var isLoggedIn: Bool
    @Binding var userLogged: User
    
    @State private var showAlert = false
    @State private var errorText = ""
    @Environment(\.dismiss) var dismiss
    
    @State private var username = "" //(TODO: Singleton)
    @State private var password = ""
    @State private var retypedpassword = ""
    @State private var email = ""
    
    //Variables para mostrar errores
    @State private var wrongUsername = 0
    @State private var wrongEmail = 0
    @State private var wrongPassword = 0
    @State private var wrongRetypedPassword = 0
    
    //Bool para navegar al MainView
    @State private var shouldShowMainView = false

    var body: some View {
        NavigationView{
            ZStack{
                Color.blue.ignoresSafeArea()
                Circle().scale(1.7).foregroundColor(.white.opacity(0.15))
                Circle().scale(1.35).foregroundColor(.white)
                VStack{
                    Text("Register").font(.largeTitle).bold().padding()
                    TextField("Username", text: $username).padding().frame(width: 300,height: 50).background(Color.black.opacity(0.05)).cornerRadius(10).border(.red,width: CGFloat(wrongUsername))
                    TextField("Email", text: $email).padding().frame(width: 300,height: 50).background(Color.black.opacity(0.05)).cornerRadius(10).border(.red,width: CGFloat(wrongEmail))
                    SecureField("Password", text: $password).padding().frame(width: 300,height: 50).background(Color.black.opacity(0.05)).cornerRadius(10).border(.red,width: CGFloat(wrongPassword))
                    SecureField("Retype Password", text: $retypedpassword).padding().frame(width: 300,height: 50).background(Color.black.opacity(0.05)).cornerRadius(10).border(.red,width: CGFloat(wrongRetypedPassword))
                    
                    HStack{
                        Button("Go Back"){
                            dismiss()
                        }.padding(15)
                        Button("Register"){
                            //Comprobar Strings
                            // Check if the fields are not empty
                            if username.isEmpty || password.isEmpty || retypedpassword.isEmpty || email.isEmpty {
                                self.errorText = "All fields must be filled"
                                self.showAlert = true
                            }
                            // Check if the username is valid
                            else if (!usernameIsValid(username: username)) {
                                self.errorText = "Invalid username"
                                self.showAlert = true
                                self.wrongUsername = 1
                            }
                            // Check if the email is valid
                            else if (!emailIsValid(email: email)) {
                                self.errorText = "Invalid email"
                                self.showAlert = true
                                self.wrongEmail = 1
                                self.wrongUsername = 0
                            }
                            // Check if the password is valid
                            else if(!passwordIsValid(password: password)){
                                self.errorText = "Password is invalid"
                                self.showAlert = true
                                self.wrongPassword = 1
                                self.wrongEmail = 0
                                self.wrongUsername = 0
                            }
                            // Check if the passwords match
                            else if (password != retypedpassword) {
                                self.errorText = "Passwords do not match"
                                self.showAlert = true
                                self.wrongPassword = 1
                                self.wrongRetypedPassword=1
                                self.wrongEmail = 0
                                self.wrongUsername = 0
                            }
                            // If all checks pass, create the user
                            else {
                                createUser(username: username,email: email,password: password)
                                //dismiss()
                            }
                        }.foregroundColor(.white).frame(width: 159.0,height: 50).background(Color.blue).cornerRadius(10).alert(isPresented: $showAlert) {
                            Alert(title: Text("Error"), message: Text("\(errorText)"), dismissButton: .default(Text("OK")))
                        }
                        
                    }
                    /*NavigationLink(destination: MainView(), isActive: $shouldShowMainView) {
                        EmptyView()
                    }*/
                }
            }
        }.navigationBarHidden(true)
    }
    
    
    //Metodo para crear User
    func createUser(username:String, email:String, password:String){
        Auth.auth().createUser(withEmail: email, password: password){
            (result, error) in
            if let error = error {
                    print("Error: \(error.localizedDescription)")
                    showAlert = true
                    errorText = "Error: \(error.localizedDescription)"
                } else if let result = result {
                    print("Success: \(result.user.email ?? "")")
                    print("UID: \(result.user.uid)")
                    
                    let user = User(userId: result.user.uid, email: result.user.email ?? email, password: password, displayName: username, profilePictureUrl: nil)
                    
                    //TODO: Guardar el usuario en singleton
                    //TODO: Establecer el isLoggedIn a true para el MainView/Singleton
                    //saveUserSingleton(User:user)
                    
                    saveUserInFirestore(userToFirestore:user)
                    self.isLoggedIn=true
                    
                    
                    //self.shouldShowMainView = true
                }
        }
    }
    
    func usernameIsValid(username: String) -> Bool {
        // Expresión regular para comprobar que el nombre de usuario solo contiene letras, números, guiones bajos y guiones.
        let regex = "^[a-zA-Z0-9_-]{3,16}$"
        
        let test = NSPredicate(format:"SELF MATCHES %@", regex)
        return test.evaluate(with: username)
    }
                                     
     func emailIsValid(email: String) -> Bool {
         // Expresión regular para comprobar que el correo electrónico es válido.
         let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
         
         let test = NSPredicate(format:"SELF MATCHES %@", regex)
         return test.evaluate(with: email)
     }

     func passwordIsValid(password: String) -> Bool {
         // Firebase requiere una longitud mínima de 6 caracteres para las contraseñas.
         return password.count >= 6
     }
    
    
    func saveUserInFirestore(userToFirestore: User){
        // Convierte el objeto User en un diccionario
        let userDict: [String: Any] = [
            "userId": userToFirestore.userId,
            "email": userToFirestore.email,
            "password": userToFirestore.password,
            "displayName": userToFirestore.displayName,
            "profilePictureUrl": userToFirestore.profilePictureUrl ?? NSNull()
        ]
        
        // Añade el documento a la colección "users"
        //Se guarda con el displayName para evitar usuarios duplicados
        db.collection("Users").document(userToFirestore.displayName).setData(userDict) { err in
            if let err = err {
                print("Error writing BBDD: \(err)")
                showAlert = true
                errorText = "Error guardando el usuario: \(err)"
            } else {
                print("Document successfully written!")
            }
        }
    }
}
                        

#Preview {
    RegisterView(isLoggedIn: .constant(false), userLogged: .constant(User(userId: "", email: "String", password: "String", displayName: "String", profilePictureUrl: nil)))
        .modelContainer(for: Item.self, inMemory: true)
}
