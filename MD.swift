//
//  MD.swift
//  010-Material-Design-Color-Play
//
//  Created by Audrey Li on 4/7/15.
//  Copyright (c) 2015 UIColle. All rights reserved.
//

import Foundation
import UIKit


extension Dictionary {
    func toArray <V> (mapFunction map: (Key, Value) -> V) -> [V] {
        
        var mapped = [V]()
        
        each {
            mapped.append(map($0, $1))
        }
        
        return mapped
        
    }
    func each (eachFunction each: (Key, Value) -> ()) {
        
        for (key, value) in self {
            each(key, value)
        }
        
    }
}

extension Array {
    func random() -> Element {
        let randomIndex = Int.random(self.count)
        return self[randomIndex]
    }
    
    func contains <T: Equatable> (items: T...) -> Bool {
        return items.all { self.indexOf($0) >= 0 }
    }
    
    func all (test: (Element) -> Bool) -> Bool {
        for item in self {
            if !test(item) {
                return false
            }
        }
        
        return true
    }
    func indexOf <U: Equatable> (item: U) -> Int? {
        if item is Element {
            return Swift.find(unsafeBitCast(self, [U].self), item)
        }
        
        return nil
    }
}

class MD {
    let red: [String: Color]!
    let pink: [String: Color]!
    let purple: [String: Color]!
    let deep_purple: [String: Color]!
    let indigo: [String: Color]!
    let blue: [String: Color]!
    let light_blue: [String: Color]!
    let cyan: [String: Color]!
    let teal: [String: Color]!
    let green: [String: Color]!
    let light_green: [String: Color]!
    let lime: [String: Color]!
    let yellow: [String: Color]!
    let amber: [String: Color]!
    let orange: [String: Color]!
    let deep_orange: [String: Color]!
    let brown: [String: Color]!
    let grey: [String: Color]!
    let blue_grey: [String: Color]!
    
    let totalMDDict: [String: [String: Color]]!
    
    let totalColorNumber = 256
    let totalPrimaryCOlorNumber = 19
    let totalSubColorNumber = 14
    
    let exceptionColors: [[String: Color]]!
    
    let exceptionalColorNames = ["brown", "grey", "blue_grey"]
    let lightIndexNumbers = ["P50", "P100", "P200", "P300", "P400", "P500", "A100", "A200"]
    let darkIndexNumbers = ["P600", "P700", "P800", "P900", "A400", "A700"]
    
    
    // return a random color in the dictionary
    func getColorNameArray() -> [String]{
        return [String](totalMDDict.keys)
    }
    
    func getSubColorNameArray(primaryColor: String) -> [String] {
        return [String](totalMDDict[primaryColor]!.keys)
    }
    
    func getColorArray2D() ->[[Color]] {
        var returnArr:[[Color]] = [[]]
        
        for (K,V) in totalMDDict {
            var tempArr = V.toArray{$1}
            returnArr.append(tempArr)
        }
        
        return returnArr
    }
    func getColorArray() ->[Color] {
        var returnArr:[Color] = []
        
        for (K,V) in totalMDDict {
            for (K1, V1) in V as [String: Color] {
                returnArr.append(V1)
            }
        }
        
        return returnArr
    }
    

    
    func random() -> Color {
        
        let colorArray = getColorArray()
        return colorArray[Int.random(colorArray.count)]
    }
    
    // return a random Primary Color
     func randomPrimary() -> Color {
        let colorArray = getColorArray2D()
        return colorArray[Int.random(colorArray.count)][5] // 5 is index for P500
        
    }
    //return a random sub color
     func random(primaryColor: String) -> Color{
        
        let colorArray = totalMDDict[primaryColor]!.toArray{$1}
        return colorArray[Int.random(colorArray.count)]
    }
    
    func randomLight() -> Color {
        
        var ranColorName = getColorNameArray().random()
        var tempLightIndexNumbers = lightIndexNumbers
        if exceptionalColorNames.contains(ranColorName){
            tempLightIndexNumbers.removeLast()
            tempLightIndexNumbers.removeLast()
        }
        
        return totalMDDict[ranColorName]![tempLightIndexNumbers.random()]!
    }
    
    func randomDark() -> Color {
        var ranColorName = getColorNameArray().random()
        var tempDarkIndexNumbers = darkIndexNumbers
        if exceptionalColorNames.contains(ranColorName){
            tempDarkIndexNumbers.removeLast()
            tempDarkIndexNumbers.removeLast()
        }
        
        return totalMDDict[ranColorName]![tempDarkIndexNumbers.random()]!
    }
    
    
    init() {
        
        red =  [
            "P50" : Color(hex: "#FFEBEE"),
            "P100" : Color(hex: "#FFCDD2"),
            "P200" : Color(hex: "#EF9A9A"),
            "P300" : Color(hex: "#E57373"),
            "P400" : Color(hex: "#EF5350"),
            "P500" : Color(hex: "#F44336"),
            "P600" : Color(hex: "#E53935"),
            "P700" : Color(hex: "#D32F2F"),
            "P800" : Color(hex: "#C62828"),
            "P900" : Color(hex: "#B71C1C"),
            "A100" : Color(hex: "#FF8A80"),
            "A200" : Color(hex: "#FF5252"),
            "A400" : Color(hex: "#FF1744"),
            "A700" : Color(hex: "#D50000"),
        ]
        pink =  [
            "P50" : Color(hex: "#FCE4EC"),
            "P100" : Color(hex: "#F8BBD0"),
            "P200" : Color(hex: "#F48FB1"),
            "P300" : Color(hex: "#F06292"),
            "P400" : Color(hex: "#EC407A"),
            "P500" : Color(hex: "#E91E63"),
            "P600" : Color(hex: "#D81B60"),
            "P700" : Color(hex: "#C2185B"),
            "P800" : Color(hex: "#AD1457"),
            "P900" : Color(hex: "#880E4F"),
            "A100" : Color(hex: "#FF80AB"),
            "A200" : Color(hex: "#FF4081"),
            "A400" : Color(hex: "#F50057"),
            "A700" : Color(hex: "#C51162"),
        ]
        purple =  [
            "P50" : Color(hex: "#F3E5F5"),
            "P100" : Color(hex: "#E1BEE7"),
            "P200" : Color(hex: "#CE93D8"),
            "P300" : Color(hex: "#BA68C8"),
            "P400" : Color(hex: "#AB47BC"),
            "P500" : Color(hex: "#9C27B0"),
            "P600" : Color(hex: "#8E24AA"),
            "P700" : Color(hex: "#7B1FA2"),
            "P800" : Color(hex: "#6A1B9A"),
            "P900" : Color(hex: "#4A148C"),
            "A100" : Color(hex: "#EA80FC"),
            "A200" : Color(hex: "#E040FB"),
            "A400" : Color(hex: "#D500F9"),
            "A700" : Color(hex: "#AA00FF"),
        ]
        deep_purple =  [
            "P50" : Color(hex: "#EDE7F6"),
            "P100" : Color(hex: "#D1C4E9"),
            "P200" : Color(hex: "#B39DDB"),
            "P300" : Color(hex: "#9575CD"),
            "P400" : Color(hex: "#7E57C2"),
            "P500" : Color(hex: "#673AB7"),
            "P600" : Color(hex: "#5E35B1"),
            "P700" : Color(hex: "#512DA8"),
            "P800" : Color(hex: "#4527A0"),
            "P900" : Color(hex: "#311B92"),
            "A100" : Color(hex: "#B388FF"),
            "A200" : Color(hex: "#7C4DFF"),
            "A400" : Color(hex: "#651FFF"),
            "A700" : Color(hex: "#6200EA"),
        ]
        indigo =  [
            "P50" : Color(hex: "#E8EAF6"),
            "P100" : Color(hex: "#C5CAE9"),
            "P200" : Color(hex: "#9FA8DA"),
            "P300" : Color(hex: "#7986CB"),
            "P400" : Color(hex: "#5C6BC0"),
            "P500" : Color(hex: "#3F51B5"),
            "P600" : Color(hex: "#3949AB"),
            "P700" : Color(hex: "#303F9F"),
            "P800" : Color(hex: "#283593"),
            "P900" : Color(hex: "#1A237E"),
            "A100" : Color(hex: "#8C9EFF"),
            "A200" : Color(hex: "#536DFE"),
            "A400" : Color(hex: "#3D5AFE"),
            "A700" : Color(hex: "#304FFE"),
        ]
        blue =  [
            "P50" : Color(hex: "#E3F2FD"),
            "P100" : Color(hex: "#BBDEFB"),
            "P200" : Color(hex: "#90CAF9"),
            "P300" : Color(hex: "#64B5F6"),
            "P400" : Color(hex: "#42A5F5"),
            "P500" : Color(hex: "#2196F3"),
            "P600" : Color(hex: "#1E88E5"),
            "P700" : Color(hex: "#1976D2"),
            "P800" : Color(hex: "#1565C0"),
            "P900" : Color(hex: "#0D47A1"),
            "A100" : Color(hex: "#82B1FF"),
            "A200" : Color(hex: "#448AFF"),
            "A400" : Color(hex: "#2979FF"),
            "A700" : Color(hex: "#2962FF"),
        ]
        light_blue =  [
            "P50" : Color(hex: "#E1F5FE"),
            "P100" : Color(hex: "#B3E5FC"),
            "P200" : Color(hex: "#81D4FA"),
            "P300" : Color(hex: "#4FC3F7"),
            "P400" : Color(hex: "#29B6FC"),
            "P500" : Color(hex: "#03A9F4"),
            "P600" : Color(hex: "#039BE5"),
            "P700" : Color(hex: "#0288D1"),
            "P800" : Color(hex: "#0277BD"),
            "P900" : Color(hex: "#01579B"),
            "A100" : Color(hex: "#80D8FF"),
            "A200" : Color(hex: "#40C4FF"),
            "A400" : Color(hex: "#00B0FF"),
            "A700" : Color(hex: "#0091EA"),
        ]
        cyan =  [
            "P50" : Color(hex: "#E0F7FA"),
            "P100" : Color(hex: "#B2EBF2"),
            "P200" : Color(hex: "#80DEEA"),
            "P300" : Color(hex: "#4DD0E1"),
            "P400" : Color(hex: "#26C6DA"),
            "P500" : Color(hex: "#00BCD4"),
            "P600" : Color(hex: "#00ACC1"),
            "P700" : Color(hex: "#0097A7"),
            "P800" : Color(hex: "#00838F"),
            "P900" : Color(hex: "#006064"),
            "A100" : Color(hex: "#84FFFF"),
            "A200" : Color(hex: "#18FFFF"),
            "A400" : Color(hex: "#00E5FF"),
            "A700" : Color(hex: "#00B8D4"),
        ]
        teal =  [
            "P50" : Color(hex: "#E0F2F1"),
            "P100" : Color(hex: "#B2DFDB"),
            "P200" : Color(hex: "#80CBC4"),
            "P300" : Color(hex: "#4DB6AC"),
            "P400" : Color(hex: "#26A69A"),
            "P500" : Color(hex: "#009688"),
            "P600" : Color(hex: "#00897B"),
            "P700" : Color(hex: "#00796B"),
            "P800" : Color(hex: "#00695C"),
            "P900" : Color(hex: "#004D40"),
            "A100" : Color(hex: "#A7FFEB"),
            "A200" : Color(hex: "#64FFDA"),
            "A400" : Color(hex: "#1DE9B6"),
            "A700" : Color(hex: "#00BFA5"),
        ]
        green =  [
            "P50" : Color(hex: "#E8F5E9"),
            "P100" : Color(hex: "#C8E6C9"),
            "P200" : Color(hex: "#A5D6A7"),
            "P300" : Color(hex: "#81C784"),
            "P400" : Color(hex: "#66BB6A"),
            "P500" : Color(hex: "#4CAF50"),
            "P600" : Color(hex: "#43A047"),
            "P700" : Color(hex: "#388E3C"),
            "P800" : Color(hex: "#2E7D32"),
            "P900" : Color(hex: "#1B5E20"),
            "A100" : Color(hex: "#B9F6CA"),
            "A200" : Color(hex: "#69F0AE"),
            "A400" : Color(hex: "#00E676"),
            "A700" : Color(hex: "#00C853"),
        ]
        light_green =  [
            "P50" : Color(hex: "#F1F8E9"),
            "P100" : Color(hex: "#DCEDC8"),
            "P200" : Color(hex: "#C5E1A5"),
            "P300" : Color(hex: "#AED581"),
            "P400" : Color(hex: "#9CCC65"),
            "P500" : Color(hex: "#8BC34A"),
            "P600" : Color(hex: "#7CB342"),
            "P700" : Color(hex: "#689F38"),
            "P800" : Color(hex: "#558B2F"),
            "P900" : Color(hex: "#33691E"),
            "A100" : Color(hex: "#CCFF90"),
            "A200" : Color(hex: "#B2FF59"),
            "A400" : Color(hex: "#76FF03"),
            "A700" : Color(hex: "#64DD17"),
        ]
        lime =  [
            "P50" : Color(hex: "#F9FBE7"),
            "P100" : Color(hex: "#F0F4C3"),
            "P200" : Color(hex: "#E6EE9C"),
            "P300" : Color(hex: "#DCE775"),
            "P400" : Color(hex: "#D4E157"),
            "P500" : Color(hex: "#CDDC39"),
            "P600" : Color(hex: "#C0CA33"),
            "P700" : Color(hex: "#A4B42B"),
            "P800" : Color(hex: "#9E9D24"),
            "P900" : Color(hex: "#827717"),
            "A100" : Color(hex: "#F4FF81"),
            "A200" : Color(hex: "#EEFF41"),
            "A400" : Color(hex: "#C6FF00"),
            "A700" : Color(hex: "#AEEA00"),
        ]
        yellow =  [
            "P50" : Color(hex: "#FFFDE7"),
            "P100" : Color(hex: "#FFF9C4"),
            "P200" : Color(hex: "#FFF590"),
            "P300" : Color(hex: "#FFF176"),
            "P400" : Color(hex: "#FFEE58"),
            "P500" : Color(hex: "#FFEB3B"),
            "P600" : Color(hex: "#FDD835"),
            "P700" : Color(hex: "#FBC02D"),
            "P800" : Color(hex: "#F9A825"),
            "P900" : Color(hex: "#F57F17"),
            "A100" : Color(hex: "#FFFF82"),
            "A200" : Color(hex: "#FFFF00"),
            "A400" : Color(hex: "#FFEA00"),
            "A700" : Color(hex: "#FFD600"),
        ]
        amber =  [
            "P50" : Color(hex: "#FFF8E1"),
            "P100" : Color(hex: "#FFECB3"),
            "P200" : Color(hex: "#FFE082"),
            "P300" : Color(hex: "#FFD54F"),
            "P400" : Color(hex: "#FFCA28"),
            "P500" : Color(hex: "#FFC107"),
            "P600" : Color(hex: "#FFB300"),
            "P700" : Color(hex: "#FFA000"),
            "P800" : Color(hex: "#FF8F00"),
            "P900" : Color(hex: "#FF6F00"),
            "A100" : Color(hex: "#FFE57F"),
            "A200" : Color(hex: "#FFD740"),
            "A400" : Color(hex: "#FFC400"),
            "A700" : Color(hex: "#FFAB00"),
        ]
        orange =  [
            "P50" : Color(hex: "#FFF3E0"),
            "P100" : Color(hex: "#FFE0B2"),
            "P200" : Color(hex: "#FFCC80"),
            "P300" : Color(hex: "#FFB74D"),
            "P400" : Color(hex: "#FFA726"),
            "P500" : Color(hex: "#FF9800"),
            "P600" : Color(hex: "#FB8C00"),
            "P700" : Color(hex: "#F57C00"),
            "P800" : Color(hex: "#EF6C00"),
            "P900" : Color(hex: "#E65100"),
            "A100" : Color(hex: "#FFD180"),
            "A200" : Color(hex: "#FFAB40"),
            "A400" : Color(hex: "#FF9100"),
            "A700" : Color(hex: "#FF6D00"),
        ]
        deep_orange =  [
            "P50" : Color(hex: "#FBE9A7"),
            "P100" : Color(hex: "#FFCCBC"),
            "P200" : Color(hex: "#FFAB91"),
            "P300" : Color(hex: "#FF8A65"),
            "P400" : Color(hex: "#FF7043"),
            "P500" : Color(hex: "#FF5722"),
            "P600" : Color(hex: "#F4511E"),
            "P700" : Color(hex: "#E64A19"),
            "P800" : Color(hex: "#D84315"),
            "P900" : Color(hex: "#BF360C"),
            "A100" : Color(hex: "#FF9E80"),
            "A200" : Color(hex: "#FF6E40"),
            "A400" : Color(hex: "#FF3D00"),
            "A700" : Color(hex: "#DD2600"),
        ]
        brown =  [
            "P50" : Color(hex: "#EFEBE9"),
            "P100" : Color(hex: "#D7CCC8"),
            "P200" : Color(hex: "#BCAAA4"),
            "P300" : Color(hex: "#A1887F"),
            "P400" : Color(hex: "#8D6E63"),
            "P500" : Color(hex: "#795548"),
            "P600" : Color(hex: "#6D4C41"),
            "P700" : Color(hex: "#5D4037"),
            "P800" : Color(hex: "#4E342E"),
            "P900" : Color(hex: "#3E2723"),
        ]
        grey =  [
            "P50" : Color(hex: "#FAFAFA"),
            "P100" : Color(hex: "#F5F5F5"),
            "P200" : Color(hex: "#EEEEEE"),
            "P300" : Color(hex: "#E0E0E0"),
            "P400" : Color(hex: "#BDBDBD"),
            "P500" : Color(hex: "#9E9E9E"),
            "P600" : Color(hex: "#757575"),
            "P700" : Color(hex: "#616161"),
            "P800" : Color(hex: "#424242"),
            "P900" : Color(hex: "#212121"),
            "P1000" : Color(hex: "#000000"),
            "WP1000" : Color(hex: "#FFFFFF"),
        ]
        blue_grey =  [
            "P50" : Color(hex: "#ECEFF1"),
            "P100" : Color(hex: "#CFD8DC"),
            "P200" : Color(hex: "#B0BBC5"),
            "P300" : Color(hex: "#90A4AE"),
            "P400" : Color(hex: "#78909C"),
            "P500" : Color(hex: "#607D8B"),
            "P600" : Color(hex: "#546E7A"),
            "P700" : Color(hex: "#455A64"),
            "P800" : Color(hex: "#37474F"),
            "P900" : Color(hex: "#263238"),
        ]
        
        totalMDDict = ["red": red, "pink": pink, "purple": purple, "deep_purple": deep_purple, "indigo": indigo, "blue": blue, "light_blue": light_blue, "cyan": cyan, "teal": teal, "green": green, "light_green": light_green, "lime": lime, "yellow": yellow, "amber": amber, "orange": orange, "deep_orange": deep_orange, "brown": brown, "grey": grey, "blue_grey": blue_grey]
        exceptionColors = [brown, grey, blue_grey]
    }
    
   }


