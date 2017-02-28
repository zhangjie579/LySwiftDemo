//
//  MyHelpFootView.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/28.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

class MyHelpFootView: UIView {

    let (signalTap , observeTap) = Signal<Any , NoError>.pipe()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addSubview(label)

        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        addGestureRecognizer(tap)
    }
    
    var title : String? {
        didSet {
            label.text = title
        }
    }
    
    @objc private func tapClick() {
        observeTap.send(value: "")
        
        //如果加这个就是，发了一次信号就不能再发了
//        observeTap.sendCompleted()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(define.seperateLineW)
            make.right.equalTo(self).offset(-define.seperateLineW)
            make.centerY.equalTo(self)
        }
    }
    
    class func getHeight(title : String) -> CGFloat {
        let define = LyUserDefault()
        let h = LyClassTool.sizeWithString(string: title, maxSize: CGSize(width: CGFloat(define.screenW) - CGFloat(define.seperateLineW) * 2, height: CGFloat(MAXFLOAT)), font: define.FontNormal).height + CGFloat(define.seperateLineW) * 2
        return h
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private lazy var label : UILabel = {
        let label = UILabel()
        label.font = self.define.FontNormal
        label.textColor = self.define.ColorLightGray
        label.numberOfLines = 0
        label.preferredMaxLayoutWidth = CGFloat(self.define.screenW) - CGFloat(self.define.seperateLineW) * 2
        label.setContentHuggingPriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.vertical)
        label.textAlignment = .center
        return label
    }()
    
    private let define = LyUserDefault()
}
