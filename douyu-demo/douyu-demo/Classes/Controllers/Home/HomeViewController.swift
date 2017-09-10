//
//  HomeViewController.swift
//  douyu-demo
//
//  Created by Aidan on 2017/9/10.
//  Copyright © 2017年 Aidan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }

}

extension HomeViewController {
    func setupUI() {
        setupNavBarButton()
    }
    
    func setupNavBarButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(imageName: "logo")
        
        let rightItemSize = CGSize.init(width: 40, height: 40)
        let scan = UIBarButtonItem.init(imageName: "Image_scan", hlImageName: "Image_scan_click", size: rightItemSize)
        let search = UIBarButtonItem.init(imageName: "btn_search", hlImageName: "btn_search_clicked", size: rightItemSize)
        let history = UIBarButtonItem.init(imageName: "image_my_history", hlImageName: "Image_my_history_click", size: rightItemSize)

        navigationItem.rightBarButtonItems = [scan, search, history]
    }
}
