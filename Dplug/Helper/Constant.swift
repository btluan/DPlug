//
//  Constant.swift
//  Dplug
//
//  Created by Lan Tran on 8/14/17.
//  Copyright © 2017 JamesBui. All rights reserved.
//

import UIKit

class Constant: NSObject {
    /*****************
     * Define Font Size
     *****************/
    //Big Font
    static let bigFontNomal = UIFont.systemFont(ofSize: 14)
    static let bigFontBold = UIFont.boldSystemFont(ofSize: 14)
    //Medium Font
    static let mediumFontNomal = UIFont.systemFont(ofSize: 12)
    static let mediumFontBold = UIFont.boldSystemFont(ofSize: 12)
    //Small Font
    static let smallFontNomal = UIFont.systemFont(ofSize: 10)
    static let smallFontBold = UIFont.boldSystemFont(ofSize: 10)
    
    /*****************
    * Define Color
    ******************/
    //Main Color
    static let mainColor = UIColor(red: 255/255, green: 101/255, blue: 1/255, alpha: 1)
    //Main Text Color
    static let mainTextColor = UIColor(red: 150/255, green: 150/255, blue: 150/255, alpha: 1)
    //Background ViewController
    static let mainViewControllerColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
    
    
    /*****************
    * Define Width & Height of Screen
    ******************/
    //Width
    static let width = UIScreen.main.bounds.size.width
    //Height
    static let height = UIScreen.main.bounds.size.height
    
    
    
}
