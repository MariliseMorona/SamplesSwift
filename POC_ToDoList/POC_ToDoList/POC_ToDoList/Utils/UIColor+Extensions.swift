//
//  UIColor+Extensions.swift
//  POC_ToDoList
//
//  Created by marilise morona on 19/12/23.
//

import UIKit

extension UIColor {
    
    static let purpleApp = UIColor(hex: 0x836C95, alpha: 0.68)
    
    
    //MARK: - Methods Config
    convenience init(hex: UInt, alpha: CGFloat) {
        var red, green, blue: UInt
        
        red = ((hex & 0xFF0000) >> 16)
        green = ((hex & 0x00FF00) >> 8)
        blue = hex & 0x0000FF
        
        self.init(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: alpha )
    }
}
