//
//  CollectionViewCell.swift
//  013-UISearchBar
//
//  Created by Audrey Li on 4/6/15.
//  Copyright (c) 2015 com.shomigo. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var textLabel: UILabel!
    
    @IBOutlet weak var greetingTextLabel: UILabel!

    func configureForItem(item: AnyObject?) {
        if let greeting:Greeting = item as? Greeting {
            self.textLabel.text = greeting.language
            self.greetingTextLabel.text = greeting.greetingText
        }
    }
}
