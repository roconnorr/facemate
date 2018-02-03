//
//  Product.swift
//  facemate
//
//  Created by Rory O'Connor on 16/09/17.
//  Copyright © 2017 Rory O'Connor. All rights reserved.
//

import Foundation

enum RepeatFrequency: String {
    case never = "Never"
    case daily = "Daily"
    case alternateDays = "AlternateDays"
    case weekly = "Weekly"
    case fortnightly = "Fortnightly"
    case monthly = "Monthly"
}

enum Category: String {
    case sunscreen = "Sunscreen"
    case daycream = "Daycream"
    case nightcream = "Nightcream"
}

class Product: NSObject, NSCoding{
    
    //make private backing array for categories - make categories enum type and convert with getters/setters
    
    //MARK: Properties
    //var id: Int
    var name: String
    //stored as rawvalue of category enum to work with nscoding
    var categories: [String]
    var rating: Int
    var startDate: Date
    var AM: Bool
    var PM: Bool
    var repeats: String
    var notes: String
    var AMPMStringValue: String
    
//    fileprivate var categories_raw: [String]
//    fileprivate var repeats_raw: String
    
    override var description: String {
        return "Name: \(name), Categories: \(categories), Rating: \(rating), StartDate: \(startDate), AM: \(AM), PM: \(PM), Repeats: \(repeats), Notes: \(notes)"
    }
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("products")
    
    //MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let categories = "categories"
        static let rating = "rating"
        static let startDate = "startDate"
        static let AM = "AM"
        static let PM = "PM"
        static let repeats = "repeats"
        static let notes = "notes"
    }
    
    init(name: String, categories: [String], rating: Int, startDate: Date, AM: Bool, PM: Bool, repeats: String, notes: String){
        self.name = name
        self.categories = categories
        self.rating = rating
        self.startDate = startDate
        self.AM = AM
        self.PM = PM
        self.repeats = repeats
        self.notes = notes
        
        if AM == true && PM == false {
            self.AMPMStringValue = "AM"
        }else if AM == false && PM == true {
            self.AMPMStringValue = "PM"
        }else{
            self.AMPMStringValue = "AM/PM"
        }
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            print("Unable to decode the name for a Product object.")
            return nil
        }
        
        guard let categories = aDecoder.decodeObject(forKey: PropertyKey.categories) as? [String] else {
            print("Unable to decode the categories for a Product object.")
            return nil
        }
        
        let rating = aDecoder.decodeInteger(forKey: PropertyKey.rating)
        
        guard let startDate = aDecoder.decodeObject(forKey: PropertyKey.startDate) as? Date else {
            print("Unable to decode the startDate for a Product object.")
            return nil
        }
        
        let AM = Bool(aDecoder.decodeBool(forKey: PropertyKey.AM))
        
        let PM = Bool(aDecoder.decodeBool(forKey: PropertyKey.PM))
        
        guard let repeats = aDecoder.decodeObject(forKey: PropertyKey.repeats) as? String else {
            print("Unable to decode the repeats for a Product object.")
            return nil
        }
        
        guard let notes = aDecoder.decodeObject(forKey: PropertyKey.notes) as? String else {
            print("Unable to decode the notes for a Product object.")
            return nil
        }
        
        // Must call designated initializer.
        self.init(name: name, categories: categories, rating: rating, startDate: startDate, AM: AM, PM: PM, repeats: repeats, notes: notes)
    }
    
    //evaluate product equality
    override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? Product {
            return self.name == object.name && self.categories == object.categories && self.rating == object.rating && self.startDate == object.startDate && self.AM == object.AM && self.PM == object.PM && self.repeats == object.repeats && self.notes == object.notes
        }
        return false
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(categories, forKey: PropertyKey.categories)
        aCoder.encode(rating, forKey: PropertyKey.rating)
        aCoder.encode(startDate, forKey: PropertyKey.startDate)
        aCoder.encode(AM, forKey: PropertyKey.AM)
        aCoder.encode(PM, forKey: PropertyKey.PM)
        aCoder.encode(repeats, forKey: PropertyKey.repeats)
        aCoder.encode(notes, forKey: PropertyKey.notes)
    }
}
