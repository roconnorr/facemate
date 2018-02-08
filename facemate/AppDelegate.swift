//
//  AppDelegate.swift
//  facemate
//
//  Created by Rory O'Connor on 16/09/17.
//  Copyright © 2017 Rory O'Connor. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //code for testing database
        EventDatabase.sharedInstance.addProductToEventDB(product: Product(name: "today", categories: ["asdf"], rating: 1, startDate: Date(), AM: true, PM: true, repeats: "Weekly", notes: "asdf"))
        
        
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: Date())
        let later = Calendar.current.date(byAdding: .day, value: 8, to: Date())
        
        let prod2 = Product(name: "before", categories: ["asdf"], rating: 1, startDate: tomorrow!, AM: true, PM: true, repeats: "Weekly", notes: "asdf")
        prod2.id = 1
        
        let prod3 = Product(name: "tomorrow", categories: ["asdf"], rating: 1, startDate: later!, AM: true, PM: true, repeats: "Weekly", notes: "asdf")
        prod3.id = 2
        
        EventDatabase.sharedInstance.addProductToEventDB(product: prod2)
        EventDatabase.sharedInstance.addProductToEventDB(product: prod3)
        
        
        print(EventDatabase.sharedInstance.getAllEvents())
        print("events: \(EventDatabase.sharedInstance.getTodayEvents())")
        
        var dateComponents = DateComponents()
        dateComponents.year = 2018
        dateComponents.month = 2
        dateComponents.day = 7
        dateComponents.hour = 1
        dateComponents.minute = 0
        
        // Create date from components
        let userCalendar = Calendar.current // user calendar
        let date1 = userCalendar.date(from: dateComponents)
        
        var dateComponents2 = DateComponents()
        dateComponents2.year = 2018
        dateComponents2.month = 2
        dateComponents2.day = 10
        dateComponents2.hour = 40
        dateComponents2.minute = 0
        
        // Create date from components
        let date2 = userCalendar.date(from: dateComponents2)
        
        print(date1)
        print(date2)
        print(EventDatabase.sharedInstance.getEventsInRange(startDate: date1!, endDate: date2!))
        
        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

