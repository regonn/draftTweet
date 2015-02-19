//
//  CustomTableViewCell.swift
//  draftTweet
//
//  Created by 田上健太 on 2/18/15.
//  Copyright (c) 2015 田上健太. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    let tweetModel = TweetModel()
    
    @IBOutlet weak var tweetContentLabel: UILabel!

    @IBOutlet weak var copyButton: UIButton!
    
    
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    @IBOutlet weak var idNumberLabel: UILabel!
    
    func copyButtonTappedOnCell() {
        UIPasteboard.generalPasteboard().string = self.tweetContentLabel.text
    }
    
    func editButtonTappedOnCell() {
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        appDelegate.tweetContent = self.tweetContentLabel.text
        appDelegate.editMode = true
        appDelegate.idNumber = self.idNumberLabel.text
    }
    func deleteButtonTappedOnCell() {
        println("delete")
        tweetModel.delete(self.idNumberLabel.text!)
    }
}
