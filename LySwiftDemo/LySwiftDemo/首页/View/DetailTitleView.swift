//
//  DetailTitleView.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/23.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit

class DetailTitleView: UIView {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(icon)
        addSubview(imageSubject)
        addSubview(titleLabel)
        addSubview(nameLabel)
        addSubview(line)
    }
    
    var model : DetailViewModel? {
        didSet {
            initData()
            initView()
        }
    }
    
    private func initData() {
        titleLabel.text = model?.title
        icon.kf.setImage(with: URL(string: (model?.teacher_header)!))
        nameLabel.text = "\((model?.teacher_realname)!)  \((model?.grade_name)!)  \((model?.duration)!)"
    }
    
    private func initView() {
        
        icon.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(define.seperateLineW)
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        imageSubject.snp.makeConstraints { (make) in
            make.left.equalTo(icon.snp.right).offset(5)
            make.top.equalTo(icon)
            make.size.equalTo(CGSize(width: 16, height: 16))
        }
        
        let lineH = LyClassTool.sizeWithString(string: "一行", maxSize: CGSize(width: define.screenW - 91, height: 16), font: define.FontLarge).height
        let titleH = LyClassTool.sizeWithString(string: nameLabel.text!, maxSize: CGSize(width: define.screenW - 91, height: lineH * 2), font: define.FontLarge).height
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(imageSubject.snp.right).offset(define.seperateLineW)
            make.top.equalTo(imageSubject)
            make.right.equalTo(self).offset(-define.seperateLineW)
            make.height.equalTo(titleH)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.right.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(define.seperateLineW)
            make.height.equalTo(15)
        }
        
        line.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(1)
        }
    }
    
    class func getHeight(model : DetailViewModel) -> CGFloat {
        
        let define = LyUserDefault()
        let lineH = LyClassTool.sizeWithString(string: "一行", maxSize: CGSize(width: define.screenW - 91, height: 16), font: define.FontLarge).height
        let titleH = LyClassTool.sizeWithString(string: model.title!, maxSize: CGSize(width: define.screenW - 91, height: lineH * 2), font: define.FontLarge).height
        
        return CGFloat(define.seperateLineW) * 3.0 + 16 + titleH
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: 懒加载
    private lazy var icon : UIImageView = {
       
        let icon = UIImageView()
        return icon
    }()
    
    private lazy var imageSubject : UIImageView = {
        
        let icon = UIImageView()
        icon.image = UIImage.init(named: "apply_ic_course_geographic")
        return icon
    }()
    
    private lazy var titleLabel : UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.font = self.define.FontLarge
        titleLabel.textColor = self.define.ColorDarkGrey
        titleLabel.numberOfLines = 2
        return titleLabel
    }()
    
    private lazy var nameLabel : UILabel = {
        let nameLabel = UILabel()
        nameLabel.font = self.define.FontNormal
        nameLabel.textColor = self.define.ColorLightGray
        return nameLabel
    }()

    private lazy var line : UIView = {
        let line = UIView()
        line.backgroundColor = self.define.ColorGray
        return line
    }()
    
    private let define = LyUserDefault()
}
