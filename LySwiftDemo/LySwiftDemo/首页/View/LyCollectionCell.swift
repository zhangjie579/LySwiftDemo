//
//  LyCollectionCell.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/23.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit

class LyCollectionCell: UICollectionViewCell {
    
    class func cellWithCollectionViewCell(_ collectionView : UICollectionView , indexPath : IndexPath) -> LyCollectionCell {
        let ID = "LyCollectionCell"
        collectionView.register(self, forCellWithReuseIdentifier: ID)
        return collectionView.dequeueReusableCell(withReuseIdentifier: ID, for: indexPath) as! LyCollectionCell
    }
    
    //MARK:赋值
    var str_icon : String? {
        didSet {
            icon.kf.setImage(with: URL(string: str_icon!), placeholder: UIImage.init(named: "general_ic_portrait_default"))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(icon)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        icon.frame = self.contentView.bounds
    }
    
    private lazy var icon : UIImageView = {
        
        let icon = UIImageView()
        return icon
    }()
}
