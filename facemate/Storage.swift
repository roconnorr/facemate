//
//  Storage.swift
//  facemate
//
//  Created by Rory O'Connor on 24/01/18.
//  Copyright © 2018 Rory O'Connor. All rights reserved.
//

import Foundation

class Storage {
    
    static let shared = Storage()
    
    var products = [Product]() {
        didSet{
            //saves products every time the array is set
            saveProducts()
        }
    }
    
    private init(){
        // Load any saved products, otherwise load sample data.
        if let savedProducts = loadProducts() {
            products += savedProducts
        } else {
            loadSampleProducts()
        }
    }
    
    //MARK: Private Methods
    private func loadSampleProducts() {
        products.append(Product(name: "test", type: "test"))
    }
    
    //loads products from disk
    private func loadProducts() -> [Product]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Product.ArchiveURL.path) as? [Product]
    }
    
    //save products to disk
    private func saveProducts() {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(products, toFile: Product.ArchiveURL.path)
        if isSuccessfulSave {
            print("Products successfully saved.")
        } else {
            print("Failed to save products...")
        }
    }
}
