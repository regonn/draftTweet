//
//  DraftTweetViewController.swift
//  draftTweet
//
//  Created by 田上健太 on 2/18/15.
//  Copyright (c) 2015 田上健太. All rights reserved.
//

import UIKit

class DraftTweetViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var inputTextField: UITextField!

    @IBOutlet weak var stringCounterLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    @IBOutlet weak var cancelButton: UIBarButtonItem!

    var tweetModel = TweetModel()
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.inputTextField.delegate = self
        self.inputTextField.placeholder = "Please input"
        var tweetContent:String = ""
        var tweetId:String = ""
        if appDelegate.editMode == true{
            tweetContent = appDelegate.tweetContent!
            tweetId = appDelegate.idNumber!
        }
        self.inputTextField.text = tweetContent
        self.stringCounterLabel.text = "\(140 - countElements(tweetContent))"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    @IBAction func editChange(sender: AnyObject) {
        var str = self.inputTextField.text
        self.stringCounterLabel.text = "\(140 - countElements(str))"
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender as? UIBarButtonItem != self.saveButton {
            return
        }
        if countElements(self.inputTextField.text) > 0 {
            if appDelegate.editMode == true{
                tweetModel.update(appDelegate.idNumber!, content: self.inputTextField.text!)
            }else{
                tweetModel.add(self.inputTextField.text)
            }
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
