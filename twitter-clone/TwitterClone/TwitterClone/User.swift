//
//  User.swift
//  TwitterClone
//
//  Created by Andy Malik on 2/8/16.
//  Copyright © 2016 Andy Malik. All rights reserved.
//

import Foundation

class User
{
    let name: String
    let profileImgURL: String
    let location: String
    
    init(name: String, profileImgURL: String, location: String)
    {
        self.name = name
        self.profileImgURL = profileImgURL
        self.location = location
    }
}