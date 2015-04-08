//
//  ColorExtension.swift
//  010-Swift-Material-Design-Color-Kit
//
//  Created by Audrey Li on 3/27/15.
//  Copyright (c) 2015 UIColle. All rights reserved.
//

import Foundation

import Foundation

#if os(iOS)
    import UIKit
    typealias Color = UIColor
    #else
    import Cocoa
    typealias Color = NSColor
#endif

typealias RGBA = UInt

extension Color {
    convenience init(rgb: RGBA, alpha: CGFloat) {
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((rgb & 0xFF)) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    convenience init(rgba: RGBA){
        let sRgba = min(rgba,0xFFFFFFFF)
        let red: CGFloat = CGFloat((sRgba & 0xFF000000) >> 24) / 255.0
        let green: CGFloat = CGFloat((sRgba & 0x00FF0000) >> 16) / 255.0
        let blue: CGFloat = CGFloat((sRgba & 0x0000FF00) >> 8) / 255.0
        let alpha: CGFloat = CGFloat(sRgba & 0x000000FF) / 255.0
        
        self.init(red: red, green: green, blue:blue, alpha:alpha)
    }
    
     convenience init(hex: String){
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(advance(cString.startIndex, 1))
        }
        
        var rgb:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgb)
        
        if (countElements(cString) != 6) {
            rgb = 11119017
        }
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((rgb & 0xFF)) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
    
    convenience init(hex: String, alpha: CGFloat){
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(advance(cString.startIndex, 1))
        }
        
        var rgb:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgb)
        
        if (countElements(cString) != 6) {
            rgb = 11119017
        }
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0xFF00) >> 8) / 255.0
        let blue = CGFloat((rgb & 0xFF)) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)

    }
}
extension RGBA {
    var color: Color {
        return self > 0x00FFFFFF ? Color(rgba: self) : Color(rgb: self, alpha: 1)
    }
}



