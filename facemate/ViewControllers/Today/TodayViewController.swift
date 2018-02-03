//
//  TodayViewController.swift
//  facemate
//
//  Created by Rory O'Connor on 16/09/17.
//  Copyright © 2017 Rory O'Connor. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TodayViewController: UIViewController {
    
    @IBOutlet weak var uvLabel: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
            
        
//        Alamofire.request("https://httpbin.org/get").responseJSON { response in
//            
//            guard let data = response.data else {
//                // No data returned
//                return
//            }
//            
//            do {
//                let json = try JSON(data: data)
//                print(json)
//            } catch {
//                print(error)
//            }
//            
//        }
        
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
