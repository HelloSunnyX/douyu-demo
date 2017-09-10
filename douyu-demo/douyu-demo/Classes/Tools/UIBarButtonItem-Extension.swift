//
//  UIBarButtonItem-Extension.swift
//  douyu-demo
//
//  Created by Aidan on 2017/9/10.
//  Copyright © 2017年 Aidan. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    convenience init(imageName: String, hlImageName: String = "", size: CGSize = CGSize.zero) {
        let button = UIButton()
        button.setImage(UIImage.init(named: imageName), for: .normal)
        if hlImageName != "" {
            button.setImage(UIImage.init(named: hlImageName), for: .highlighted)
        }
        if size == CGSize.zero {
            button.sizeToFit()
        } else {
            button.frame = CGRect.init(origin: CGPoint.zero, size: size)
        }
        
        self.init(customView: button)
    }
}
