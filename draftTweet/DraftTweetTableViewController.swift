//
//  DraftTweetTableViewController.swift
//  draftTweet
//
//  Created by 田上健太 on 2/18/15.
//  Copyright (c) 2015 田上健太. All rights reserved.
//

import UIKit

class DraftTweetTableViewController: UITableViewController, UITableViewDataSource {

    
    @IBOutlet weak var addButton: UIBarButtonItem!

    let tweetModel = TweetModel()
    var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate

    
    override func viewDidLoad() {
        println("start")
        super.viewDidLoad()
        self.tableView.rowHeight = 130

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        var tweets = self.tweetModel.all()
        return tweets.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ListPrototypeCell", forIndexPath: indexPath) as CustomTableViewCell
        var tweets = self.tweetModel.all()

        var tweet = tweets.objectAtIndex(indexPath.row) as Tweet
        if var label = cell.tweetContentLabel{
            label.text = tweet.content
        }
        if var idLabel = cell.idNumberLabel{
            idLabel.text = "\(tweet.id)"
        }
        return cell
    }
    
    func showCopyAlert(){
        let alertController = UIAlertController(title: "", message: "Copied!", preferredStyle: .Alert)
        
        let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        alertController.addAction(defaultAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func unwindToList(segue: UIStoryboardSegue) {
        self.tableView.reloadData()
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if sender as? UIBarButtonItem != self.addButton {
            return
        }
        appDelegate.editMode = false
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

    // 空だけど editActionsForRowAtIndexPathの起動に必要
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }

    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        var cell = tableView.cellForRowAtIndexPath(indexPath) as CustomTableViewCell
        var deleteAction = UITableViewRowAction(style: UITableViewRowActionStyle.Default, title: "Delete", handler: {
            (action: UITableViewRowAction!, indexPath: NSIndexPath!) in
            self.tweetModel.delete(cell.idNumberLabel.text!)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            return
        })
        var copyAction = UITableViewRowAction(style: UITableViewRowActionStyle.Normal, title: "Buffer", handler: {
            (action: UITableViewRowAction!, indexPath: NSIndexPath!) in
            var bufferURL = "bufferapp://?t=\(cell.tweetContentLabel.text!)".stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
            println(bufferURL)
            UIApplication.sharedApplication().openURL(NSURL(string: bufferURL!)!)
            return

        })
        return [deleteAction, copyAction]
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        var cell = tableView.cellForRowAtIndexPath(indexPath) as CustomTableViewCell
        appDelegate.tweetContent = cell.tweetContentLabel.text
        appDelegate.editMode = true
        appDelegate.idNumber = cell.idNumberLabel.text
    }
}
