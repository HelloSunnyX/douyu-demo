//
//  Common.swift
//  douyu-demo
//
//  Created by Aidan on 2017/9/10.
//  Copyright © 2017年 Aidan. All rights reserved.
//

import UIKit

let kStatusBarH: CGFloat = 20
let kNavBarH: CGFloat = 44

let kScreenW: CGFloat = UIScreen.main.bounds.width
let kScreenH: CGFloat = UIScreen.main.bounds.height

func getRandomColor() -> UIColor {
    return UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
}
