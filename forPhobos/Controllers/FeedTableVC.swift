//
//  FeedTableVC.swift
//  forPhobos
//
//  Created by Roman Spirichkin on 13/05/16.
//  Copyright © 2016 rs. All rights reserved.
//

import UIKit
import HidingNavigationBar

class FeedViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var hidingNavBarManager: HidingNavigationBarManager?
    var refreshControl: UIRefreshControl!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        User.sharedInstance.getList()
        
        self.setRefreshControl()
        self.setHidingNavBarManager()
    }
    
    func setRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(FeedViewController.refresh(_:)), forControlEvents: .ValueChanged)
        tableView.addSubview(refreshControl)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(FeedViewController.reloadFeed(_:)), name: NotificationForPhobosFeedIsReady, object: nil)
    }
    func setHidingNavBarManager() {
        hidingNavBarManager = HidingNavigationBarManager(viewController: self, scrollView: tableView)
        hidingNavBarManager?.refreshControl = refreshControl
        hidingNavBarManager?.expansionResistance = 150
        setUserInfoView()
        self.navigationItem.title = "forPhobos"
//        navigationController!.navigationBar.barTintColor = UIColor.greenColor()
    }
    func setUserInfoView() {
        let userInfoView = UIView.fromNib(xibUserInfoView) as! UserInfoView
        userInfoView.balanceLabel.text = "\(User.sharedInstance.balance) ₽"
        userInfoView.milesLabel.text = "\(User.sharedInstance.miles) ✈︎"
        hidingNavBarManager?.addExtensionView(userInfoView)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        hidingNavBarManager?.viewWillAppear(animated)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        hidingNavBarManager?.viewDidLayoutSubviews()
    }
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        hidingNavBarManager?.viewWillDisappear(animated)
    }
    
    
    // MARK: Actions
    func refresh(sender:AnyObject) {
        User.sharedInstance.getList()
    }
    
    func reloadFeed(notification: NSNotification) {
        // reload all info, because changes are not determined
        self.tableView.reloadData()
        setUserInfoView()
        refreshControl.endRefreshing()
    }
    
    // MARK: - Table View
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return User.sharedInstance.feedArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return User.sharedInstance.feedArray[section].feed.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("FeedTableViewCell", forIndexPath: indexPath) as! FeedTableViewCell
        cell.feed = User.sharedInstance.feedArray[indexPath.section].feed[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // hardcode header
        let headerView = UIView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.width, 22))
        let headerLabel = UILabel(frame: CGRectMake(4, 4, UIScreen.mainScreen().bounds.width, 14))
        headerLabel.text = User.sharedInstance.feedArray[section].date
        headerLabel.font = UIFont(name: headerLabel.font.fontName, size: 14)
        headerLabel.numberOfLines = 0
        headerLabel.textAlignment = NSTextAlignment.Center
        headerView.addSubview(headerLabel)
        headerView.backgroundColor = UIColor.whiteColor()
        return headerView
    }
     func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 22
    }
    
    // MARK: Stuff
     func scrollViewShouldScrollToTop(scrollView: UIScrollView) -> Bool {
        hidingNavBarManager?.shouldScrollToTop()
        return true
    }

}
