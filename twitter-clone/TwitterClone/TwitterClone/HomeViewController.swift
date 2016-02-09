//
//  ViewController.swift
//  TwitterClone
//
//  Created by Andy Malik on 2/8/16.
//  Copyright © 2016 Andy Malik. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource { //Creating new class named HomeViewController. It is inheriting from UIViewController and conforming to UITableViewDataSource.
    
    @IBOutlet weak var tableView: UITableView! // Connecting the view with the code
    
    var tweetData = [Tweet]() { //Array of Tweet classes based on the JSON files
        didSet {
            self.tableView.reloadData() //This function reloads the table view each time something is changed on the array.
        }
    }
    
    override func viewDidLoad() { // Original code
        super.viewDidLoad() // ^^^^^^^^^^^^^^^^^
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)   //Informing the view to animate
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()     //// Original code
    }
    
    func setupTableView()
    {
        self.tableView.dataSource = self //Setting the datasource of the visual aid to the class HomeViewController
                                        // This allows the view to update with any variable listed in this class.
    }
    
    func update() // This function grabs the JSON, parses it, and if successful, it sets the tweetData in this class
    {             // equal to an array of classes of Tweets (referenced in Tweet.swfit in Model)
        JSONParser.tweetJSONFrom(JSONParser.JSONData()) { (success, tweets) -> () in
            if success {
                if let tweets = tweets {
                    self.tweetData = tweets
                }
            }
        }
    }
}

extension HomeViewController
{
    func configureCellForIndexPath(indexPath: NSIndexPath) -> UITableViewCell //Function for conveyor-belting the table
    {
        let tweetCell = self.tableView.dequeueReusableCellWithIdentifier("tweetCell", forIndexPath: indexPath) //Grabs the tweetCell that has been dequeued by the user (dequeued means it is no longer visible)
        let tweet = self.tweetData[indexPath.row] // Grabs the specific Tweet from the array tweetData
        tweetCell.textLabel?.text = tweet.text // Sets the dequeued cell's text equal to the Tweet's text.
        
        return tweetCell //Returns the dequeued cell.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int //NECESSARY TO CONFROM TO UITableViewDataSource
    {
        self.tweetData.count //Returns maximum number of rows at any given time.
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell //NECESSARY TO CONFORM TO UITableViewDataSource
    {
        return self.configureCellForIndexPath(indexPath) //Returns the reused cell from confingureCellForIndexPath and adds it to the table
    }
}












