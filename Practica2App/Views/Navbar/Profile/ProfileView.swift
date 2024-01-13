//
//  ProfileView.swift
//  Practica2App
//
//  Created by RonaldRis on 9/1/24.
//

import SwiftUI
import URLImage
import Firebase

struct ProfileView: View {
    @Binding var isLoggedIn: Bool
    @Binding var userLogged: User
    
    @State private var inputUrl: String = ""
    //@State private var inputUsername: String = ""
    
    @State private var showingAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    
    
    var body: some View 
    {
        
        let defaultUrl="https://www.formulatv.com/images/articulos/94000/n94260_WBcNo5ig7W4YHL0P6qsz3tF8RkxaJEU19-q.jpg"
        
        VStack{
            
            if let urlString = userLogged.profilePictureUrl, let url = URL(string: urlString) {
                URLImage(url) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.blue, lineWidth: 4)) // Añade un borde blanco
                        .frame(width: 200, height: 200) // Tamaño de la imagen
                        .padding(.top, 20)
                }
            } else if let defaultUrl = URL(string: defaultUrl) {
                URLImage(defaultUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(Circle())
                        .frame(width: 200, height: 200) // Tamaño de la imagen
                        .padding(.top, 20)// Añade un espacio en la parte superior
                }
            }
            
            Text(userLogged.displayName)
                .font(.largeTitle)
                .padding(.top, 20)
            
            
           /* TextField("Username", text: $inputUsername)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.top,30).frame(width: 200)
            
            
            Button(action: {
                //Cambiar displayName de firestore y del usuario actual
                self.userLogged.displayName = self.inputUsername
                let db = Firestore.firestore()
                db.collection("Users").document(userLogged.userId).updateData(["displayName": self.$inputUsername]) { err in
                        if let err = err {
                            self.alertTitle = "Error"
                            self.alertMessage = "Error al actualizar el Username: \(err)"
                        } else {
                            self.alertTitle = "Éxito"
                            self.alertMessage = "Username actualizado correctamente"
                        }
                        self.showingAlert = true
                    }
                
            }) {
                Text("Cambiar Username")
            }.padding(10).alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }.cornerRadius(2)
            */
            
            
            TextField("Introduce una nueva URL de perfil", text: $inputUrl)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding().frame(width: 300).padding(.top,1)
            
            Button(action: {
                //Cambiar url de firestore y del usuario actual
                self.userLogged.profilePictureUrl = self.inputUrl
                let db = Firestore.firestore()
                db.collection("Users").document(userLogged.userId).updateData(["profilePictureUrl": self.inputUrl]) { err in
                        if let err = err {
                            self.alertTitle = "Error"
                            self.alertMessage = "Error al actualizar la URL: \(err)"
                        } else {
                            self.alertTitle = "Éxito"
                            self.alertMessage = "Url actualizada correctamente"
                        }
                        self.showingAlert = true
                    }
                
            }) {
                Text("Cambiar url")
            }.alert(isPresented: $showingAlert) {
                Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
            }.cornerRadius(2).onAppear() {
                // código que se ejecuta al cargar la pagina
                print("Cargando imagen")
                inputUrl=userLogged.profilePictureUrl ?? ""
            }
            
            
            Button(action: {
                // Elimina al usuario actual de la persistencia
                UserDefaults.standard.removeObject(forKey: "userId")
                
                print("sessionPersistence REMOVED")
                
                userLogged = User(userId: "", email: "", password: "", displayName: "", profilePictureUrl: "")
                isLoggedIn = false
            }){
                Text("Log out")
            }.foregroundColor(.white).frame(width: 150.0,height: 50).background(Color.blue).cornerRadius(10).padding(.top, 70)
            
        }
    }
    
}

#Preview {
    ProfileView(isLoggedIn: .constant(false), userLogged: .constant(User(userId: "", email: "", password: "", displayName: "Juan", profilePictureUrl: "https://i.pinimg.com/474x/36/c5/90/36c590ae4a439503cc9a8505389e594a.jpg")))
}
