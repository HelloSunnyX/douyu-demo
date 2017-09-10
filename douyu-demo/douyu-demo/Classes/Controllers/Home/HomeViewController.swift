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

    lazy var pageTitleView: PageTitleView = {[weak self] in
        let frame = CGRect(x: 0, y: kStatusBarH + kNavBarH, width: kScreenW, height: kPageTitleViewH)
        let titles = ["推荐", "游戏", "娱乐", "趣玩"]
        let view = PageTitleView(frame: frame, titles: titles)
        view.delegate = self
        return view;
    }()
    
    lazy var pageContentView: PageContentView = {[weak self] in
        let contentH = kScreenH - kStatusBarH - kNavBarH - kPageTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavBarH + kPageTitleViewH, width: kScreenW, height: contentH)
        var childrenVC = [UIViewController]()
        for _ in 0..<4 {
            let vc = UIViewController()
            vc.view.backgroundColor = getRandomColor()
            childrenVC.append(vc)
        }
        let view = PageContentView(frame: contentFrame, childrenVC: childrenVC, parentVC: self)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        automaticallyAdjustsScrollViewInsets = false
        setupNavBarButton()
        view.addSubview(pageTitleView)
        view.addSubview(pageContentView)
        
    }
    
    func setupNavBarButton() {
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(imageName: "logo")
        
        let rightItemSize = CGSize.init(width: 40, height: 40)
        let scan = UIBarButtonItem.init(imageName: "Image_scan", hlImageName: "Image_scan_click", size: rightItemSize)
        let search = UIBarButtonItem.init(imageName: "btn_search", hlImageName: "btn_search_clicked", size: rightItemSize)
        let history = UIBarButtonItem.init(imageName: "image_my_history", hlImageName: "Image_my_history_click", size: rightItemSize)
        
        navigationItem.rightBarButtonItems = [history, search, scan]
    }

}

extension HomeViewController: PageTitleViewDelegate {
    
    func onSelectTitle(titleView: PageTitleView, index: Int) {
        pageContentView.setPage(index: index)
    }
}
