//
//  MultiSectionCollectionViewDataSource.swift
//  011-Country-Information
//
//  Created by Audrey Li on 4/5/15.
//  Copyright (c) 2015 com.shomigo. All rights reserved.
//


import UIKit


typealias CollectionViewCellConfigureBlock = (cell:UICollectionViewCell, item:AnyObject?) -> ()

class MultiSectionCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var items: [[AnyObject]]!
    var keys:[String]!
    
    var itemIdentifier:String?
    var configureCellBlock:CollectionViewCellConfigureBlock?
    
    var viewController: AnyObject!
    var segueIdentifier: String!
    
    init(items: [String: [AnyObject]], cellIdentifier: String, viewController: AnyObject, segueIdentifier:String, configureBlock: CollectionViewCellConfigureBlock) {
        
        self.itemIdentifier = cellIdentifier
        self.viewController = viewController
        self.segueIdentifier = segueIdentifier
        self.configureCellBlock = configureBlock
        
        for (K,V) in items {
            if keys == nil {
                self.items = [V]
                self.keys = [K]
            } else {
                self.keys.append(K)
                self.items.append(V)
            }
        }
        
    }
    
    func updateItems(items:[String: [AnyObject]]){
        self.items = nil
        self.keys = nil
        
        for (K,V) in items {
            if keys == nil {
                self.items = [V]
                self.keys = [K]
            } else {
                self.keys.append(K)
                self.items.append(V)
            }
        }
        
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
      // return keys.count
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items[section].count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.itemIdentifier!, forIndexPath: indexPath) as UICollectionViewCell
        let item: AnyObject = self.itemAtIndexPath(indexPath)
        
        if (self.configureCellBlock != nil) {
            self.configureCellBlock!(cell: cell, item: item)
        }
        
        return cell
    }
    
//    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
//        
//        switch kind {
//        case UICollectionElementKindSectionHeader:
//            
//            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "headerCell", forIndexPath: indexPath) as HeaderCollectionReusableView
//            headerView.titleLabel.text = keys[indexPath.section]
//            return headerView
//            
//        default:
//            assert(false, "Unexpected element kind")
//        }
//    }
    
    // must config the viewControllerType manually everytime. So far there is no way that I know of to directly get the class name of the object
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        if let vc = viewController as? GreetingNewViewController {
            vc.dvcData = items[indexPath.section][indexPath.row]
            vc.performSegueWithIdentifier(segueIdentifier, sender: viewController)
            
        } else {
            println("can not convert view controller")
        }
        
    }
    
    
    func itemAtIndexPath(indexPath: NSIndexPath) -> AnyObject {
        return self.items[indexPath.section][indexPath.row]
    }
    
}
