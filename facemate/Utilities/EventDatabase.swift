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
    
    
    //TODO: should record the last day for which events were generated
    //aka newest record -> initialize this field while setting up DB
    //or move to local var in date gen function (just check newest db record)
    //var lastDateAdded: Date = Date()
    
    let events = Table("events")
    
    
    let dateFormatter = DateFormatter()
    
    //should make events have more properties -> also make a model object for them
    //an event is an instance of a product being used
    //example param - was it used
    
    //interval codes
//    0 = "Never"
//    1 = "Daily"
//    2 = "AlternateDays"
//    3 = "Weekly"
//    4 = "Fortnightly"
//    5 = "Monthly"
    
    let eventID = Expression<Int64>("event_id")
    let productID = Expression<Int64>("product_id")
    let date = Expression<Date>("date_string")
    let interval = Expression<Int64>("interval")
    
    //is a singleton, cannot be initialized by another class
    private init(){
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        
        do{
            self.db = try Connection("\(path)/db.sqlite3")
            
            try db?.run(events.drop())
            //if the events table does not exist, create it
            try db?.run(events.create(ifNotExists: true){ t in
                t.column(eventID, primaryKey: .autoincrement)
                t.column(productID)
                t.column(date)
                t.column(interval)
            })
        } catch {
            print("Could not get DB connection: \(error)")
        }
    }
    
    //returns all events that should be displayed on the calendar
    //TODO: within a certain date range, return event model instance not tuple
    func getAllEvents() -> [(Int64, Int64, Date, Int64)]{
        var eventArray = [(Int64, Int64, Date, Int64)]()
        
        do {
            for event in try db!.prepare(events){
                let row_eventID = event[eventID]
                let row_productID = event[productID]
                let row_date = event[date]
                let row_interval = event[interval]
                eventArray.append((row_eventID, row_productID, row_date, row_interval))
            }
        } catch {
            print("Could not get events from DB: \(error)")
        }
        
        return eventArray

    }
    
    //returns all events occuring on todays date
    func getTodayEvents() -> [(Int64, Int64, Date, Int64)]{
        var eventArray = [(Int64, Int64, Date, Int64)]()
        
        do {
            //currently iterate whole db, implement this query to limit it to a sensible range
            //need an easy way to make Date() + or - 1
            //let query = events.filter(startDate...endDate ~= date)
            for event in try db!.prepare(events){
                let row_eventID = event[eventID]
                let row_productID = event[productID]
                let row_date = event[date]
                let row_interval = event[interval]
                if(Calendar.current.isDateInToday(row_date)){
                    eventArray.append((row_eventID, row_productID, row_date, row_interval))
                }
            }
        } catch {
            print("Could not get today's events from DB: \(error)")
        }
        
        return eventArray
    }
    
    //returns all events between the given dates
    func getEventsInRange(startDate: Date, endDate: Date) -> [(Int64, Int64, Date, Int64)]{
        var eventArray = [(Int64, Int64, Date, Int64)]()
        //gets all events where date > start and < end
        do {
            let query = events.filter(startDate...endDate ~= date)
            
            for event in try db!.prepare(query){
                let row_eventID = event[eventID]
                let row_productID = event[productID]
                let row_date = event[date]
                let row_interval = event[interval]
                eventArray.append((row_eventID, row_productID, row_date, row_interval))
            }
        } catch {
            
        }
        
        return eventArray
    }
    
    
    
    //TODO: function to generate new event records into the future
    //should only generate new dates (ones without db records)
    func generateNewEvents(endDate: Date){
        //get latest event record for each product
        //for each product, add events until past the enddate
    }
    
    //use when a product is edited to fix its events
    func regenerateFutureProductEvents(product: Product){
        //deletes all future events for this product
        //remakes necessary events for this product
    }
    
    //TODO: make private, call from generateNewEvents
    func addProductToEventDB(product: Product) {
        //TODO: check if event already exists
        
        do {
            
            //checks if the product already has events in the db
            if let productEntryCount = try db?.scalar(events.filter(productID == Int64(product.id)).count) {
                if productEntryCount == 0 {
                    try db?.run(events.insert(productID <- Int64(product.id), date <- product.startDate, interval <- 1))
                }
            }
        } catch {
            print("Could not add event to DB: \(error)")
        }
    }
}
