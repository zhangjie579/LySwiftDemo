//
//  LyClassTool.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/21.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class LyClassTool: NSObject {

    //1.将颜色 -> 图片
    class func creatImageWithColor(color:UIColor) -> UIImage{
        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    //MARK : 添加加载动画，移除加载动画
    class func loadingAnimation(string : String = "Loading...") {
        
        let size = CGSize(width: 60, height:30)
        //展示提示动画
        let activityData = ActivityData(size: size, message: string, type: .ballBeat)
        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
    }
    
    class func stopLoadingAnimation(string : String = "Done") {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: {
            NVActivityIndicatorPresenter.sharedInstance.setMessage(string)
        })
        //提示动画消失
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0, execute: {
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        })
    }
    
    //立刻消失动画
    class func stopAnimation() {
        
        //提示动画消失
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3, execute: {
            
            NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
        })
    }
    
    //3.判断是否为空字符串
    class func isBlackString(string : String?) -> Bool {
        
        if string == "" || string == nil {
            return true
        } else {
            return false
        }
    }
    
    //4.计算string的size
    class func sizeWithString(string : String , maxSize : CGSize , font : UIFont) -> CGSize {
        var size = string.boundingRect(with: maxSize, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName : font], context: nil).size
        let width = ceilf(Float(size.width))
        size.width = CGFloat(Float(width))
        return size
    }
    
    //MARK: 时间转换
    //时间戳 -> 时间字符串
    class func timeStapToDateString(string : String , dateFormat : String = "yyyy年MM月dd日") -> String {
        let formate = DateFormatter()
        formate.dateFormat = dateFormat
        let date = Date(timeIntervalSince1970: Double(string)!)
        return formate.string(from: date)
    }
    
    //时间字符串 -> 时间戳
    class func dateStringToTimeStap(string : String , dateFormat : String = "yyyy年MM月dd日") -> String {
        let formate = DateFormatter()
        formate.dateFormat = dateFormat
        let date = formate.date(from: string)
        return "\((date?.timeIntervalSince1970))"
    }
}
