//
//  User.swift
//  forPhobos
//
//  Created by Roman Spirichkin on 15/05/16.
//  Copyright © 2016 rs. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class User {
    
    // MARK: Property
    private(set) var feedArray : [(date: String, feed: [FeedEvent])] = []
    private(set) var balance, miles : Int
    
    static let sharedInstance = User()
    init() { self.balance = 0; self.miles = 0 }
    
    // MARK: Network
    func getList() {
        Alamofire.request(.GET, "http://mobile165.hr.phobos.work/list").responseJSON { response in
            if let jsonData = response.data {
                let json = JSON(data: jsonData)
                let user = json["user"]
                if let balance = user["balance"].int {
                    self.balance = balance
                }
                if let miles = user["miles"].int {
                    self.miles = miles
                }
                let feedJson = json["feed"]
                var tempFeedArray : [(date: String, feed: [FeedEvent])] = []
                for (key,feedDaysJson):(String, JSON) in feedJson {
                    var newFedDayObject : (date: String, feed: [FeedEvent]) = (key, [])
                    for (_,subJson):(String, JSON) in feedDaysJson {
                        let newFeedDictionary = NSMutableDictionary()
                        // if id used only inside dateArray it is useless
                        // status hold everywhere, so it's useless too
                        if let happenedAt = subJson["happened_at"].int {
                            newFeedDictionary["dateInt"] = happenedAt
                        }
                        if let details = subJson["details"].string {
                            newFeedDictionary["details"] = details
                        }
                        if let comment = subJson["comment"].string {
                            newFeedDictionary["comment"] = comment
                        }
                        if let mimimiles = subJson["mimimiles"].double {
                            newFeedDictionary["mimimiles"] = mimimiles
                        }
                        let displayMoneyJson = subJson["display_money"]
                        if let amount = displayMoneyJson["amount"].int {
                            newFeedDictionary["amount"] = amount
                        }
                        if let currerncyCode = displayMoneyJson["curerncy_code"].string {
                            newFeedDictionary["currerncyCode"] = currerncyCode
                        }
                        let categoryJson = subJson["category"]
                        if let categoryName = categoryJson["display_name"].string {
                            newFeedDictionary["categoryName"] = categoryName
                        }
                        if let categoryIconString = categoryJson["icon"].string {
                            newFeedDictionary["categoryIconString"] = categoryIconString
                        }
                        let newFeed = FeedEvent(dictionary: newFeedDictionary)
                        newFedDayObject.feed.append(newFeed)
                    }
                    tempFeedArray.append(newFedDayObject)
                }
                // assign new values
                self.feedArray = tempFeedArray
                NSNotificationCenter.defaultCenter().postNotificationName(NotificationForPhobosFeedIsReady, object: nil)
            }
        }
    }
}
