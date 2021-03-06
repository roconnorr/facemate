//
//  ProductTableViewController.swift
//  facemate
//
//  Created by Rory O'Connor on 17/09/17.
//  Copyright © 2017 Rory O'Connor. All rights reserved.
//

import UIKit

class ProductTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //use provided edit button
        navigationItem.leftBarButtonItem = editButtonItem
        
        //how to get a reference to the tab bar controller
        
//        if let tbc = self.tabBarController as? RootTabViewController {
//            products = tbc.products
//            // do something with tbc.myInformation
//        }
    }
    
    //MARK: Actions
    @IBAction func unwindToProductList(sender: UIStoryboardSegue) {
        //print("unwinding")
        //downcasts source view controller to productviewcontroller, gets saved product and adds to product array
        if let sourceViewController = sender.source as? ProductViewController, let product = sourceViewController.product {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing product.
                
                //need to stop edit from creating a product that already exists too
                if Storage.shared.products.contains(product){
                    //display error instead of doing nothing
                    print("product already exists 1\(selectedIndexPath)")
                }else{
                    Storage.shared.products[selectedIndexPath.row] = product
                    tableView.reloadRows(at: [selectedIndexPath], with: .none)
                }
            }
            else {
                // Add a new product.
                if Storage.shared.products.contains(product){
                    print("Product already exists 2")
                }else{
                    let newIndexPath = IndexPath(row: Storage.shared.products.count, section: 0)
                    //set product id
                    product.id = Storage.shared.products.count + 1
                    Storage.shared.products.append(product)
                    print(product)
                    tableView.insertRows(at: [newIndexPath], with: .automatic)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        //possibly completed
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return the number of rows
        return Storage.shared.products.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ProductTableViewCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ProductTableViewCell else {
            fatalError("The dequeued cell is not an instance of ProductTableViewCell.")
        }
        
        // Configure the cell...
        let product = Storage.shared.products[indexPath.row]
        cell.nameLabel.text = product.name
        cell.ratingLabel.text = String(product.rating)
        cell.repeatsLabel.text = product.repeats
        cell.AMPMLabel.text = product.AMPMStringValue
        cell.startDateLabel.text = product.startDate.description
        cell.categoriesLabel.text = product.categories.description

        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            case "addItem":
                print("adding item")
            
            case "showDetail":
                guard let productDetailViewController = segue.destination as?ProductViewController else {
                    fatalError("Unexpected destination: \(segue.destination)")
                }
            
                guard let selectedProductCell = sender as? ProductTableViewCell else {
                    fatalError("Unexpected sender: \(String(describing: sender))")
                }
            
                guard let indexPath = tableView.indexPath(for: selectedProductCell) else {
                    fatalError("The selected cell is not being displayed by the table")
                }
            
                let selectedProduct = Storage.shared.products[indexPath.row]
                productDetailViewController.product = selectedProduct
            
            default:
                fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            Storage.shared.products.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}
