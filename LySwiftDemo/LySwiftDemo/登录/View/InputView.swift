//
//  InputView.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/21.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit
import SnapKit

enum InputViewType{
    case RightNone
    case Default
}

class InputView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(leftImage)
        addSubview(rightImage)
        addSubview(textFiled)
        
        layer.cornerRadius = 3
        layer.masksToBounds = true
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.lightGray.cgColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var inputType : InputViewType? {
        didSet{
            
            if inputType == .RightNone
            {
                rightImage.isHidden = true
                
                leftImage.image = UIImage.init(named: "apply_login_phone")
                
                textFiled.isSecureTextEntry = false
                
            }
            else if inputType == .Default
            {
                rightImage.isHidden = false
                
                leftImage.image = UIImage.init(named: "apply_login_password")
                rightImage.image = UIImage.init(named: "apply_bottom_ic_show");
                textFiled.isSecureTextEntry = true
            }
            setSnp(inputType: inputType!)
        }
    }
    
    func setSnp(inputType : InputViewType) {
        
        leftImage.snp.makeConstraints { (make) in
            make.left.equalTo(self).offset(10)
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize(width: 30, height: 20))
        }
        
        if inputType == .RightNone
        {
            textFiled.snp.makeConstraints({ (make) in
                make.left.equalTo(leftImage.snp.right).offset(10)
                make.centerY.equalTo(self)
                make.height.equalTo(20)
                make.right.equalTo(self)
            })
        }
        else if inputType == .Default
        {
            rightImage.snp.makeConstraints({ (make) in
                make.right.equalTo(self).offset(-10)
                make.centerY.equalTo(self)
                make.size.equalTo(CGSize(width: 20, height: 20))
            })
            
            textFiled.snp.makeConstraints({ (make) in
                make.left.equalTo(leftImage.snp.right).offset(10)
                make.centerY.equalTo(self)
                make.height.equalTo(20)
                make.right.equalTo(rightImage.snp.left)
            })
        }
    }
    
    private lazy var leftImage : UIImageView = {
       
        let leftImage = UIImageView()
        leftImage.contentMode = .center
        return leftImage
    }()
    
    private lazy var rightImage : UIImageView = {
        
        let rightImage = UIImageView()
        rightImage.contentMode = .center
        return rightImage
    }()

    lazy var textFiled : UITextField = {
       
        let textFiled = UITextField()
        textFiled.font = UIFont.systemFont(ofSize: 15)
        textFiled.textColor = UIColor.lightGray
        textFiled.clearButtonMode = .always
        textFiled.returnKeyType = .done
        return textFiled
    }()
}
