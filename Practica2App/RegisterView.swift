//
//  ContentView.swift
//  Practica2App
//
//  Created by David Macario Matarredona on 3/12/23.
//

import SwiftUI
import SwiftData

struct RegisterView: View {
    @State private var showAlert = false
    @State private var errorText = ""
    @Environment(\.dismiss) var dismiss
    
    @State private var username = "" //(TODO: Singleton)
    @State private var password = ""
    @State private var retypedpassword = ""
    @State private var email = ""
    @State private var wrongUsername = 0
    @State private var wrongEmail = 0
    @State private var wrongPassword = 0
    
    @State private var showingLoginScreen = false
    
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
                    SecureField("Retype Password", text: $retypedpassword).padding().frame(width: 300,height: 50).background(Color.black.opacity(0.05)).cornerRadius(10).border(.red,width: CGFloat(wrongPassword))
                    
                    HStack{
                        Button("Go Back"){
                            dismiss()
                        }
                        Button("Register"){
                            //Comprobar Strings
                            //Create User
                            // Check if the fields are not empty
                            if username.isEmpty || password.isEmpty || retypedpassword.isEmpty || email.isEmpty {
                                self.errorText = "All fields must be filled"
                                self.showAlert = true
                            }
                            // Check if the username is valid
                            /*else if (!usernameIsValid(username)) {
                                self.errorText = "Invalid username"
                                self.showAlert = true
                                self.wrongUsername = 1
                            }
                            // Check if the email is valid
                            else if (!emailIsValid(email) {
                                self.errorText = "Invalid email"
                                self.showAlert = true
                                self.wrongEmail = 1
                            }*/
                            // Check if the passwords match
                            else if password != retypedpassword {
                                self.errorText = "Passwords do not match"
                                self.showAlert = true
                                self.wrongPassword = 1
                            }
                            // If all checks pass, create the user
                            else {
                                //createUser(username, password, email)
                                dismiss()
                            }
                        }.foregroundColor(.white).frame(width: 159.0,height: 50).background(Color.blue).cornerRadius(10).alert(isPresented: $showAlert) {
                            Alert(title: Text("Error"), message: Text("\(errorText)"), dismissButton: .default(Text("OK")))
                        }
                    }
                }
            }
        }.navigationBarHidden(true)
    }
}
                        

#Preview {
    RegisterView()
        .modelContainer(for: Item.self, inMemory: true)
}
