//
//  EventDatabase.swift
//  facemate
//
//  Created by Rory O'Connor on 3/02/18.
//  Copyright © 2018 Rory O'Connor. All rights reserved.
//

import Foundation
import SQLite

class EventDatabase {
    
    static let sharedInstance: EventDatabase = EventDatabase()
    var db: Connection?
    
    var lastDateAdded: Date = Date()
    
    let events = Table("events")
    
    let eventID = Expression<Int64>("event_id")
    let productID = Expression<Int64>("product_id")
    let date = Expression<Date>("date")
    
    
    init(){
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        
        do{
            self.db = try Connection("\(path)/db.sqlite3")
            
            //try db?.run(events.drop())
            //if the events table does not exist, create it
            try db?.run(events.create(ifNotExists: true){ t in
                t.column(eventID, primaryKey: .autoincrement)
                t.column(productID)
                t.column(date)
            })
        } catch {
            print("Could not get DB connection: \(error)")
        }
    }
    
    func getEvents() -> [(Int64, Date)]{
        var eventArray = [(Int64, Date)]()
        
        do {
            for event in try db!.prepare(events){
                let new_id = event[productID]
                let new_date = event[date]
                eventArray.append((new_id, new_date))
            }
        } catch {
            print("Could not get events from DB: \(error)")
        }
        
        return eventArray

    }
    
    func addEvent(product: Product) {
        do {
            try db?.run(events.insert(productID <- 1, date <- product.startDate))
        } catch {
            print("Could not add event to DB: \(error)")
        }
    }
    
    
}
