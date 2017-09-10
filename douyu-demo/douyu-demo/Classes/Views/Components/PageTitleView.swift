//
//  PageTitleView.swift
//  douyu-demo
//
//  Created by Aidan on 2017/9/10.
//  Copyright © 2017年 Aidan. All rights reserved.
//

import UIKit

private let kScrollLineH: CGFloat = 2

class PageTitleView: UIView {
    
    private let titles: [String]
    private lazy var titleLabels: [UILabel] = [UILabel]()
    
    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        view.scrollsToTop = false
        view.bounces = false
        return view
    }()
    
    private lazy var scrollLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor.orange
        return line
    }()

    init(frame: CGRect, titles: [String]) {
        self.titles = titles
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(scrollView)
        scrollView.frame = bounds
        
        setupLabels()
        setupBottomLine()
        setupScrollLine()
    }
    
    private func setupLabels() {
        let labelY: CGFloat = 0
        let labelW: CGFloat = frame.width / CGFloat(titles.count)
        let labelH: CGFloat = frame.height
        
        for (index, title) in titles.enumerated() {
            let labelX: CGFloat = labelW * CGFloat(index)
            let label = UILabel()
            
            label.tag = index
            label.text = title
            label.textColor = UIColor.darkGray
            label.font = UIFont.systemFont(ofSize: 16)
            label.textAlignment = .center
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            
            scrollView.addSubview(label)
            titleLabels.append(label)
        }
    }
    
    private func setupBottomLine() {
        let buttomLine = UIView()
        let buttomLineH: CGFloat = 0.5
        buttomLine.frame = CGRect(x: 0, y: frame.height - buttomLineH, width: kScreenW, height: buttomLineH)
        buttomLine.backgroundColor = UIColor.lightGray
        addSubview(buttomLine)
    }
    
    private func setupScrollLine() {
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor.orange
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}
