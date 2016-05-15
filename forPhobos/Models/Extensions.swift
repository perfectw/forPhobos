//
//  Extensions.swift
//  forPhobos
//
//  Created by Roman Spirichkin on 15/05/16.
//  Copyright © 2016 rs. All rights reserved.
//

import UIKit


let NotificationForPhobosFeedIsReady = "forPhobosFeedIsReady"
let xibUserInfoView = "UserInfoView"

extension String {
    func RSAttributed(type: RSAttributedStringType = .Default) -> NSAttributedString {
        var attributes : [String : AnyObject] = [:]
        switch type {
        case .SmallGray:
            attributes[NSFontAttributeName] = UIFont.boldSystemFontOfSize(14)
            attributes[NSForegroundColorAttributeName] = UIColor.grayColor()
        case .Title:
            attributes[NSFontAttributeName] = UIFont.boldSystemFontOfSize(20)
        case .BrightRed:
            attributes[NSFontAttributeName] = UIFont.boldSystemFontOfSize(UIScreen.mainScreen().bounds.width/20)
            attributes[NSForegroundColorAttributeName] = UIColor(red: 1, green: 0.3, blue: 0.111, alpha: 1)
        case .FadedBlue:
            attributes[NSFontAttributeName] = UIFont.boldSystemFontOfSize(UIScreen.mainScreen().bounds.width/30)
            attributes[NSForegroundColorAttributeName] = UIColor(red: 0, green: 0, blue: 1, alpha: 0.5)
        default:
            attributes[NSFontAttributeName] = UIFont.systemFontOfSize(16)
        }
        return NSAttributedString(string: self, attributes: attributes)
    }
}

enum RSAttributedStringType {
    case SmallGray
    case Title
    case BrightRed
    case FadedBlue
    case Default
}


public extension UIView {
    public class func fromNib(nibNameOrNil: String? = nil) -> Self {
        return fromNib(nibNameOrNil, type: self)
    }
    
    private class func fromNib<T : UIView>(nibNameOrNil: String? = nil, type: T.Type) -> T {
        let v: T? = fromNib(nibNameOrNil, type: T.self)
        return v!
    }
    
    private class func fromNib<T : UIView>(nibNameOrNil: String? = nil, type: T.Type) -> T? {
        var view: T?
        let name: String
        if let nibName = nibNameOrNil {
            name = nibName
        } else {
            // Most nibs are demangled by practice, if not, just declare string explicitly
            name = nibName
        }
        let nibViews = NSBundle.mainBundle().loadNibNamed(name, owner: nil, options: nil)
        for v in nibViews {
            if let tog = v as? T {
                view = tog
            }
        }
        return view
    }
    
    private class var nibName: String {
        let name = "\(self)".componentsSeparatedByString(".").first ?? ""
        return name
    }
    private class var nib: UINib? {
        if let _ = NSBundle.mainBundle().pathForResource(nibName, ofType: "nib") {
            return UINib(nibName: nibName, bundle: nil)
        } else {
            return nil
        }
    }
}


extension NSDate {
    func yearsFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Year, fromDate: date, toDate: self, options: []).year
    }
    func monthsFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Month, fromDate: date, toDate: self, options: []).month
    }
    func weeksFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.WeekOfYear, fromDate: date, toDate: self, options: []).weekOfYear
    }
    func daysFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Day, fromDate: date, toDate: self, options: []).day
    }
    func hoursFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Hour, fromDate: date, toDate: self, options: []).hour
    }
    func minutesFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Minute, fromDate: date, toDate: self, options: []).minute
    }
    func secondsFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Second, fromDate: date, toDate: self, options: []).second
    }
    func offsetFrom(date:NSDate) -> String {
        let year = NSCalendar.currentCalendar().component(NSCalendarUnit.Year, fromDate: date)
        let currentYear = NSCalendar.currentCalendar().component(NSCalendarUnit.Year, fromDate: NSDate())
        
        if minutesFrom(date) <= 60 { return "\(minutesFrom(date))м" }
        if hoursFrom(date) <= 24 { return "\(hoursFrom(date))ч"   }
        if daysFrom(date) <= 7 { return "\(daysFrom(date))д"    }
        if currentYear == year {
            return "\(NSCalendar.currentCalendar().component(NSCalendarUnit.Month, fromDate: NSDate())).\(NSCalendar.currentCalendar().component(NSCalendarUnit.Day, fromDate: date))"
        }
        if currentYear - year <= 10 {
            return "\(NSCalendar.currentCalendar().component(NSCalendarUnit.Month, fromDate: NSDate())).\(NSCalendar.currentCalendar().component(NSCalendarUnit.Day, fromDate: date)).\(year%2000)"
        }
        if year < 2000 { return "\(year)" }
        
        return "дата"
    }
}


