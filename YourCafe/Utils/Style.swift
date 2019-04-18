//
//  UIColor + themeColor.swift
//  YourCafe
//
//  Created by 이동건 on 18/04/2019.
//  Copyright © 2019 이동건. All rights reserved.
//

import UIKit

extension UIColor {
    static var orangeYellow: UIColor {
        return UIColor(red: 255/255.0, green: 167/255.0, blue: 0, alpha: 1)
    }
    
    static var dark: UIColor {
        return UIColor(red: 36/255.0, green: 43/255.0, blue: 54/255.0, alpha: 1)
    }
    
    static var greyish: UIColor {
        return UIColor(red: 164/255.0, green: 164/255.0, blue: 164/255.0, alpha: 1)
    }
}

extension UIFont {
    class var mediumDark: UIFont {
        return UIFont(name: "NanumSquareOTF_ac", size: 16.0)!
    }
    
    class var smallGreyish: UIFont {
        return UIFont(name: "NanumSquareOTF_ac", size: 13.0)!
    }
    
    class var smallDark: UIFont {
        return UIFont(name: "NanumSquareOTF_ac", size: 13.0)!
    }
}
