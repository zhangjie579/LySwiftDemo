//
//  DetailCommentCell.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/23.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit

class DetailCommentCell: UITableViewCell {

    class func cellWithTableView(_ tableView : UITableView) -> DetailCommentCell {
        let ID = "DetailCommentCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: ID) as? DetailCommentCell
        if cell == nil {
            cell = DetailCommentCell(style: UITableViewCellStyle.default, reuseIdentifier: ID)
        }
        return cell!
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLable)
        contentView.addSubview(icon)
        contentView.addSubview(timeLabel)
        contentView.addSubview(contentLabel)
        contentView.addSubview(btnTap)
        contentView.addSubview(line)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func getHeight(model : DetailCommentModel) -> CGFloat {
        let define = LyUserDefault()
        let h = LyClassTool.sizeWithString(string: model.content!, maxSize: CGSize(width: CGFloat(define.screenW) - CGFloat(define.seperateLineW) * 2, height: CGFloat(MAXFLOAT)), font: define.FontSmall).height
        return h + CGFloat(define.seperateLineW) * 4 + 30
    }
    
    var model : DetailCommentModel? {
        didSet {
            initData()
            initView()
        }
    }
    
    private func initData() {
        nameLable.text = model?.u_username
        icon.kf.setImage(with: URL(string : (model?.u_header)!), placeholder: UIImage.init(named: "general_ic_portrait_default"), options: nil)
        contentLabel.text = model?.content
        btnTap.setTitle(model?.praise_num, for: .normal)
        
        if let tap = model?.is_praise {
            
            if tap == "0" {
                btnTap.isSelected = false
            } else if tap == "1" {
                btnTap.isSelected = true
            }
        }
        
        //时间
//        let formate = DateFormatter()
//        formate.dateFormat = "yyyy年MM月dd日"
//        let date = NSDate(timeIntervalSince1970: (Double)((model?.created_at)!)!)
//        timeLabel.text = formate.string(from: date as Date)
        timeLabel.text = LyClassTool.timeStapToDateString(string : (model?.created_at)!)
    }
    
    private func initView() {
        
        icon.snp.remakeConstraints { (make) in
            make.left.top.equalTo(contentView).offset(define.seperateLineW)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        
        nameLable.snp.remakeConstraints { (make) in
            make.left.equalTo(icon.snp.right).offset(define.seperateLineW)
            make.top.equalTo(icon)
            make.size.equalTo(CGSize(width: 150, height: 15))
        }
        
        timeLabel.snp.remakeConstraints { (make) in
            make.left.equalTo(nameLable)
            make.top.equalTo(nameLable.snp.bottom).offset(define.seperateLineW)
            make.size.equalTo(CGSize(width: 150, height: 15))
        }
        
        btnTap.snp.remakeConstraints { (make) in
            make.right.equalTo(contentView).offset(-define.seperateLineW)
            make.top.equalTo(nameLable.snp.bottom)
            make.size.equalTo(CGSize(width: 40, height: 20))
        }
        
        contentLabel.snp.remakeConstraints { (make) in
            make.left.equalTo(icon)
            make.right.equalTo(btnTap)
            make.top.equalTo(timeLabel.snp.bottom).offset(define.seperateLineW)
        }
        
        line.snp.remakeConstraints { (make) in
            make.bottom.right.equalTo(contentView)
            make.left.equalTo(contentView).offset(define.seperateLineW)
            make.height.equalTo(1)
        }
    }
    
    @objc private func btnClick() {
        
    }
    
    //MARK: 懒加载
    private lazy var icon : UIImageView = {
        let icon = UIImageView()
        icon.layer.cornerRadius = 15
        icon.clipsToBounds = true
        return icon
    }()
    
    private lazy var nameLable : UILabel = {
        let nameLable = UILabel()
        nameLable.font = self.define.FontNormal
        nameLable.textColor = self.define.ColorDarkGrey
        return nameLable
    }()
    
    private lazy var timeLabel : UILabel = {
        let nameLable = UILabel()
        nameLable.font = self.define.FontSmall
        nameLable.textColor = self.define.ColorLightGray
        return nameLable
    }()
    
    private lazy var contentLabel : UILabel = {
        let nameLable = UILabel()
        nameLable.font = self.define.FontSmall
        nameLable.textColor = self.define.ColorDarkGrey
        nameLable.numberOfLines = 0
        nameLable.preferredMaxLayoutWidth = CGFloat(self.define.screenW) - CGFloat(self.define.seperateLineW) * 2
        nameLable.setContentHuggingPriority(UILayoutPriorityRequired, for: UILayoutConstraintAxis.vertical)
        return nameLable
    }()
    
    private lazy var btnTap : UIButton = {
        let btnTap = UIButton()
        btnTap.setImage(UIImage.init(named: "apply_bottom_ic_praise"), for: .selected)
        btnTap.setImage(UIImage.init(named: "apply_bottom_ic_praise_gray"), for: .normal)
        btnTap.titleLabel?.font = self.define.FontSmall
        btnTap.setTitleColor(UIColor.orange, for: .normal)
        btnTap.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        btnTap.titleEdgeInsets = UIEdgeInsetsMake(0, 3, 0, 0)
        return btnTap
    }()
    
    private lazy var line : UIView = {
        let line = UIView()
        line.backgroundColor = self.define.ColorGray
        return line
    }()
    
    private let define = LyUserDefault()
}
