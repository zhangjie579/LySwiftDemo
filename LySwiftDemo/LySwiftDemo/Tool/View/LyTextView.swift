//
//  LyTextView.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/24.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit

class LyTextView: UITextView {
    
//    init(string : String? = "请输入") {
//        
//        super.init(frame: CGRect.zero, textContainer: nil)
//        backgroundColor = UIColor.white
//        insertSubview(placeholderLabel, at: 0)
//        placeholder = string
//        isScrollEnabled = true
//        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: NSNotification.Name.UITextViewTextDidChange, object: self)
//        
//        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
//        addGestureRecognizer(tap)
//    }
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        backgroundColor = UIColor.white
        insertSubview(placeholderLabel, at: 0)
        isScrollEnabled = true
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: NSNotification.Name.UITextViewTextDidChange, object: self)

        let tap = UITapGestureRecognizer.init(target: self, action: #selector(tapClick))
        addGestureRecognizer(tap)
    }
    
    var placeholder : String? {
        didSet {
            placeholderLabel.text = placeholder
            initView()
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UITextViewTextDidChange, object: self)
    }
    
    //MARK:设置lable的frame
    private func initView() {
        
        if let title = placeholderLabel.text
        {
            placeholderLabel.isHidden = false
            let placeholderX = 5;
            let placeholderY = 7;
            
            var size = CGSize.zero
            if let fontLabel = font
            {
                size = sizeWithString(string: title, maxSize: CGSize(width: frame.size.width - 2 * CGFloat(placeholderX), height: CGFloat(MAXFLOAT) - CGFloat(placeholderY) * 2), font: fontLabel)
            }
            else {
                size = sizeWithString(string: title, maxSize: CGSize(width: frame.size.width - 2 * CGFloat(placeholderX), height: CGFloat(MAXFLOAT) - CGFloat(placeholderY) * 2), font: UIFont.systemFont(ofSize: 15))
            }
            
            placeholderLabel.frame = CGRect(x: CGFloat(placeholderX), y: CGFloat(placeholderY), width: size.width, height: size.height)
        }
        else
        {
            placeholderLabel.isHidden = true
        }
        
        if (text as NSString).length > 0 {
            placeholderLabel.isHidden = true
        } else {
            placeholderLabel.isHidden = false
        }
    }
    
    //MARK:重写font的set方法
    override var font: UIFont? {
        didSet {
            placeholderLabel.font = font
            super.font = font
        }
    }
    
    //MARK:重写text的set方法
    override var text: String! {
        didSet {
            placeholderLabel.isHidden = (text as NSString).length > 0 ? true : false
            super.text = text
        }
    }
    
    //监听输入文字的改变
    @objc private func textDidChange() {
        placeholderLabel.isHidden = (text as NSString).length > 0 ? true : false
    }
    
    //开始编辑
    @objc private func tapClick() {
        self.becomeFirstResponder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //4.计算string的size
    private func sizeWithString(string : String , maxSize : CGSize , font : UIFont) -> CGSize {
        var size = string.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : font], context: nil).size
        let width = ceilf(Float(size.width))
        size.width = CGFloat(Float(width))
        return size
    }
    
    private lazy var placeholderLabel : UILabel = {
        let placeholderLabel = UILabel()
        placeholderLabel.textColor = UIColor.init(colorLiteralRed: 0, green: 0, blue: 0.0980392, alpha: 0.22)
        placeholderLabel.isHidden = true;
        placeholderLabel.numberOfLines = 0;
        placeholderLabel.backgroundColor = UIColor.clear;
        placeholderLabel.font = self.font;
        return placeholderLabel
    }()

}
