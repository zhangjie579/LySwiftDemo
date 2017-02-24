//
//  DetailHeaderView.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/23.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit

protocol DetailHeaderViewDelegate : NSObjectProtocol {
    func DetailHeardViewDidClickWithComment()
}

class DetailHeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(nameView)
        addSubview(titleLabel)
        addSubview(studyLabel)
        addSubview(versionLabel)
        addSubview(introduceLabel)
        addSubview(commentLabel)
        addSubview(icon)
        addSubview(btnComment)
        addSubview(line)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func getHeight(model : DetailViewModel) -> CGFloat {
        var h = DetailTitleView.getHeight(model: model)
        let define = LyUserDefault()
        return h + 8 * CGFloat(define.seperateLineW) + 5 * 15 + 31
    }
    
    var model : DetailViewModel? {
        didSet {
            initData()
            initView()
        }
    }
    
    private func initData() {
        
        nameView.model = model
        studyLabel.text = "学习阶段\((model?.study_phase)!)"
        versionLabel.text = "教程版本\((model?.textbook_version)!)"
        let defaults = UserDefaults.standard
        let strIcon = defaults.string(forKey: define.UserInfo_icon)
        icon.kf.setImage(with: URL(string : strIcon!))
    }
    
    private func initView() {
        
        nameView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(self)
            make.height.equalTo(DetailTitleView.getHeight(model: model!))
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(nameView.snp.bottom).offset(define.seperateLineW)
            make.left.equalTo(self).offset(define.seperateLineW)
            make.size.equalTo(CGSize(width: 150, height: 15))
        }
        
        studyLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(define.seperateLineW)
            make.right.equalTo(self)
            make.height.equalTo(15)
        }
        
        versionLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(studyLabel.snp.bottom).offset(define.seperateLineW)
            make.right.equalTo(self)
            make.height.equalTo(15)
        }
        
        introduceLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(versionLabel.snp.bottom).offset(define.seperateLineW)
            make.right.equalTo(self)
            make.height.equalTo(15)
        }
        
        commentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(introduceLabel.snp.bottom).offset(define.seperateLineW * 2)
            make.right.equalTo(self)
            make.height.equalTo(15)
        }
        
        icon.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.top.equalTo(commentLabel.snp.bottom).offset(define.seperateLineW)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        btnComment.snp.makeConstraints { (make) in
            make.centerY.equalTo(icon)
            make.left.equalTo(icon.snp.right).offset(define.seperateLineW)
            make.right.equalTo(self).offset(-define.seperateLineW)
            make.height.equalTo(25)
        }
        
        line.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(self)
            make.height.equalTo(1)
        }
    }
    
    weak var delegate : DetailHeaderViewDelegate?
    
    @objc func btnClickWithComment() {
        if delegate != nil {
            delegate?.DetailHeardViewDidClickWithComment()
        }
    }
    
    
    
    //MARK: 懒加载
    private lazy var nameView : DetailTitleView = {
       
        let nameView = DetailTitleView()
        return nameView
    }()
    
    private lazy var titleLabel : UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.font = self.define.FontLarge
        titleLabel.textColor = self.define.ColorDarkGrey
        titleLabel.text = "适应人群"
        return titleLabel
    }()
    
    private lazy var studyLabel : UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.font = self.define.FontNormal
        titleLabel.textColor = self.define.ColorLightGray
        return titleLabel
    }()
    
    private lazy var versionLabel : UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.font = self.define.FontNormal
        titleLabel.textColor = self.define.ColorLightGray
        return titleLabel
    }()
    
    private lazy var introduceLabel : UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.font = self.define.FontLarge
        titleLabel.textColor = self.define.ColorDarkGrey
        titleLabel.text = "课程介绍"
        return titleLabel
    }()
    
    private lazy var commentLabel : UILabel = {
        
        let titleLabel = UILabel()
        titleLabel.font = self.define.FontNormal
        titleLabel.textColor = self.define.ColorDarkGrey
        titleLabel.text = "评论"
        return titleLabel
    }()
    
    private lazy var btnComment : UIButton = {
        
        let btnComment = UIButton()
        btnComment.setTitle("我来说两句", for: .normal)
        btnComment.setTitleColor(self.define.ColorDarkGrey, for: .normal)
        btnComment.backgroundColor = self.define.ColorGray
        btnComment.layer.cornerRadius = 5
        btnComment.layer.masksToBounds = true
        btnComment.addTarget(self, action: #selector(btnClickWithComment), for: .touchUpInside)
        return btnComment
    }()
    
    private lazy var icon : UIImageView = {
        
        let icon = UIImageView()
        return icon
    }()
    
    private lazy var line : UIView = {
        let line = UIView()
        line.backgroundColor = self.define.ColorGray
        return line
    }()
    
    private let define = LyUserDefault()

}
