//
//  CandyTableViewController.swift
//  013-UISearchBar
//
//  Created by Audrey Li on 4/6/15.
//  Copyright (c) 2015 com.shomigo. All rights reserved.
//

import UIKit

private struct Constants {
    static let ShowDetailIdentifier = "showDetail"
}

class CandyTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {

    var data = [Candy]()
    var filteredData = [Candy]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 68.0
        tableView.rowHeight = UITableViewAutomaticDimension

        self.data = [Candy(category:"Chocolate", name:"chocolate Bar"),
            Candy(category:"Chocolate", name:"chocolate Chip"),
            Candy(category:"Chocolate", name:"dark chocolate"),
            Candy(category:"Hard", name:"lollipop"),
            Candy(category:"Hard", name:"candy cane"),
            Candy(category:"Hard", name:"jaw breaker"),
            Candy(category:"Other", name:"caramel"),
            Candy(category:"Other", name:"sour chew"),
            Candy(category:"Other", name:"gummi bear")]
        

        self.tableView.reloadData()
    }

    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        println("text changed \(searchText)")
        data.removeRange(0..<4)
        self.tableView.reloadData()
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier(Constants.ShowDetailIdentifier, sender: tableView)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == Constants.ShowDetailIdentifier {
            let  candyDetailViewController = segue.destinationViewController as UIViewController
            if sender as UITableView == self.searchDisplayController!.searchResultsTableView {
                let indexPath = self.searchDisplayController!.searchResultsTableView.indexPathForSelectedRow()!
                candyDetailViewController.title = self.filteredData[indexPath.row].name
            } else {
                let indexPath = self.tableView.indexPathForSelectedRow()!
                candyDetailViewController.title = self.data[indexPath.row].name
            }
        }
    }
    
    func filterContentForSearchText(searchText:String){
        self.filteredData = self.data.filter({ (candy: Candy)-> Bool in
            let stringMatch = candy.name.rangeOfString(searchText)
            return stringMatch != nil ? true : false
        })
    }
    
    func filterContentForSearchTextWithScope(searchText: String, scope: String = "All") {
        self.filteredData = self.data.filter({( candy : Candy) -> Bool in
            var categoryMatch = (scope == "All") || (candy.category == scope)
            var stringMatch = candy.name.rangeOfString(searchText)
            return categoryMatch && (stringMatch != nil)
        })
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
      //  self.filterContentForSearchText(self.searchDisplayController!.searchBar.text)
        
        let scope = self.searchDisplayController!.searchBar.scopeButtonTitles as [String]
        self.filterContentForSearchTextWithScope(self.searchDisplayController!.searchBar.text, scope: scope[searchOption])
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool {
       // self.filterContentForSearchText(searchString)
        
        let scopes = self.searchDisplayController!.searchBar.scopeButtonTitles as [String]
        let selectedScope = scopes[self.searchDisplayController!.searchBar.selectedScopeButtonIndex] as String
        self.filterContentForSearchTextWithScope(searchString, scope: selectedScope)
        return true
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return self.filteredData.count
        } else {
            return data.count
        }
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        var candy: Candy
        if tableView == self.searchDisplayController!.searchResultsTableView {
            candy = filteredData[indexPath.row]
        } else {
            candy = self.data[indexPath.row]
        }
        
        cell.textLabel!.text = candy.name
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator

        return cell
    }

}
