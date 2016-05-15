//
//  Feed.swift
//  forPhobos
//
//  Created by Roman Spirichkin on 15/05/16.
//  Copyright © 2016 rs. All rights reserved.
//

import UIKit

class FeedEvent {
    private(set) var details, comment, moneyString, minimilesString, category, categoryIconString: String?
    private var date : NSDate
    var dateString: String {
        return (NSDate().offsetFrom(date))
    }
    
    init(dictionary: NSDictionary = NSDictionary()) {
        if let dateInt = dictionary["dateInt"] as? Int {
            self.date = NSDate(timeIntervalSinceReferenceDate: Double(dateInt) - NSTimeIntervalSince1970)
        } else { self.date = NSDate() }
        if let details = dictionary["details"] as? String {
            self.details = details
        } else { self.details = nil }
        if let comment = dictionary["comment"] as? String {
            self.comment = comment
        } else { self.comment = nil }
        if let category = dictionary["categoryName"] as? String {
            self.category = category
        } else { self.category = nil }
        if let categoryIconString = dictionary["categoryIconString"] as? String {
            self.categoryIconString = categoryIconString
        } else { self.categoryIconString = nil }
        if let mimimiles = dictionary["mimimiles"] as? Double{
            self.minimilesString = "\(mimimiles)✈︎"
        }
        if let amountString = dictionary["amount"] as? Int {
            var currency = ""
            if let currerncyCode = dictionary["currerncyCode"] as? String {
                currency = getCurrencySymbolFrom(currerncyCode)
            }
            self.moneyString = "\(amountString)" + " " + currency
        }
    }
    
    private func getCurrencySymbolFrom(currencyCode: String) -> String {
        switch currencyCode {
        case "RUB":
            return "₽"
        case "USD":
            return "$"
        case "EUR":
            return "€"
        default:
            return currencyCode
        }
    }
}


