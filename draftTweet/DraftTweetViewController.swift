//
//  DraftTweetViewController.swift
//  draftTweet
//
//  Created by 田上健太 on 2/18/15.
//  Copyright (c) 2015 田上健太. All rights reserved.
//

import UIKit

class DraftTweetViewController: UIViewController, UITextViewDelegate , UITextFieldDelegate{

    @IBOutlet weak var displayCounterButton: UIButton!

    @IBOutlet weak var saveButton: UIBarButtonItem!

    @IBOutlet weak var cancelButton: UIBarButtonItem!

    @IBOutlet weak var inputTextView: UITextView!

    var tweetModel = TweetModel()
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate

    func changeCounterValue(counterValue: String){
        self.displayCounterButton.setTitle("\(140 - countElements(counterValue))", forState: .Normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.inputTextView.delegate = self

        var tweetContent:String = ""
        var tweetId:String = ""
        if appDelegate.editMode == true{
            tweetContent = appDelegate.tweetContent!
            tweetId = appDelegate.idNumber!
        }

        self.inputTextView.text = tweetContent
        self.changeCounterValue(tweetContent)
        // Do any additional setup after loading the view.
        self.inputTextView.becomeFirstResponder()
    }

    func textViewDidChange(textView: UITextView!){
        self.changeCounterValue(self.inputTextView.text)
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
