//
//  DetailCommentController.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/23.
//  Copyright © 2017年 张杰. All rights reserved.
//

import UIKit

class DetailCommentController: UIViewController {

    var strID : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        initData()
    }
    
    deinit {
        print("销毁了\(self)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        textView.resignFirstResponder()
    }
    
    private func initView() {
        title = "评论"
        view.backgroundColor = UIColor.init(colorLiteralRed: 243/255.0, green: 244/255.0, blue: 245/255.0, alpha: 1)
        view.addSubview(textView)
    }

    private func initData() {
        
    }
    
    //发送评论
    func sendComment() {
        
        LyClassTool.loadingAnimation(string: "")
        let tool = LyNetRequstTask()
        let defaults = UserDefaults.standard
        let token = defaults.string(forKey: define.UserInfo_token)
        //串行
        let queue = DispatchQueue(label: "serial")
        queue.async {
            tool.postRequest(urlString: "http://zzy.bolemayy.com/video/comment/add", parameters: ["vid" : self.strID as AnyObject , "content" : self.textView.text as AnyObject], headers: ["token" : token!], success: { (response) in
                
                //            print("success  \(response)")
                let status = response["status"] as! NSNumber
                DispatchQueue.main.async {
                    if status == 0 {
                        LyClassTool.stopAnimation()
                        self.navigationController?.popViewController(animated: true)
                    }
                    else
                    {
                        let info = response["info"] as! String
                        LyClassTool.stopLoadingAnimation(string: info)
                    }
                }

            }, failure: { (error) in
                LyClassTool.stopAnimation()
            })
        }
        print("主线")
        
    }
    
    private lazy var textView : LyTextView = {
        let textView = LyTextView()
        textView.placeholder = "请输入"
        textView.font = self.define.FontNormal
        textView.frame = CGRect(x: 0, y: 0, width: self.define.screenW, height: 150)
        textView.delegate = self
        textView.returnKeyType = .send
        return textView
    }()

    private let define = LyUserDefault()
}

extension DetailCommentController : UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"
        {
            textView.endEditing(true)
            sendComment()
            return false
        }
        
        //限制字数
        let comcatstr = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let caninputlen = 50 - (comcatstr as NSString).length
        if caninputlen > 0 {
            return true
        }
        else
        {
            let len = (text as NSString).length + caninputlen
            //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
            let rg = NSRange(location: 0, length: max(len , 0))
            if rg.length > 0 {
                let s = (text as NSString).substring(with: rg)
                textView.text = (textView.text as NSString).replacingCharacters(in: range, with: s)
            }
            return false
        }
    }
}
