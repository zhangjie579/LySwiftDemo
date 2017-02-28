//
//  LoginController.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/21.
//  Copyright © 2017年 张杰. All rights reserved.
//  登录

import UIKit
import Alamofire
import NVActivityIndicatorView
import SwiftyJSON
import ReactiveCocoa
import ReactiveSwift
import Result

class LoginController: UIViewController {

    override func viewDidLoad() {
        initView()
        
        let phoneSignal = phoneNum.textFiled.reactive.continuousTextValues.map { (text) -> Int in
            return (text?.characters.count)!
        }
        let passwordSignal = secNum.textFiled.reactive.continuousTextValues.map { (text) -> Int in
            return (text?.characters.count)!
        }
        sureBtn.reactive.isEnabled <~ Signal.combineLatest(phoneSignal, passwordSignal).map({ (namelength : Int, passlength : Int) -> Bool in
            return (namelength >= 1 && passlength >= 1) ? true : false
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    func initView() {
        self.view.backgroundColor = UIColor.white
        navigationController?.delegate = self
        view.addSubview(titleLabel)
        view.addSubview(phoneNum)
        view.addSubview(secNum)
        view.addSubview(sureBtn)
        view.addSubview(btnRAC)
        setSnp()

    }
    
    //点击了登录
    @objc func loginTo() {
        
        LyClassTool.loadingAnimation()
        //参数编码方式（Parameter Encoding）
        //除了默认的方式外，Alamofire还支持URL、URLEncodedInURL、JSON、Property List以及自定义格式方式编码参数
        
        Alamofire.request("http://zzy.bolemayy.com/sign/index/login", method: .post, parameters: ["cellphone" : phoneNum.textFiled.text! , "password" : "e10adc3949ba59abbe56e057f20f883e"], encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
//            print(response.request)  // original URL request
//            print(response.response) // URL response
//            print(response.data)     // server data
//            print(response.result)   // result of response serialization
            LyClassTool.stopLoadingAnimation()
            if let JSON = response.result.value {
                
                let dict = JSON as! Dictionary<String, Any>
                
                let status = dict["status"] as! NSNumber
                
                if status == 0 {
                    
                    let model = LoginInModel(dict: dict["data"] as! [String : AnyObject])
                    
                    LoginDealModel.saveModel(model: model)
                    
                    self.navigationController?.pushViewController(FirstPageViewController(), animated: true)
                    print("JSON: \(model)")
                    
                }
                
            }
        }
    }
    
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//        let size = CGSize(width: 60, height:30)
//        //展示提示动画
//        let activityData = ActivityData(size: size, message: "Loading...", type: .ballBeat)
//        NVActivityIndicatorPresenter.sharedInstance.startAnimating(activityData)
//        
//        Alamofire.request("http://182.254.228.211:9000/index.php/Api/ServiceContact/index", method: .post, parameters: ["uid" : "1"], encoding: URLEncoding.default, headers: nil) .response { (response) in
//            //加载完成
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5, execute: {
//                NVActivityIndicatorPresenter.sharedInstance.setMessage("Done")
//            })
//            //提示动画消失
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3.0, execute: {
//                NVActivityIndicatorPresenter.sharedInstance.stopAnimating()
//            })
//            
//            
//            if let data = response.data {
//                //json -> dict
//                let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
//                
////                //MARK: 使用SwiftyJSON转json
////                let dict = JSON(data: data)
////                
////                let model = LoginInModel(dict: (dict["data"].dictionaryObject! as NSDictionary) as! [String : AnyObject])
//                
//                print("JSON: \(json)")
//            }
//        }
//    }
    
    @objc private func recTo() {
        navigationController?.pushViewController(MyHelpViewController(), animated: true)
    }
    
    private func setSnp() {
        
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.view).offset(80)
            make.left.right.equalTo(self.view)
            make.height.equalTo(40)
        }
        
        phoneNum.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(self.view).offset(-10)
            make.height.equalTo(50)
        }
        
        secNum.snp.makeConstraints { (make) in
            make.top.equalTo(phoneNum.snp.bottom).offset(20)
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(self.view).offset(-10)
            make.height.equalTo(50)
        }
        
        sureBtn.snp.makeConstraints { (make) in
            make.top.equalTo(secNum.snp.bottom).offset(20)
            make.left.equalTo(self.view).offset(10)
            make.right.equalTo(self.view).offset(-10)
            make.height.equalTo(50)
        }
        
        btnRAC.snp.makeConstraints { (make) in
            make.top.equalTo(sureBtn.snp.bottom).offset(20)
            make.left.equalTo(self.view).offset(10)
            make.size.equalTo(CGSize(width: 150, height: 50))
        }
    }
    
    private lazy var titleLabel : UILabel = {
       
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.textColor = UIColor.blue
        titleLabel.textAlignment = .center
        titleLabel.text = "Demo"
        return titleLabel
    }()
    
    lazy var phoneNum : InputView = {
    
        let phoneNum = InputView()
        phoneNum.inputType = .RightNone
        phoneNum.textFiled.delegate = self
        return phoneNum
    }()
    
    lazy var secNum : InputView = {
        
        let secNum = InputView()
        secNum.inputType = .Default
        secNum.textFiled.delegate = self
        return secNum
    }()
    
    lazy var sureBtn : UIButton = {
        
        let sureBtn = UIButton()
        sureBtn.isEnabled = false
        sureBtn.setBackgroundImage(LyClassTool.creatImageWithColor(color: UIColor.blue), for: .normal)
        sureBtn.setBackgroundImage(LyClassTool.creatImageWithColor(color: UIColor.lightGray), for: .disabled)
        sureBtn.setTitle("登录", for: UIControlState.normal)
        sureBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        sureBtn.addTarget(self, action: #selector(loginTo), for: UIControlEvents.touchUpInside)
        sureBtn.layer.cornerRadius = 5
        sureBtn.clipsToBounds = true
        return sureBtn
    }()
    
    lazy var btnRAC : UIButton = {
        
        let sureBtn = UIButton()
        sureBtn.setBackgroundImage(LyClassTool.creatImageWithColor(color: UIColor.green), for: .normal)
        sureBtn.setTitle("RAC + MVVM", for: UIControlState.normal)
        sureBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        sureBtn.addTarget(self, action: #selector(recTo), for: UIControlEvents.touchUpInside)
        sureBtn.layer.cornerRadius = 5
        sureBtn.clipsToBounds = true
        return sureBtn
    }()
}

extension LoginController : UINavigationControllerDelegate {
    
//    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
//        if viewController == self {
//            navigationController.navigationBar.isHidden = true
//        } else {
//            navigationController.navigationBar.isHidden = false
//        }
//    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController == self {
            navigationController.isNavigationBarHidden = true
        } else {
            navigationController.isNavigationBarHidden = false
        }
    }
}

extension LoginController : UITextFieldDelegate {
    
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        
//        if (LyClassTool.isBlackString(string: phoneNum.textFiled.text) && LyClassTool.isBlackString(string: secNum.textFiled.text)){
//            
//            sureBtn.isEnabled = false
//        } else {
//            sureBtn.isEnabled = true
//        }
//        
//        return true
//    }
    
    //点击了return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if phoneNum.textFiled.text != nil && secNum.textFiled.text != nil {
            loginTo()
            return true
        }
        return false
    }
}
