//
//  tweetModel.swift
//  draftTweet
//
//  Created by 田上健太 on 2/18/15.
//  Copyright (c) 2015 田上健太. All rights reserved.
//

import Foundation

class TweetModel {
    var tableName = "tweets"

    let dateFormatter = NSDateFormatter()


    
    init() {
        let (tb, err) = SD.existingTables()
        if !contains(tb, tableName) {
            if let err =
                SD.createTable(tableName, withColumnNamesAndTypes: [ "Content": .StringVal, "UpdatedAt": .StringVal]){

            } else {

            }
        }
    println(SD.databasePath())
    }

    func dateTimeNow() -> NSString {
        let now = NSDate()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
        return dateFormatter.stringFromDate(NSDate())
    }

    func add(content: String){
        if let err = SD.executeChange("INSERT INTO ? (Content, UpdatedAt) VALUES(?, ?)", withArgs: [tableName, content, dateTimeNow()]){
        } else {
            println(content)
        }
    }

    func update(id: String, content: String){
        println("UPDATE ID:\(id) CONTENT:\(content)")
        if let err = SD.executeChange("UPDATE ? SET Content = ?, UpdatedAt = ? WHERE ID = ?", withArgs: [tableName, content, dateTimeNow(), id]){
            println(err)
        }else{

        }
    }

    func delete(id: String){
        if let err = SD.executeChange("DELETE FROM ? WHERE ID = ?", withArgs: [tableName, id]){
        }else{
        }
    }

    func all() -> NSMutableArray {
        var tweets = NSMutableArray()
        let (resultSet, err) = SD.executeQuery("SELECT * FROM ? ORDER BY UpdatedAt DESC", withArgs: [tableName])
        if err != nil {
            println(err)
        } else {
            for row in resultSet {
                if let id = row["ID"]?.asInt() {
                    var tweet :Tweet? = Tweet()
                    var content = row["Content"]?.asString()
                    var upDatedAt = row["UpdatedAt"]?.asString()
                    println("show ID:\(id) CONTENT:\(content) UPDATEDAT:\(upDatedAt)")
                    tweet!.content = content!
                    tweet!.id = id
                    tweets.addObject(tweet!)
                    println(tweet!)
                }
            }
        }
        return tweets
    }
}