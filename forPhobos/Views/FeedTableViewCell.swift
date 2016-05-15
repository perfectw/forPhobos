//
//  FeedTableViewCell.swift
//  forPhobos
//
//  Created by Roman Spirichkin on 15/05/16.
//  Copyright © 2016 rs. All rights reserved.
//

import UIKit

class FeedTableViewCell: UITableViewCell {
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var minimilesLabel: UILabel!
    
    var feed : FeedEvent {
        didSet {
            //text
            self.dateLabel.attributedText = self.feed.dateString.RSAttributed(.SmallGray)
            if let category = self.feed.category {
                self.categoryLabel.attributedText = category.RSAttributed(.SmallGray)
            } else { self.categoryLabel.text = nil }
            if let detail = self.feed.details {
                self.detailLabel.attributedText = detail.RSAttributed(.Title)
            } else { self.detailLabel.text = nil }
            if let comment = self.feed.comment {
                self.commentLabel.attributedText = comment.RSAttributed()
            } else { self.commentLabel.text = nil }
            if let money = self.feed.moneyString {
                self.moneyLabel.attributedText = money.RSAttributed(.BrightRed)
            } else { self.moneyLabel.text = nil }
            if let minimiles = self.feed.minimilesString {
                self.minimilesLabel.attributedText = minimiles.RSAttributed(.FadedBlue)
            } else { self.minimilesLabel.text = nil }
            //image
            pictureView.layer.borderWidth = 1.0
            pictureView.layer.masksToBounds = false
            pictureView.layer.borderColor = UIColor.whiteColor().CGColor
            pictureView.layer.cornerRadius = ((pictureView.superview?.frame.height)!-16)/2
            pictureView.clipsToBounds = true
            if let icon = self.feed.categoryIconString {
                pictureView.image = UIImage(named: icon)
            }
            if pictureView.image == nil {
                pictureView.image = UIImage(named: "error")
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        feed = FeedEvent()
        super.init(coder: aDecoder)
        self.selectionStyle = .None
    }
}
