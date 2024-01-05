//
//  Item.swift
//  Practica2App
//
//  Created by David Macario Matarredona on 3/12/23.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
