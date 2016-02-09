//
//  JSONParser.swift
//  TwitterClone
//
//  Created by Andy Malik on 2/8/16.
//  Copyright © 2016 Andy Malik. All rights reserved.
//

import Foundation

typealias JSONParserCompletion = (success: Bool, tweets: [Tweet]?) -> () //Creates a type alias for a tuple, whose key-value pairs are boolean and an optional array of classes of Tweets and returns an initializer?

class JSONParser
{
    
    class func tweetJSONFrom(data: NSData, completion: JSONParserCompletion) //Class function for Parsing the JSON
    {
        do { //ERROR HANDLING
            if let rootObject = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers) as? [[String : AnyObject]] {
                //RootObject is trying to serialize the JSON with an option that allows the dictionaries or arrays to be mutable, and checks if that is in the form of an array of dictionaries. If not, it goes to the catch down below.
            var tweets = [Tweet]()
            
                for tweetJSON in rootObject { //FOR LOOP of the array of dictionaries. tweetJSON is each dictionary in the array.
                    if let
                        text = tweetJSON["text"] as? String,
                        id = tweetJSON["id_str"] as? String,
                        userJSON = tweetJSON["user"] as? [String : AnyObject]
                    {                                                         //The if let statement is checking if the key-value pairs are 
                                                                             // returning the correct value type for the current tweet.
                        
                        let user = self.userFromTweetJSON(userJSON)     // If all is true, pass the user dictionary into the Helper Function
                        let tweet = Tweet(text: text, id: id, user: user) // Plug in all the data collected into a Tweet class.
                        
                        tweets.append(tweet) //Add that class to the array created earlier.
                    }
                }
                
                completion(success: true, tweets: tweets) //This is a function because of the typealias.
            }          //Above is when the JSON succeeds in grabbing data, below is when it fails.
        } catch _  {
            completion(success: false, tweets: nil)
        }
    }

    //MARK: Helper functions

    class func userFromTweetJSON(tweetJSON: [String : AnyObject]) -> User // HELPER FUNCTION, checks if user's data exists
    {
        guard let name = tweetJSON["name"] as? String else { fatalError("Failed to parse the name.") }
        guard let profileImgURL = tweetJSON["profile_image_url"] as? String else { fatalError() }
        guard let location = tweetJSON["location"] as? String else { fatalError() }
        
        return User(name: name, profileImgURL: profileImgURL, location: location) // Sends back a User class with the correct data.
    }

    //MARK: Loading JSON from bundle
    class func JSONData() -> NSData
    {
        guard let tweetJSONPath = NSBundle.mainBundle().URLForResource("tweet", withExtension: "json") else { fatalError("Local file tweet.json not found.") } //IF Path is not found, fatal
        guard let tweetJSONData = NSData(contentsOfURL: tweetJSONPath) else { fatalError("Error creating NSData Object") } //IF NSData cannot create the Object, fatal.
        return tweetJSONData //NSData created the object successfully, return the whole thing.
    }
}





