//
//  GreetingDetailViewController.swift
//  013-UISearchBar
//
//  Created by Audrey Li on 4/7/15.
//  Copyright (c) 2015 com.shomigo. All rights reserved.
//

import UIKit

class GreetingDetailViewController: UIViewController {

    var data: AnyObject?
    
    @IBOutlet weak var greetingTextLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let data = self.data as? Greeting {
            self.title = data.language
            self.greetingTextLabel.text = data.greetingText
            self.descriptionLabel.text = data.description
            
        }
        
    }



}
