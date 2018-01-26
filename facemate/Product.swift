//
//  Product.swift
//  facemate
//
//  Created by Rory O'Connor on 16/09/17.
//  Copyright © 2017 Rory O'Connor. All rights reserved.
//

import Foundation

enum Category: String {
    case sunscreen = "Sunscreen"
    case daycream = "Daycream"
    case nightcream = "Nightcream"
}

class Product: NSObject, NSCoding{
    
    //make private backing array for categories - make categories enum type and convert with getters/setters
    
    //MARK: Properties
    var name: String
    //stored as rawvalue of category enum to work with nscoding
    var categories: [String]
    var rating: Int
    var notes: String
    
    override var description: String {
        return "Name: \(name), Categories: \(categories), Rating: \(rating), Notes\(notes)"
    }
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("products")
    
    //MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let categories = "categories"
        static let rating = "rating"
        static let notes = "notes"
    }
    
    init(name: String, categories: [String], rating: Int, notes: String){
        self.name = name
        self.categories = categories
        self.rating = rating
        self.notes = notes
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
        
        guard let notes = aDecoder.decodeObject(forKey: PropertyKey.notes) as? String else {
            print("Unable to decode the notes for a Product object.")
            return nil
        }
        
        // Must call designated initializer.
        self.init(name: name, categories: categories, rating: rating, notes: notes)
        
    }
    
    //evaluate product equality
    override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? Product {
            return self.name == object.name && self.categories == object.categories && self.rating == object.rating && self.notes == object.notes
        }
        return false
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(categories, forKey: PropertyKey.categories)
        aCoder.encode(rating, forKey: PropertyKey.rating)
        aCoder.encode(notes, forKey: PropertyKey.notes)
    }
}
