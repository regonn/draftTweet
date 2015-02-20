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
        self.tableView.rowHeight = 150

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
        cell.copyButton.addTarget(cell, action: "copyButtonTappedOnCell", forControlEvents: UIControlEvents.TouchDown)
        cell.copyButton.addTarget(self, action: "showAlert", forControlEvents: UIControlEvents.TouchDown)
        cell.editButton.addTarget(cell, action: "editButtonTappedOnCell", forControlEvents: UIControlEvents.TouchDown)
        cell.deleteButton.addTarget(cell, action: "deleteButtonTappedOnCell", forControlEvents: UIControlEvents.TouchDown)
        return cell
    }
    
    func showAlert(){
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
    
    
}
