//
//  Product.swift
//  facemate
//
//  Created by Rory O'Connor on 16/09/17.
//  Copyright © 2017 Rory O'Connor. All rights reserved.
//

import Foundation

class Product: NSObject, NSCoding{
    
    //MARK: Properties
    var name: String
    var type: String
    
    override var description: String {
        return "Name: \(name), Type: \(type)"
    }
    
    //type interactions?
    //warnings/attributes?
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("products")
    
    //MARK: Types
    struct PropertyKey {
        static let name = "name"
        static let type = "type"
    }
    
    init(name: String, type: String){
        self.name = name;
        self.type = type
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        // The name is required. If we cannot decode a name string, the initializer should fail.
        guard let name = aDecoder.decodeObject(forKey: PropertyKey.name) as? String else {
            //os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            print("Unable to decode the name for a Product object.")
            return nil
        }
        
        guard let type = aDecoder.decodeObject(forKey: PropertyKey.type) as? String else {
            //os_log("Unable to decode the name for a Meal object.", log: OSLog.default, type: .debug)
            print("Unable to decode the type for a Product object.")
            return nil
        }
        
        // Must call designated initializer.
        self.init(name: name, type: type)
        
    }
    
    //evaluate product equality
    override func isEqual(_ object: Any?) -> Bool {
        if let object = object as? Product {
            return self.name == object.name && self.type == object.type
        }
        return false
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: PropertyKey.name)
        aCoder.encode(type, forKey: PropertyKey.type)
    }
}
