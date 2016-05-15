//
//  UserInfoView.swift
//  forPhobos
//
//  Created by Roman Spirichkin on 15/05/16.
//  Copyright © 2016 rs. All rights reserved.
//

import UIKit

class UserInfoView: UIView {
    
    @IBOutlet weak var milesLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    
    override func awakeFromNib() {
        setView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    func setView() {
        self.frame.size = CGSizeMake(UIScreen.mainScreen().bounds.width, 52)
    }
    
    
}
