//
//  DraftTweetViewController.swift
//  draftTweet
//
//  Created by 田上健太 on 2/18/15.
//  Copyright (c) 2015 田上健太. All rights reserved.
//

import UIKit

class DraftTweetViewController: UIViewController, UITextViewDelegate , UITextFieldDelegate{


    @IBOutlet weak var stringCounterLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!

    @IBOutlet weak var cancelButton: UIBarButtonItem!

    @IBOutlet weak var inputTextView: UITextView!

    var tweetModel = TweetModel()
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var ColorBlack = UIColor.blackColor()

        self.inputTextView.layer.borderColor = ColorBlack.CGColor
        self.inputTextView.layer.borderWidth = 1.0
        self.inputTextView.layer.cornerRadius = 5.0
        self.inputTextView.delegate = self

        var tweetContent:String = ""
        var tweetId:String = ""
        if appDelegate.editMode == true{
            tweetContent = appDelegate.tweetContent!
            tweetId = appDelegate.idNumber!
        }

        self.inputTextView.text = tweetContent
        self.stringCounterLabel.text = "\(140 - countElements(tweetContent))"
        // Do any additional setup after loading the view.
    }

    func textViewDidChange(textView: UITextView!){
        var str = self.inputTextView.text
        self.stringCounterLabel.text = "\(140 - countElements(str))"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
        
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender as? UIBarButtonItem != self.saveButton {
            return
        }
        if countElements(self.inputTextView.text) > 0 {
            if appDelegate.editMode == true{
                tweetModel.update(appDelegate.idNumber!, content: self.inputTextView.text!)
            }else{
                tweetModel.add(self.inputTextView.text)
            }
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
