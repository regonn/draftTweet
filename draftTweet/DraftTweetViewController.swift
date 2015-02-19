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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        self.inputTextField.delegate = self
        self.inputTextField.placeholder = "Please input"
        var tweetContent:String = appDelegate.tweetContent!
        self.inputTextField.text = tweetContent
        self.stringCounterLabel.text = "\(140 - countElements(tweetContent))"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func textField(textField: UITextField!, shouldChangeCharactersInRange range: NSRange, replacementString string: String!) -> Bool {

        // 文字数最大を決める.

        // 入力済みの文字と入力された文字を合わせて取得.
        var str = textField.text + string

        // 文字数がmaxLength以下ならtrueを返す.
        self.stringCounterLabel.text = "\(140 - countElements(str))"
        return true
    }



    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender as UIBarButtonItem != self.saveButton {
            return
        }
        if countElements(self.inputTextField.text) > 0 {
            tweetModel.add(self.inputTextField.text)
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
