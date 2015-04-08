//
//  GreetingNewViewController.swift
//  013-UISearchBar
//
//  Created by Audrey Li on 4/7/15.
//  Copyright (c) 2015 com.shomigo. All rights reserved.
//

import UIKit

class GreetingNewViewController: UIViewController, UISearchResultsUpdating, UISearchBarDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchbarView: UIView!
    
    var resultSearchController = UISearchController()
    var searchButton: UIBarButtonItem!

    
    var items:[String: [AnyObject]]!
    var filteredItems: [String: [AnyObject]]!
    var dataSource: MultiSectionCollectionViewDataSource!
    
    var dvcData: AnyObject! //  data for destinationViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.items = GreetingObjectHandler(filename: Constant.GreetingJSONFileName).getGreetingsAsAnyObjects()
        filteredItems = items
       
        let md = MD()
        self.dataSource = MultiSectionCollectionViewDataSource(items: filteredItems, cellIdentifier: Constant.GreetingNewViewControllerCell, viewController: self, segueIdentifier: Constant.GreetingNewViewControllerSegue, configureBlock: { (cell, item) -> () in
            let actualCell = cell as CollectionViewCell
            actualCell.configureForItem(item)
            actualCell.backgroundColor = md.randomDark()
        })
        
        self.collectionView.reloadData()
        
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        
        addSearchBar()

    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let dvc = segue.destinationViewController as? GreetingDetailViewController {
            dvc.data = dvcData
        }
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        self.navigationItem.titleView = nil
        self.navigationItem.rightBarButtonItem = searchButton
    }
    
    func showSearch() {
        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.titleView = resultSearchController.searchBar
        resultSearchController.searchBar.becomeFirstResponder()
    }
    
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        let searchText = searchController.searchBar.text
        
        if searchText == nil || searchText == "" {
            filteredItems = items
        } else {
            
            var tempArray = items[Constant.GreetingOBJHandlerSectionKey]
            // Be careful when to cast the data. Here it must be at the right side, or it will not work.
            tempArray = (tempArray as [Greeting]).filter{ $0.language.lowercaseString.rangeOfString(searchController.searchBar.text) != nil || $0.greetingText.lowercaseString.rangeOfString(searchController.searchBar.text) != nil }

           filteredItems[Constant.GreetingOBJHandlerSectionKey] = tempArray

        }

        dataSource.updateItems(filteredItems)
        
        self.collectionView.reloadData()
       
    }
    
    func addSearchBar() {
        searchButton = UIBarButtonItem(barButtonSystemItem: .Search, target: self, action: "showSearch")
        navigationItem.rightBarButtonItem = searchButton
        self.resultSearchController = {
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.hidesNavigationBarDuringPresentation = false  // default true
            controller.searchBar.sizeToFit()
            return controller
            }()
        
        self.resultSearchController.searchBar.delegate = self
    }
    
}

struct Constant {
    static let GreetingNewViewControllerCell = "coCell"
    static let GreetingNewViewControllerSegue = "showGreetingDetail"
    static let GreetingJSONFileName = "greetings"
    static let GreetingOBJHandlerSectionKey = "section0"
}