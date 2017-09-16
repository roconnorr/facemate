//
//  RoutineItem.swift
//  facemate
//
//  Created by Rory O'Connor on 16/09/17.
//  Copyright © 2017 Rory O'Connor. All rights reserved.
//

import Foundation

class RoutineItem {
    
    private var startDate: Date
    private var interval: String
    
    init(startDate: Date, interval: String) {
        self.startDate = startDate
        self.interval = interval
    }
    
}
