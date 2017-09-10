//
//  HomeViewController.swift
//  douyu-demo
//
//  Created by Aidan on 2017/9/10.
//  Copyright © 2017年 Aidan. All rights reserved.
//

import UIKit

private let kPageTitleViewH: CGFloat = 40

class HomeViewController: UIViewController {

    private lazy var pageTitleView: PageTitleView = {
        let frame = CGRect.init(x: 0, y: kStatusBarH + kNavBarH, width: kScreenW, height: kPageTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let view = PageTitleView(frame: frame, titles: titles)
        return view;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        setupNavBarButton()
        setupPageTitleView()
    }
    
    func setupNavBarButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(imageName: "logo")
        
        let rightItemSize = CGSize.init(width: 40, height: 40)
        let scan = UIBarButtonItem.init(imageName: "Image_scan", hlImageName: "Image_scan_click", size: rightItemSize)
        let search = UIBarButtonItem.init(imageName: "btn_search", hlImageName: "btn_search_clicked", size: rightItemSize)
        let history = UIBarButtonItem.init(imageName: "image_my_history", hlImageName: "Image_my_history_click", size: rightItemSize)
        
        navigationItem.rightBarButtonItems = [history, search, scan]
    }
    
    func setupPageTitleView() {
        view.addSubview(pageTitleView)
    }

}
