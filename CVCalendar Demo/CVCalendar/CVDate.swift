//
//  CVDate.swift
//  CVCalendar
//
//  Created by Мак-ПК on 12/31/14.
//  Copyright (c) 2014 GameApp. All rights reserved.
//

import UIKit

public class CVDate: NSObject {
    private let date: NSDate
    
    let year: Int
    let month: Int
    let week: Int
    let day: Int
    
    init(date: NSDate) {
        let dateRange = Manager.dateRange(date)
        
        self.date = date
        self.year = dateRange.year
        self.month = dateRange.month
        self.week = dateRange.weekOfMonth
        self.day = dateRange.day
        
        super.init()
    }
    
    init(day: Int, month: Int, week: Int, year: Int) {
        if let date = Manager.dateFromYear(year, month: month, week: week, day: day) {
            self.date = date
        } else {
            self.date = NSDate()
        }
        
        self.year = year
        self.month = month
        self.week = week
        self.day = day
        
        super.init()
    }
}

extension CVDate {
    public func convertedDate() -> NSDate? {
        let calendar = NSCalendar.currentCalendar()
        let comps = Manager.componentsForDate(NSDate())
        
        comps.year = year
        comps.month = month
        comps.weekOfMonth = week
        comps.day = day
        
        return calendar.dateFromComponents(comps)
    }
}

extension CVDate {
    public var globalDescription: String {
        get {
            let month = dateFormattedStringWithFormat("MMMM", fromDate: date)
            return "\(month), \(year)"
        }
    }
    
    public var commonDescription: String {
        get {
            let month = dateFormattedStringWithFormat("MMMM", fromDate: date)
            return "\(day) \(month), \(year)"
        }
    }
    
    public var identifier: String {
        return "\(day)\(month)\(year)"
    }
    
    public override func isEqual(object: AnyObject?) -> Bool {
        if let object = object as? CVDate {
            return identifier == object.identifier
        } else {
            return false
        }
    }
    
    public override var hash: Int {
        return identifier.hashValue
    }
}

private extension CVDate {
    func dateFormattedStringWithFormat(format: String, fromDate date: NSDate) -> String {
        let formatter = NSDateFormatter()
        formatter.dateFormat = format
        return formatter.stringFromDate(date)
    }
}
