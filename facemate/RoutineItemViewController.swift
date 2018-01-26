//
//  AddRoutineItemViewController.swift
//  facemate
//
//  Created by Rory O'Connor on 16/09/17.
//  Copyright © 2017 Rory O'Connor. All rights reserved.
//

import UIKit
import Eureka

class RoutineItemViewController: FormViewController{
    
    //set default selected product to first in the product list
    //TODO: check if first product exists or set 0
//  private var product: Product = Storage.shared.products[0]
    private var product: Product = Product(name: "Test", categories: [Category.daycream.rawValue], rating: 1, notes: "test")
    private var startDate = Date()
    private var AM: Bool = true
    private var PM: Bool = false
    private var repeats: RepeatFrequency = RepeatFrequency.never
    
    //replace with swiftdate?
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d yyyy"
        return formatter
    }()
    
    let repeatOptions: [String] = [RepeatFrequency.never.rawValue,
                                   RepeatFrequency.daily.rawValue,
                                   RepeatFrequency.alternateDays.rawValue,
                                   RepeatFrequency.weekly.rawValue,
                                   RepeatFrequency.fortnightly.rawValue,
                                   RepeatFrequency.monthly.rawValue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Storage.shared.products.append(Product(name: "test", categories: [Category.daycream.rawValue], rating: 1, notes: "asdf"))
        print(Storage.shared.products[0])
        Storage.shared.saveProducts()
        
        //Eureka form configuration
        form
            //Product selection
            +++ Section()
            <<< PushRow<Product>() {
                $0.title = "Product"
                $0.value =  product
                $0.options = Storage.shared.products
                $0.onChange { [unowned self] row in
                    if let value = row.value {
                        self.product = value
                    }
                }
                
            }
            
            //Start date selection
            +++ Section()
            <<< DateRow() {
                $0.dateFormatter = type(of: self).dateFormatter
                $0.title = "Start Date"
                $0.value = startDate
                $0.minimumDate = Date()
                $0.onChange { [unowned self] row in
                    if let date = row.value {
                        self.startDate = date
                    }
                }
            }
            
            //AM/PM selection
            <<< SegmentedRow<String>() {
                $0.title = "AM/PM"
                $0.value = "AM"
                $0.options = ["AM", "PM", "AM/PM"]
                $0.onChange { [unowned self] row in
                    if let value = row.value {
                        switch value {
                            case "AM":
                                self.AM = true
                                self.PM = false
                            case "PM":
                                self.AM = false
                                self.PM = true
                            case "AM/PM":
                                self.AM = true
                                self.PM = true
                            default:
                                print("unexpected AM/PM value")
                        }
                    }
                }
            }
            
            //Repeats selection
            <<< PushRow<String>() {
                $0.title = "Repeats"
                $0.value = repeats.rawValue
                $0.options = repeatOptions
                $0.onChange { [unowned self] row in
                    if let value = row.value {
                        if let repeatFreqValue = RepeatFrequency(rawValue: value){
                            self.repeats = repeatFreqValue
                        }
                    }
                }
            }
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        if form.validate().isEmpty {
            //save code here
            popViewController()
        }
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        popViewController()
    }
    
    func popViewController(){
        if presentingViewController != nil {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        } else {
            fatalError("The ProductViewController is not inside a navigation controller.")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
