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
    
    //product
    var name: String = ""
    //stored as rawvalue of category enum to work with nscoding
    var categories: [String] = ["placeholder"]
    var rating: Int = 1
    var notes: String = "placeholder"
    
    //routine item
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
    
    let categoryOptions: [String] = [Category.daycream.rawValue,
                                   Category.nightcream.rawValue,
                                   Category.sunscreen.rawValue]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //eureka form configuration
        form
            //Product selection
            +++ Section()
            <<< TextRow() {
                $0.title = "Product Name"
                $0.placeholder =  "Enter name"
                $0.onChange { [unowned self] row in
                    if let value = row.value {
                        self.name = value
                    }
                }
                
            }
            
            //Repeats selection
            <<< MultipleSelectorRow<String>() {
                $0.title = "Categories"
                //$0.value = c.rawValue
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
                $0.value = "3"
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
            
            +++ Section("Notes")
            <<< TextAreaRow() {
                $0.title = "Description" //4
                $0.placeholder = "e.g. Pick up my laundry"
//              $0.value = viewModel.title //5
                $0.onChange { [unowned self] row in //6
                    if let value = row.value{
                        self.notes = value
                    }
                }
            }
    }
    
    //MARK: Actions
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        if form.validate().isEmpty {
            //save code here
            popViewController()
        }
    }
    
    @IBAction func cancelButton(_ sender: UIBarButtonItem) {
        popViewController()
    }
    
    private func popViewController() {
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
