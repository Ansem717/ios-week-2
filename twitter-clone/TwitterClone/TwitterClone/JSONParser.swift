//
//  JSONParser.swift
//  TwitterClone
//
//  Created by Andy Malik on 2/8/16.
//  Copyright © 2016 Andy Malik. All rights reserved.
//

import Foundation

typealias JSONParserCompletion = (success: Bool, tweets: [Tweet]?) -> ()

class JSONParser
{
    
    class func tweetJSONFrom(data: NSData, completion: JSONParserCompletion)
    {
        do {
            if let rootObject = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [[String : AnyObject]] {
                
            var tweets = [Tweet]()
                
                for tweetJSON in rootObject {
                    if let
                        text = tweetJSON["text"] as? String,
                        id = tweetJSON["id_str"] as? String,
                        userJSON = tweetJSON["user"] as? [String : AnyObject]
                    {
                        let user = self.userFromTweetJSON(userJSON)
                        let tweet = Tweet(text: text, id: id, user: user)
                        
                        tweets.append(tweet)
                    }
                }
                
                completion(success: true, tweets: tweets)
            }
        } catch _  {
            completion(success: false, tweets: nil)
        }
    }

    //MARK: Helper functions

    class func userFromTweetJSON(tweetJSON: [String : AnyObject]) -> User
    {
        guard let name = tweetJSON["name"] as? String else { fatalError("Failed to parse the name.") }
        guard let profileImgURL = tweetJSON["profile_image_url"] as? String else { fatalError() }
        guard let location = tweetJSON["location"] as? String else { fatalError() }
        
        return User(name: name, profileImgURL: profileImgURL, location: location)
    }

    //MARK: Loading JSON from bundle
    class func JSONData() -> NSData
    {
        guard let tweetJSONPath = NSBundle.mainBundle().URLForResource("tweet", withExtension: "json") else { fatalError("Local file tweet.json not found.") }
        guard let tweetJSONData = NSData(contentsOfFile: tweetJSONPath) else { fatalError("Error creating NSData Object") }
        return tweetJSONData
    }
}





