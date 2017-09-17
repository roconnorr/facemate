//
//  RoutineItem.swift
//  facemate
//
//  Created by Rory O'Connor on 16/09/17.
//  Copyright © 2017 Rory O'Connor. All rights reserved.
//

import Foundation

class RoutineItem {
    
    var product: Product
    var startDate: Date
    var interval: String
    
    init(product: Product, startDate: Date, interval: String) {
        self.product = product
        self.startDate = startDate
        self.interval = interval
    }
    
}
