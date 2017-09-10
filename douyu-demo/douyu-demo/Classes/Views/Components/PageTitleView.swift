//
//  PageTitleView.swift
//  douyu-demo
//
//  Created by Aidan on 2017/9/10.
//  Copyright © 2017年 Aidan. All rights reserved.
//

import UIKit

private let kScrollLineH: CGFloat = 2

protocol PageTitleViewDelegate: class {
    func onSelectTitle(titleView: PageTitleView, index: Int)
}

class PageTitleView: UIView {
    
    weak var delegate: PageTitleViewDelegate?
    var selectedIndex: Int = 0
    let titles: [String]
    lazy var titleLabels: [UILabel] = [UILabel]()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        view.scrollsToTop = false
        view.bounces = false
        return view
    }()
    
    lazy var scrollLine: UIView = {
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
    
}

extension PageTitleView {
    
    func setupUI() {
        addSubview(scrollView)
        scrollView.frame = bounds
        
        setupLabels()
        setupBottomLine()
        setupScrollLine()
    }
    
    func setupLabels() {
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
            
            label.isUserInteractionEnabled = true;
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(self.onPressTitle(tapGes:)))
            label.addGestureRecognizer(tapGes)
        }
    }
    
    func setupBottomLine() {
        let buttomLine = UIView()
        let buttomLineH: CGFloat = 0.5
        buttomLine.frame = CGRect(x: 0, y: frame.height - buttomLineH, width: kScreenW, height: buttomLineH)
        buttomLine.backgroundColor = UIColor.lightGray
        addSubview(buttomLine)
    }
    
    func setupScrollLine() {
        guard let firstLabel = titleLabels.first else {
            return
        }
        firstLabel.textColor = UIColor.orange
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}

extension PageTitleView {
    
    @objc func onPressTitle(tapGes: UITapGestureRecognizer) {
        
        guard let selectedLabel = tapGes.view as? UILabel else {
            return
        }
        let lastSelectedLabel = titleLabels[selectedIndex]
        
        selectedLabel.textColor = UIColor.orange
        lastSelectedLabel.textColor = UIColor.darkGray
        selectedIndex = selectedLabel.tag
        
        let lineX = selectedLabel.frame.origin.x
        let lineY = selectedLabel.bounds.height - kScrollLineH
        let lineW = selectedLabel.bounds.width
        
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame = CGRect(x: lineX, y: lineY, width: lineW, height: kScrollLineH)
        }
        
        delegate?.onSelectTitle(titleView: self, index: selectedIndex)
    }
}

