//
//  ProfileView.swift
//  Practica2App
//
//  Created by RonaldRis on 9/1/24.
//

import SwiftUI

struct ProfileView: View {
    @Binding var userLogged: User
    var body: some View {
        Text("Hello,\(userLogged.displayName) !")
    }
}

#Preview {
    ProfileView(userLogged: .constant(User(userId: "", email: "", password: "", displayName: "Juan", profilePictureUrl: nil)))
}
