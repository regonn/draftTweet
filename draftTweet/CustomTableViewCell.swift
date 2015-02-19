//
//  CustomTableViewCell.swift
//  draftTweet
//
//  Created by 田上健太 on 2/18/15.
//  Copyright (c) 2015 田上健太. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet weak var tweetContentLabel: UILabel!

    @IBOutlet weak var copyButton: UIButton!
    
    
    @IBOutlet weak var editButton: UIButton!
    
    
    func copyButtonTappedOnCell() {
        UIPasteboard.generalPasteboard().string = self.tweetContentLabel.text
    }
    
    func editButtonTappedOnCell() {
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        appDelegate.tweetContent = self.tweetContentLabel.text
    }
}
