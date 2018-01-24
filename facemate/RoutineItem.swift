//
//  RoutineItem.swift
//  facemate
//
//  Created by Rory O'Connor on 16/09/17.
//  Copyright © 2017 Rory O'Connor. All rights reserved.
//

import Foundation
import SwiftDate

enum Categories: String {
    case sunscreen = "Sunscreen"
    case daycream = "Daycream"
    case nightcream = "Nightcream"
}

enum RepeatFrequency: String {
    case never = "Never"
    case daily = "Daily"
    case alternateDays = "AlternateDays"
    case weekly = "Weekly"
    case fortnightly = "Fortnightly"
    case monthly = "Monthly"
}

class RoutineItem {
    
    var product: Product
    var category: String
    var startDate: Date
    var AM: Bool
    var PM: Bool
    var repeats: RepeatFrequency
    var notes: String
    
    init(product: Product, category: String, startDate: Date, AM: Bool, PM: Bool, repeats: RepeatFrequency, notes: String) {
        self.product = product
        self.category = category
        self.startDate = startDate
        self.AM = AM
        self.PM = PM
        self.repeats = repeats
        self.notes = notes
    }
    
}
