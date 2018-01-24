//
//  RootTabViewController.swift
//  facemate
//
//  Created by Rory O'Connor on 17/09/17.
//  Copyright © 2017 Rory O'Connor. All rights reserved.
//

import UIKit

class RootTabViewController: UITabBarController {
    
    var products = [Product]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Load any saved products, otherwise load sample data.
        if let savedProducts = loadProducts() {
            products += savedProducts
        } else {
            loadSampleProducts()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        //reload the products each time the tab bar view has changed
        if let savedProducts = loadProducts() {
            products = savedProducts
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
    
    //use prepare to pass products instead? 
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//        
//    }
    
}
