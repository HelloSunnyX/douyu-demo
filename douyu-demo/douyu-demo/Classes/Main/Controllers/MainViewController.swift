//
//  MainViewController.swift
//  douyu-demo
//
//  Created by Aidan on 2017/9/10.
//  Copyright © 2017年 Aidan. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    
    let storyboardNames: [String] = ["Home", "Live", "Follow", "Profile"]

    override func viewDidLoad() {
        super.viewDidLoad()

        for name in storyboardNames {
            addChildVc(storyboardName: name)
        }
    }
    
    private func addChildVc(storyboardName: String) {
        let vc = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()!
        addChildViewController(vc)
    }

}
