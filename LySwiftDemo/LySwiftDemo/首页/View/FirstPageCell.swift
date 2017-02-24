//
//  FirstPageCell.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/22.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit
import Kingfisher

class FirstPageCell: UITableViewCell {

    class func cellWithTableView(_ tableView : UITableView) -> FirstPageCell {
        let ID = "FirstPageCell"
        
        var cell = tableView.dequeueReusableCell(withIdentifier: ID) as? FirstPageCell
        
        if cell == nil {
            cell = FirstPageCell(style: UITableViewCellStyle.default, reuseIdentifier: ID)
        }
        return cell!
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layer.cornerRadius = 5
        layer.masksToBounds = true
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        
        self.contentView.addSubview(imageSubject)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(nameLabel)
        self.contentView.addSubview(line)
        self.contentView.addSubview(icon)
        self.contentView.addSubview(btnTap)
        self.contentView.addSubview(btnComment)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: SET
    var model : FirstPageModel? {
        didSet {
            
            initData()
            initFrame()
        }
    }
    
    //MARK:设置尺寸
    private func initFrame() {
        
        imageSubject.snp.remakeConstraints { (make) in
            make.left.equalTo(self.contentView).offset(define.seperateLineW)
            make.top.equalTo(self.contentView).offset(20)
            make.size.equalTo(CGSize(width: 16, height: 16))
        }
        
        let lineH =  LyClassTool.sizeWithString(string: "一行", maxSize: CGSize(width: define.screenW - 66, height: 20), font: define.FontLarge).height
        var height = LyClassTool.sizeWithString(string: (model?.title)!, maxSize: CGSize(width : define.screenW - 66 ,height : lineH * 2), font: define.FontLarge).height
        
        titleLabel.snp.remakeConstraints { (make) in
            make.left.equalTo(imageSubject.snp.right).offset(define.seperateLineW)
            make.top.equalTo(imageSubject)
            make.right.equalTo(self.contentView).offset(-define.seperateLineW)
            make.height.equalTo(height)
        }
        
        nameLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(define.seperateLineW)
            make.left.equalTo(imageSubject)
            make.right.equalTo(titleLabel)
            make.height.equalTo(15)
        }
        
        line.snp.remakeConstraints { (make) in
            make.left.equalTo(imageSubject)
            make.top.equalTo(nameLabel.snp.bottom).offset(define.seperateLineW)
            make.right.equalTo(titleLabel)
            make.height.equalTo(1)
        }
        
        icon.snp.remakeConstraints { (make) in
            make.left.equalTo(imageSubject)
            make.top.equalTo(line.snp.bottom).offset(define.seperateLineW)
            make.size.equalTo(CGSize(width: 31, height: 31))
        }
        
        btnTap.snp.remakeConstraints { (make) in
            make.right.equalTo(titleLabel)
            make.bottom.equalTo(icon)
            make.size.equalTo(CGSize(width: 40, height: 20))
        }
        
        btnComment.snp.remakeConstraints { (make) in
            make.right.equalTo(btnTap.snp.left).offset(-5)
            make.bottom.equalTo(icon)
            make.size.equalTo(CGSize(width: 40, height: 20))
        }
    }
    
    class func getHeight(model : FirstPageModel?) -> CGFloat {
        
        let define = LyUserDefault()
        let lineH =  LyClassTool.sizeWithString(string: "一行", maxSize: CGSize(width: define.screenW - 66, height: 20), font: define.FontLarge).height
        let height = LyClassTool.sizeWithString(string: (model?.title)!, maxSize: CGSize(width : define.screenW - 66 ,height : lineH * 2), font: define.FontLarge).height
        
        let h = CGFloat(define.seperateLineW) * 6 + height + 15.0 + 1.0 + 31.0 + 10;
        
        return h
    }
    
    override var frame: CGRect {
        didSet {
            
            var newFrame = frame
            newFrame.origin.x = newFrame.origin.x + 10
            newFrame.size.width = newFrame.size.width - 20
            newFrame.origin.y = newFrame.origin.y + 10
            newFrame.size.height = newFrame.size.height - 10
            
            super.frame = newFrame
        }
    }
    
    private func initData() {
        
        titleLabel.text = model?.title
        nameLabel.text = "\((model?.teacher_realname)!) \((model?.grade_name)!) \((model?.duration)!)"
        icon.kf.setImage(with: URL(string : (model?.teacher_header)!), placeholder: UIImage.init(named: "general_ic_portrait_default"))
        btnComment.setTitle(self.copareWithNum(string: (model?.comment_num)!), for: .normal)
        btnTap.setTitle(self.copareWithNum(string: (model?.praise_num)!), for: .normal)
    }
    
    private func copareWithNum(string : String) -> String {
        
        if Int(string)! <= 0 {
            return ""
        } else if Int(string)! > 99 {
            return "99"
        } else {
            return string
        }
        
    }
    
    //MARK: 懒加载
    private lazy var imageSubject : UIImageView = {
       
        let imageSubject = UIImageView()
        imageSubject.image = UIImage.init(named: "apply_ic_course_geographic")
        return imageSubject
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
    
    private lazy var icon : UIImageView = {
      
        let icon = UIImageView()
        return icon
    }()
    
    private lazy var btnTap : UIButton = {
       
        let btnTap = UIButton()
        btnTap.setTitleColor(UIColor.orange, for: UIControlState.normal)
        btnTap.titleLabel?.font = self.define.FontSmall
        btnTap.setImage(UIImage.init(named: "apply_bottom_ic_praise"), for: .normal)
        btnTap.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0)
        return btnTap
    }()
    
    private lazy var btnComment : UIButton = {
        
        let btnTap = UIButton()
        btnTap.setTitleColor(UIColor.orange, for: UIControlState.normal)
        btnTap.titleLabel?.font = self.define.FontSmall
        btnTap.setImage(UIImage.init(named: "apply_bottom_ic_comments"), for: .normal)
        btnTap.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0)
        return btnTap
    }()
    
    private let define = LyUserDefault()


}


