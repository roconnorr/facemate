//
//  StorageHelper.swift
//  facemate
//
//  Created by Rory O'Connor on 18/09/17.
//  Copyright © 2017 Rory O'Connor. All rights reserved.
//

import Foundation

//utility methods for loading data from NSCoding
class StorageHelper {
    
    //loads products from disk
    static func loadProducts() -> [Product]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Product.ArchiveURL.path) as? [Product]
    }
    
    //save products to disk
    static func saveProducts(products: [Product]) {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(products, toFile: Product.ArchiveURL.path)
        if isSuccessfulSave {
            print("Products successfully saved.")
        } else {
            print("Failed to save products...")
        }
    }
}
