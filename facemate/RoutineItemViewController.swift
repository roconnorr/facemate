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
    
    private var product: Product = Product(name: "a", type: "a")
    private var category: String = "Sunscreen"
    private var startDate = Date()
    private var AM: Bool = false
    private var PM: Bool = false
    private var repeats: RepeatFrequency = RepeatFrequency.never
    private var notes: String = ""
    
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
        
        //Eureka form configuration
        form
            +++ Section()
            <<< PushRow<Product>() { //1
                $0.title = "Product" //2
                //$0.value =  //3
                $0.options = Storage.shared.products //4
                $0.onChange { [unowned self] row in //5
                    if let value = row.value {
//                        if let repeatFreqValue = RepeatFrequency(rawValue: value){
//                            self.repeats = repeatFreqValue
//                        }
                    }
                }
                
            }
            
            +++ Section()
            <<< DateRow() {
                $0.dateFormatter = type(of: self).dateFormatter //1
                $0.title = "Start Date" //2
                $0.value = startDate //3
                $0.minimumDate = Date() //4
                $0.onChange { [unowned self] row in //5
                    if let date = row.value {
                        self.startDate = date
                    }
                }
            }
            
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
            
            <<< PushRow<String>() { //1
                $0.title = "Repeats" //2
                $0.value = repeats.rawValue //3
                $0.options = repeatOptions //4
                $0.onChange { [unowned self] row in //5
                    if let value = row.value {
                        if let repeatFreqValue = RepeatFrequency(rawValue: value){
                            self.repeats = repeatFreqValue
                        }
                    }
                }
            }
        
            +++ Section("Notes")
            <<< TextAreaRow() {
                $0.placeholder = "e.g. Apply safely"
                $0.onChange { [unowned self] row in
                    //executed when value changes
                    if let value = row.value{
                        self.notes = value
                    }
                }
            }
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        if form.validate().isEmpty {
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
