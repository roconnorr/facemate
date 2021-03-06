//
//  Storage.swift
//  facemate
//
//  Created by Rory O'Connor on 24/01/18.
//  Copyright © 2018 Rory O'Connor. All rights reserved.
//

import Foundation

class Storage {
    
    //TODO: migrate product storage to SQLite, it doesn't make sense to have 2 storage methods for related objects
    
    static let shared = Storage()
    
    var products = [Product]() {
        didSet{
            //saves products every time the array is set
            saveProducts()
        }
    }
    
    private init(){
        // Load any saved products, otherwise load sample data.
//        products.append(Product(name: "asdf", categories: ["asdf"], rating: 1, startDate: Date(), AM: true, PM: true, repeats: "asdf", notes: "Asdf"))
        if let savedProducts = loadProducts() {
            products += savedProducts
        }else{

        }
    }
    
    //MARK: Private Methods

    
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
