//
//  UIColor-Extension.swift
//  douyu-demo
//
//  Created by Aidan on 2017/9/10.
//  Copyright © 2017年 Aidan. All rights reserved.
//

import UIKit

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat = 1.0) {
        self.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: alpha)
    }
    
    func colorWithHex(hexColor:Int64) -> UIColor {
        
        let red = ((CGFloat)((hexColor & 0xFF0000) >> 16))/255.0;
        let green = ((CGFloat)((hexColor & 0xFF00) >> 8))/255.0;
        let blue = ((CGFloat)(hexColor & 0xFF))/255.0;
        
        return UIColor(r: red, g: green, b: blue)
    }
    
    func randomColor() -> UIColor? {
        return UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
    }
    
    func getRGBValue() -> (CGFloat, CGFloat, CGFloat) {
        guard let components = self.cgColor.components else {
            fatalError("color should set by RGB value!")
        }
        
        return (components[0] * 255, components[1] * 255, components[2] * 255)
    }
}
