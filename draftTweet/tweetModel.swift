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
    
    init() {
        let (tb, err) = SD.existingTables()
        if !contains(tb, tableName) {
            if let err =
                SD.createTable(tableName, withColumnNamesAndTypes: [ "content": .StringVal]){

            } else {

            }
        }
    println(SD.databasePath())
    }

    func add(content: String){
        if let err = SD.executeChange("INSERT INTO ? (content) VALUES(?)", withArgs: [tableName, content]){
        } else {
            println(content)
        }
    }

    func update(id: String, content: String){
        if let err = SD.executeChange("UPDATE ? SET content = ? WHERE ID = ?", withArgs: [tableName, content, id]){
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
        let (resultSet, err) = SD.executeQuery("SELECT * FROM ? ORDER BY ID DESC", withArgs: [tableName])
        if err != nil {
        } else {
            for row in resultSet {
                if let id = row["ID"]?.asInt() {
                    var tweet :Tweet? = Tweet()
                    var content = row["content"]?.asString()
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