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
    
    var tableView = UITableView()
    
    @IBOutlet weak var tweetContentLabel: UILabel!

    @IBOutlet weak var copyButton: UIButton!
    
    
    @IBOutlet weak var editButton: UIButton!
    

    @IBOutlet weak var idNumberLabel: UILabel!
    
    let alert:UIAlertController = UIAlertController(title:"alert",
        message: "alertView",
        preferredStyle: UIAlertControllerStyle.Alert)
    
    let defaultAction:UIAlertAction = UIAlertAction(title: "Default",
        style: UIAlertActionStyle.Default,
        handler:{
            (action:UIAlertAction!) -> Void in
            println("Default")
    })
    
    func copyButtonTappedOnCell() {
        UIPasteboard.generalPasteboard().string = self.tweetContentLabel.text
    }
    
    func editButtonTappedOnCell() {
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        appDelegate.tweetContent = self.tweetContentLabel.text
        appDelegate.editMode = true
        appDelegate.idNumber = self.idNumberLabel.text
    }
}
