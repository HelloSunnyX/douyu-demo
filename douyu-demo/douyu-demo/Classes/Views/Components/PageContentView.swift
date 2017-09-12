//
//  PageContentView.swift
//  douyu-demo
//
//  Created by Aidan on 2017/9/10.
//  Copyright © 2017年 Aidan. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate: class {
    func onScroll(progress: CGFloat, sourceIndex: Int, targetIndex: Int)
}

let PageContentCellID = "PageContentCellID"

class PageContentView: UIView {
    
    weak var delegate: PageContentViewDelegate?
    let childrenVC: [UIViewController]
    weak var parentVC: UIViewController?
    var startOffsetX: CGFloat = 0
    
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

extension PageContentView: UICollectionViewDataSource {
    
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

extension PageContentView: UICollectionViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        let ratio = currentOffsetX / scrollViewW
        let resolvedRatio = ratio - floor(ratio)
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
    
        if currentOffsetX - startOffsetX > 0 {
            progress = resolvedRatio
            sourceIndex = Int(ratio)
            targetIndex = sourceIndex + 1
            if targetIndex >= childrenVC.count {
                targetIndex = childrenVC.count - 1
            }
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
            
        } else {
            progress = 1 - resolvedRatio
            targetIndex = Int(ratio)
            sourceIndex = targetIndex + 1
            if sourceIndex > childrenVC.count {
                sourceIndex = childrenVC.count - 1
            }
            if startOffsetX - currentOffsetX == scrollViewW {
                sourceIndex = targetIndex
            }
        }
        
        delegate?.onScroll(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

extension PageContentView {
    func setPage(index: Int) {
        let offsetX = kScreenW * CGFloat(index)
        collectionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
}
