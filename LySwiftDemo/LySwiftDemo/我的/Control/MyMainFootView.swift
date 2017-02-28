//
//  MyMainFootView.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/27.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit
import ReactiveCocoa
import ReactiveSwift
import Result

class MyMainFootView: UIView {

    let (sing1 , observe1) = Signal<Any, NoError>.pipe()
    let (sign2 , observe2) = Signal<Any, NoError>.pipe()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(btn1)
        addSubview(btn)
        addSubview(lable)
        
        
        btn.reactive.controlEvents(UIControlEvents.touchUpInside).observeValues { (btn) in
            self.observe1.send(value: "点击了左边")
        }
        
        btn1.reactive.controlEvents(UIControlEvents.touchUpInside).observeValues { (btn) in
            self.observe2.send(value: "右边")
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        btn.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
            make.width.equalTo(100)
        }
        
        btn1.snp.makeConstraints { (make) in
            make.right.top.bottom.equalTo(self)
            make.width.equalTo(100)
        }
        
        lable.snp.makeConstraints { (make) in
            make.left.equalTo(btn.snp.right)
            make.top.bottom.equalTo(self)
            make.right.equalTo(btn1.snp.left)
        }
    }
    
    private lazy var btn : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.blue
        return btn
    }()
    
    private lazy var btn1 : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.orange
        return btn
    }()
    
    private lazy var lable : UILabel = {
       let lable = UILabel()
        lable.backgroundColor = UIColor.white
        lable.font = UIFont.systemFont(ofSize: 15)
        lable.textColor = UIColor.black
        lable.text = "内容"
        return lable
    }()
}
