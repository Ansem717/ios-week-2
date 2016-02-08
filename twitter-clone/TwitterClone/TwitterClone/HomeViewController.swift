//
//  ViewController.swift
//  TwitterClone
//
//  Created by Andy Malik on 2/8/16.
//  Copyright © 2016 Andy Malik. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    var tweetData = [Tweet]() {
        didSet {
            //
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool)
    {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func update()
    {
        JSONParser.tweetJSONFrom(JSONParser.JSONData()) { (success, tweets) -> () in
            if success {
                if let tweets = tweets {
                    self.tweetData = tweets
                }
            }
        }
    }
    
}

