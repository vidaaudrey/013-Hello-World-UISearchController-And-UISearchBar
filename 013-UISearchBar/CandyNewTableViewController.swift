//
//  CandyNewTableViewController.swift
//  013-UISearchBar
//
//  Created by Audrey Li on 4/7/15.
//  Copyright (c) 2015 com.shomigo. All rights reserved.
//

import UIKit


class CandyNewTableViewController: UITableViewController, UISearchResultsUpdating {

    var data = [Candy]()
    var filteredData = [Candy]()
    var resultSearchController = UISearchController()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.data = [Candy(category:"Chocolate", name:"chocolate Bar"),
            Candy(category:"Chocolate", name:"chocolate Chip"),
            Candy(category:"Chocolate", name:"dark chocolate"),
            Candy(category:"Hard", name:"lollipop"),
            Candy(category:"Hard", name:"candy cane"),
            Candy(category:"Hard", name:"jaw breaker"),
            Candy(category:"Other", name:"caramel"),
            Candy(category:"Other", name:"sour chew"),
            Candy(category:"Other", name:"gummi bear")]

        
        self.resultSearchController = {
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.hidesNavigationBarDuringPresentation = false  // default true
            controller.searchBar.sizeToFit()
            
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        }()
        
        self.tableView.reloadData()
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        filteredData = data.filter{ $0.name.rangeOfString(searchController.searchBar.text) != nil }
       
        self.tableView.reloadData()
    }


    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.resultSearchController.active {
            return self.filteredData.count
        }else {
            return self.data.count
        }
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("newCell", forIndexPath: indexPath) as UITableViewCell
        
        var candy: Candy
        if self.resultSearchController.active {
            candy = filteredData[indexPath.row]
        } else {
           candy = data[indexPath.row]
        }
        
        cell.textLabel?.text = candy.name

        return cell
    }
  
}
