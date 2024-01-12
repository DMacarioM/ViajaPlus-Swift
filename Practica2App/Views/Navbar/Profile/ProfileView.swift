//
//  ProfileView.swift
//  Practica2App
//
//  Created by RonaldRis on 9/1/24.
//

import SwiftUI

struct ProfileView: View {
    @Binding var isLoggedIn: Bool
    @Binding var userLogged: User
    
    var body: some View {
        Button("Log out,\(userLogged.displayName) !"){
            
            UserDefaults.standard.removeObject(forKey: "userId")
            
            print("sessionPersistence REMOVED")
            
            userLogged = User(userId: "", email: "", password: "", displayName: "", profilePictureUrl: nil)
            isLoggedIn = false
        }
    }
}

#Preview {
    ProfileView(isLoggedIn: .constant(false), userLogged: .constant(User(userId: "", email: "", password: "", displayName: "Juan", profilePictureUrl: nil)))
}
