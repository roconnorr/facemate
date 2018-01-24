//
//  RoutineItem.swift
//  facemate
//
//  Created by Rory O'Connor on 16/09/17.
//  Copyright © 2017 Rory O'Connor. All rights reserved.
//

import Foundation

enum RepeatFrequency: String {
    case never = "Never"
    case daily = "Daily"
    case weekly = "Weekly"
    case monthly = "Monthly"
    case annually = "Annually"
}

class RoutineItem {
    
    var product: Product
    var startDate: Date
    //time
    var repeats: String
    
    init(product: Product, startDate: Date, interval: String) {
        self.product = product
        self.startDate = startDate
        self.repeats = interval
    }
    
}
