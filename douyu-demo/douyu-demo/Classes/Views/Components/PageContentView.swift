//
//  PageContentView.swift
//  douyu-demo
//
//  Created by Aidan on 2017/9/10.
//  Copyright © 2017年 Aidan. All rights reserved.
//

import UIKit

let PageContentCellID = "PageContentCellID"

class PageContentView: UIView {
    
    let childrenVC: [UIViewController]
    weak var parentVC: UIViewController?
    
    lazy var collectionView: UICollectionView = {[weak self] in
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.dataSource = self
        view.delegate = self
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.bounces = false
        
        return view
    }()

    init(frame: CGRect, childrenVC: [UIViewController], parentVC: UIViewController?) {
        self.childrenVC = childrenVC
        self.parentVC = parentVC
        super.init(frame: frame)
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: PageContentCellID)
        
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        for vc in childrenVC {
            parentVC?.addChildViewController(vc)
        }
        
        addSubview(collectionView)
        collectionView.frame = bounds
        
    }

}

extension PageContentView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childrenVC.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PageContentCellID, for: indexPath)
        
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        
        let vc = childrenVC[indexPath.item]
        vc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(vc.view)
        
        return cell
    }
}

extension PageContentView {
    func setPage(index: Int) {
        let offsetX = kScreenW * CGFloat(index)
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
