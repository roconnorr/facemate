//
//  AddProductViewController.swift
//  facemate
//
//  Created by Rory O'Connor on 16/09/17.
//  Copyright © 2017 Rory O'Connor. All rights reserved.
//

import UIKit

class AddProductViewController: UIViewController, UITextFieldDelegate {
    
    // TEMP
    var tempProdArray = [Product]()

    // MARK: - Properties
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nameTextField.delegate = self
        typeTextField.delegate = self
    }
    
    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
    
    // MARK: - Actions
    @IBAction func saveButton(_ sender: UIButton) {
        if nameTextField.text != "" && typeTextField.text != "" {
            let newProduct = Product(name: nameTextField.text!, type: typeTextField.text!)
            tempProdArray.append(newProduct)
            print(tempProdArray[0])
        } else {
            //error
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
