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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
