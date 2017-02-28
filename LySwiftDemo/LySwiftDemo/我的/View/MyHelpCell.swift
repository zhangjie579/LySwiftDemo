//
//  MyHelpCell.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/28.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit

class MyHelpCell: UITableViewCell {

    class func cellWithTableView(_ tableView : UITableView) -> MyHelpCell {
        let ID = "MyHelpCell"
        var cell = tableView.dequeueReusableCell(withIdentifier: ID) as? MyHelpCell
        if cell == nil {
            cell = MyHelpCell.init(style: UITableViewCellStyle.default, reuseIdentifier: ID)
        }
        return cell!
    }
    
    var viewModel : MyHelpViewModel? {
        didSet {
            icon.image = viewModel?.icon
            title.text = viewModel?.title
            content.text = viewModel?.number
        }
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layer.cornerRadius = 5
        layer.masksToBounds = true
        contentView.layer.cornerRadius = 5
        contentView.layer.masksToBounds = true
        
        contentView.addSubview(icon)
        contentView.addSubview(title)
        contentView.addSubview(content)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var frame: CGRect {
        didSet {
            var rect = frame
            rect.origin.x = rect.origin.x + 10
            rect.size.width = rect.size.width - 20
            rect.origin.y = rect.origin.y + 10
            rect.size.height = rect.size.height - 10
            super.frame = rect
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        icon.snp.makeConstraints { (make) in
            make.left.equalTo(contentView).offset(define.seperateLineW)
            make.centerY.equalTo(contentView)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        title.snp.makeConstraints { (make) in
            make.left.equalTo(icon.snp.right).offset(define.seperateLineW * 2)
            make.top.equalTo(icon)
            make.size.equalTo(CGSize(width: 150, height: 20))
        }
        
        content.snp.makeConstraints { (make) in
            make.left.equalTo(title)
            make.bottom.equalTo(icon)
            make.size.equalTo(CGSize(width: 150, height: 20))
        }
    }
    
    private lazy var icon : UIImageView = {
       let icon = UIImageView()
        return icon
    }()
    
    private lazy var title : UILabel = {
        let title = UILabel()
        title.font = self.define.FontNormal
        title.textColor = self.define.ColorDarkGrey
        return title
    }()
    
    private lazy var content : UILabel = {
        let title = UILabel()
        title.font = self.define.FontNormal
        title.textColor = self.define.ColorBlue
        return title
    }()
    
    private let define = LyUserDefault()
}
