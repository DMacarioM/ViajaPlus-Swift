//
//  User.swift
//  Practica2App
//
//  Created by RonaldRis on 9/1/24.
//

import Foundation

struct User : Encodable, Decodable {
    let userId: String
    let email: String
    let password: String
    var displayName: String
    var profilePictureUrl: String?

    init(userId: String, email: String, password: String, displayName: String, profilePictureUrl: String?) {
        self.userId = userId
        self.email = email
        self.password = password
        self.displayName = displayName
        self.profilePictureUrl = profilePictureUrl
    }
}


