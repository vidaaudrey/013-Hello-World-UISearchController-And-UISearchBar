//
//  GreetingObjectHandler.swift
//  013-UISearchBar
//
//  Created by Audrey Li on 4/7/15.
//  Copyright (c) 2015 com.shomigo. All rights reserved.
//

import Foundation

class GreetingObjectHandler {
    var greetings: [Greeting] = []
    
    init(filename: String) {
        
        let filePath = NSBundle.mainBundle().pathForResource(filename, ofType: "json")
        let jsonData = NSData(contentsOfFile: filePath!)
        
        let json = JSON(data: jsonData!, options: NSJSONReadingOptions.AllowFragments, error: nil)
        
        
      //   var greeting = Greeting(language: "", link: "", description: "", greetingText: "")
        
        for (key: String, subJson: JSON) in json {
            
            var language:String?, link: String?, description:String?, greetingText: String?
            
            for (key1, value:JSON) in subJson {
                switch key1 {
                    case "linkText": language = value.string
                    case "link": link = value.string
                    case "value_2": description = value.string
                    case "value_1": greetingText = value.string
                    default: break
                }
                
            }
            let greeting = Greeting(language: language, link: link, description: description, greetingText: greetingText)
            greetings.append(greeting)

        }
        
    }
    func getGreetingsAsAnyObjects() -> [String: [AnyObject]]{
        
      return [Constant.GreetingOBJHandlerSectionKey: greetings.map { $0 as AnyObject }]
    }
    
    
    
}