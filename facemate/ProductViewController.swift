//
//  ProductViewController.swift
//  facemate
//
//  Created by Rory O'Connor on 16/09/17.
//  Copyright © 2017 Rory O'Connor. All rights reserved.
//

import UIKit
import Eureka

class ProductViewController: FormViewController {
    
    var product: Product?
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    //product
    var name: String = ""
    //stored as rawvalue of category enum to work with nscoding
    var categories: [String] = ["Daycream"]
    var rating: Int = 3
    private var startDate = Date()
    private var AM: Bool = true
    private var PM: Bool = false
    private var repeats: String = "Never"
    var notes: String = ""
    
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
    
    let categoryOptions: [String] = [Category.daycream.rawValue,
                                   Category.nightcream.rawValue,
                                   Category.sunscreen.rawValue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let product = product{
            self.name = product.name
            self.categories = product.categories
            self.rating = product.rating
            self.startDate = product.startDate
            self.AM = product.AM
            self.PM = product.PM
            self.repeats = product.repeats
            self.notes = product.notes
        }
        
        //eureka form configuration
        form
            //Product name entry
            +++ Section()
            <<< TextRow() {
                $0.title = "Product Name"
                $0.placeholder =  "Enter name"
                $0.value = name
                //$0.add(rule: RuleNameUnique())
                $0.add(rule: RuleRequired())
                $0.validationOptions = .validatesOnChange
                $0.onChange { [unowned self] row in
                    if let value = row.value {
                        self.name = value
                    }
                    
                    //may be a better place for this
                    self.updateSaveButtonState()
                }
                
            }
            .cellUpdate { cell, row in
                if !row.isValid {
                    cell.titleLabel?.textColor = .red
                }
            }
            //adds an error message row while a rule is being broken
            .onRowValidationChanged { cell, row in
                
                
                let rowIndex = row.indexPath!.row
                while row.section!.count > rowIndex + 1 && row.section?[rowIndex  + 1] is LabelRow {
                    row.section?.remove(at: rowIndex + 1)
                }
                if !row.isValid {
                    for (index, validationMsg) in row.validationErrors.map({ $0.msg }).enumerated() {
                        let labelRow = LabelRow() {
                            $0.title = validationMsg
                            $0.cell.height = { 30 }
                        }
                        row.section?.insert(labelRow, at: row.indexPath!.row + index + 1)
                    }
                }
                self.updateSaveButtonState()
            }
    
            
            //Categories selection
            <<< MultipleSelectorRow<String>() {
                $0.title = "Categories"
                $0.value = Set(categories)
                $0.options = categoryOptions
                $0.onChange { [unowned self] row in
                    if let value = row.value {
                        self.categories = Array(value)
                    }
                }
            }
            
            +++ Section("Rating")
            //Rating selection
            <<< SegmentedRow<String>() {
                $0.value = String(rating)
                $0.options = ["1", "2", "3", "4", "5"]
                $0.onChange { [unowned self] row in
                    if let value = Int(row.value!) {
                        self.rating = value
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
                //fix me
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
                $0.title = "Frequency"
                $0.value = repeats
                $0.options = repeatOptions
                $0.onChange { [unowned self] row in
                    if let value = row.value {
                        //if let repeatFreqValue = value {
                            self.repeats = value
                        //}
                    }
                }
            }
            
            +++ Section("Notes")
            <<< TextAreaRow() {
                $0.title = "Description"
                $0.placeholder = "e.g. Apply Gently"
                $0.value = notes
                $0.onChange { [unowned self] row in
                    if let value = row.value{
                        self.notes = value
                    }
                }
            }
        
        updateSaveButtonState()
    }
    
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        if presentingViewController != nil {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController {
            owningNavigationController.popViewController(animated: true)
        } else {
            fatalError("The ProductViewController is not inside a navigation controller.")
        }
    }
    
    //MARK: Navigation
    // This method lets you configure a view controller before it's presented.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Configure the destination view controller only when the save button is pressed.
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            //os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        
        product = Product(name: name, categories: categories, rating: rating, startDate: startDate, AM: AM, PM: PM, repeats: repeats, notes: notes)
    }
    
    private func updateSaveButtonState() {
        // Disable the Save button if the text field is empty.
        //prevents validation error appearing immediately
        if name == "" {
            saveButton.isEnabled = false
        } else {
            if form.validate().isEmpty {
                saveButton.isEnabled = true
            }else{
                saveButton.isEnabled = false
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


//checks if the name of a product matches any existing products and doesn't allow a clash
//will need to be tweaked to work with editing
struct RuleNameUnique<T: Equatable>:RuleType {
    
    public init() {}
    
    public var id: String?
    public var validationError: ValidationError = ValidationError(msg: "A Product with that name already exists!.")
    
    public func isValid(value: T?) -> ValidationError? {
        if let str = value as? String {
            for product in Storage.shared.products {
                if product.name == str {
                    return validationError
                }
            }
        }
        return nil
    }
}
