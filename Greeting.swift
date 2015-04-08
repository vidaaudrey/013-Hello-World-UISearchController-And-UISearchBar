//
//  Greeting.swift
//  013-UISearchBar
//
//  Created by Audrey Li on 4/7/15.
//  Copyright (c) 2015 com.shomigo. All rights reserved.
//


class Greeting {
    var language: String!
    var link : String!
    var description: String!
    var  greetingText: String!
    
    init(language: String?, link: String?, description: String?, greetingText: String?) {
        self.language = language
        self.link = link
        self.description = description
        self.greetingText = greetingText
    }
}