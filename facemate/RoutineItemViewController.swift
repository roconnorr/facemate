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
    
    //replace with swiftdate?
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM d yyyy, h:mm a"
        return formatter
    }()
    
    var dueDate = Date()
    
    fileprivate var repeats_raw: String = "Never"
    
    var repeats: RepeatFrequency {
        get {
            return RepeatFrequency(rawValue: self.repeats_raw)!
        }
        set {
            self.repeats_raw = newValue.rawValue
        }
    }
    
    var repeatFrequency: String {
        get {
            return repeats.rawValue
        }
        set {
            repeats = RepeatFrequency(rawValue: newValue)!
        }
    }
    
    
    let repeatOptions: [String] = [RepeatFrequency.never.rawValue,
                                   RepeatFrequency.daily.rawValue,
                                   RepeatFrequency.weekly.rawValue,
                                   RepeatFrequency.monthly.rawValue,
                                   RepeatFrequency.annually.rawValue]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ASDF")
        print(Storage.shared.products.count)
        Storage.shared.products.append(Product(name: "asdf", type: "asdf"))
        print(Storage.shared.products.count)
        
        //Eureka form configuration
        form
            +++ Section()
            <<< PushRow<String>() { //1
                $0.title = "Product" //2
                $0.value = repeatFrequency //3
                $0.options = repeatOptions //4
                $0.onChange { [unowned self] row in //5
                    if let value = row.value {
                        self.repeatFrequency = value
                    }
                }
                
            }
            +++ Section()    //2
            <<< TextRow() { // 3
                $0.title = "Description" //4
                $0.placeholder = "e.g. Pick up my laundry"
                $0.value = "asdf" //5
                $0.onChange { [unowned self] row in //6
                    //self.viewModel.title = row.value
                    //executed when value changes
                }
                $0.add(rule: RuleRequired()) //1
                $0.validationOptions = .validatesOnChange //2
                $0.cellUpdate { (cell, row) in //3
                    if !row.isValid {
                        cell.titleLabel?.textColor = .red
                    }
                }
            }
            
            +++ Section()
            <<< DateTimeRow() {
                $0.dateFormatter = type(of: self).dateFormatter //1
                $0.title = "Due date" //2
                $0.value = dueDate //3
                $0.minimumDate = Date() //4
                $0.onChange { [unowned self] row in //5
                    if let date = row.value {
                        self.dueDate = date
                    }
                }
            }
            <<< PushRow<String>() { //1
                $0.title = "Repeats" //2
                $0.value = repeatFrequency //3
                $0.options = repeatOptions //4
                $0.onChange { [unowned self] row in //5
                    if let value = row.value {
                        self.repeatFrequency = value
                    }
                }
                
            }
            <<< AlertRow<String>() {
                $0.title = "Reminder"
                $0.selectorTitle = "Remind me"
                //$0.value = viewModel.reminder
                //$0.options = viewModel.reminderOptions
//                $0.onChange { [unowned self] row in
//                    if let value = row.value {
//                        //self.viewModel.reminder = value
//                    }
//                }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
