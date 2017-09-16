//
//  PageTitleView.swift
//  douyu-demo
//
//  Created by Aidan on 2017/9/10.
//  Copyright © 2017年 Aidan. All rights reserved.
//

import UIKit

protocol PageTitleViewDelegate: class {
    func onSelectTitle(titleView: PageTitleView?, index: Int?)
}

private let kScrollLineH: CGFloat = 2
private let kSelectedRGB: (CGFloat, CGFloat, CGFloat) = (255, 128, 0)
private let kNormalRGB: (CGFloat, CGFloat, CGFloat) = (85, 85, 85)
private let kDeltaRGB: (CGFloat, CGFloat, CGFloat) = (kSelectedRGB.0 - kNormalRGB.0, kSelectedRGB.1 - kNormalRGB.1, kSelectedRGB.2 - kNormalRGB.2)

class PageTitleView: UIView {
    
    weak var delegate: PageTitleViewDelegate?
    var currentIndex: Int = 0
    let titles: [String]
    lazy var titleLabels: [UILabel] = [UILabel]()
    var labelW: CGFloat = 0
    
    lazy var scrollView: UIScrollView = {[weak self] in
        let view = UIScrollView()
        view.showsHorizontalScrollIndicator = false
        view.scrollsToTop = false
        view.bounces = false
        return view
    }()
    
    lazy var scrollLine: UIView = {
        let line = UIView()
        line.backgroundColor = UIColor(r: kSelectedRGB.0, g: kSelectedRGB.1, b: kSelectedRGB.2)
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
        let labelH: CGFloat = frame.height
        labelW = frame.width / CGFloat(titles.count)
        
        for (index, title) in titles.enumerated() {
            let labelX: CGFloat = labelW * CGFloat(index)
            let label = UILabel()
            
            label.tag = index
            label.text = title
            label.textColor = UIColor(r: kNormalRGB.0, g: kNormalRGB.1, b: kNormalRGB.2)
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
        firstLabel.textColor = UIColor(r: kSelectedRGB.0, g: kSelectedRGB.1, b: kSelectedRGB.2)
        
        scrollView.addSubview(scrollLine)
        scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
    }
}

extension PageTitleView {
    
    @objc func onPressTitle(tapGes: UITapGestureRecognizer) {
        
        guard let selectedLabel = tapGes.view as? UILabel else {
            return
        }
        
        if currentIndex == selectedLabel.tag {
            return
        }
        
        let sourceLabel = titleLabels[currentIndex]
        let targetLabel = titleLabels[selectedLabel.tag]
        
        sourceLabel.textColor = UIColor(r: kNormalRGB.0, g: kNormalRGB.1, b: kNormalRGB.2)
        targetLabel.textColor = UIColor(r: kSelectedRGB.0, g: kSelectedRGB.1, b: kSelectedRGB.2)
        
        let lineX = selectedLabel.frame.origin.x
        let lineY = selectedLabel.bounds.height - kScrollLineH
        let lineW = selectedLabel.bounds.width
        
        UIView.animate(withDuration: 0.2, animations: {[weak self] in
            self?.scrollLine.frame = CGRect(x: lineX, y: lineY, width: lineW, height: kScrollLineH)
        }) { (end) in
            self.delegate?.onSelectTitle(titleView: self, index: self.currentIndex)
        }
        self.currentIndex = selectedLabel.tag
    }
}

extension PageTitleView {
    
    func setTitleViewScrollLine(progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        
        if sourceIndex > titles.count - 1 {
            return
        }
        
        let sourceLabel = titleLabels[sourceIndex]
        let targetLabel = titleLabels[targetIndex]
        
        let moveTotalW = targetLabel.frame.origin.x - sourceLabel.frame.origin.x
        let moveDeltaW = moveTotalW * progress
        
        let lineX: CGFloat = sourceLabel.frame.origin.x + moveDeltaW
        let lineY = targetLabel.bounds.height - kScrollLineH
        let lineW = targetLabel.bounds.width
        
        sourceLabel.textColor = UIColor(r: kSelectedRGB.0 - kDeltaRGB.0 * progress, g: kSelectedRGB.1 - kDeltaRGB.1 * progress, b: kSelectedRGB.2 - kDeltaRGB.2 * progress)
        targetLabel.textColor = UIColor(r: kNormalRGB.0 + kDeltaRGB.0 * progress, g: kNormalRGB.1 + kDeltaRGB.1 * progress, b: kNormalRGB.2 + kDeltaRGB.2 * progress)
        
        self.scrollLine.frame = CGRect(x: lineX, y: lineY, width: lineW, height: kScrollLineH)
        
        currentIndex = targetIndex
    }
}

