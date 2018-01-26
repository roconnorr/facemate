//
//  RoutineItem.swift
//  facemate
//
//  Created by Rory O'Connor on 16/09/17.
//  Copyright © 2017 Rory O'Connor. All rights reserved.
//

import Foundation

//enum RepeatFrequency: String {
//    case never = "Never"
//    case daily = "Daily"
//    case alternateDays = "AlternateDays"
//    case weekly = "Weekly"
//    case fortnightly = "Fortnightly"
//    case monthly = "Monthly"
//}

class RoutineItem {
    var product: Product
    var startDate: Date
    var AM: Bool
    var PM: Bool
    var repeats: RepeatFrequency
    
    
    init(product: Product, startDate: Date, AM: Bool, PM: Bool, repeats: RepeatFrequency) {
        self.product = product
        self.startDate = startDate
        self.AM = AM
        self.PM = PM
        self.repeats = repeats
    }
}
