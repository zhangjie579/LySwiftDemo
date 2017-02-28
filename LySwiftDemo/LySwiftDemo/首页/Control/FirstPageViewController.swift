//
//  FirstPageViewController.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/22.
//  Copyright © 2017年 张杰. All rights reserved.
//  首页

import UIKit
import Alamofire
//import SwiftyJSON

class FirstPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        initData()
    }
    
    deinit {
        print("销毁了\(self)")
    }
    
    private func initView() {
        navigationController?.delegate = self
        view.backgroundColor = define.ColorWhite
        view.addSubview(tableView)
        view.addSubview(heardView)
        
    }
    
    private func initData() {
        
        //1.提示框
        LyClassTool.loadingAnimation()
        
        let defaults = UserDefaults.standard
        let define = LyUserDefault()
        let token = defaults.string(forKey: define.UserInfo_token)
        
        //2.网络请求
        let heards = ["token" : token!]
        
        let queue = DispatchQueue.global(qos: .default)
        let group = DispatchGroup()
        group.enter()
        queue.async(group: group, execute: {
            
            //注意:header的类型要对不然会错
            Alamofire.request("http://zzy.bolemayy.com/video/index/index", method: .post, parameters: ["p" : "1"], encoding: URLEncoding.default, headers: heards).responseJSON { (response) in
                //            print(response.request)  // original URL request
                //            print(response.response) // URL response
                //            print(response.data)     // server data
                //            print(response.result)   // result of response serialization
                LyClassTool.stopAnimation()
                group.leave()
                if let JSON = response.result.value
                {
                    let dict = JSON as! [String : AnyObject]
                    let status = dict["status"] as! NSNumber
                    if status == 0
                    {
                        let array = dict["data"] as? [[String : AnyObject]]
                        if array?.count != 0
                        {
                            for i in 0  ..< (array?.count)!
                            {
                                let model = FirstPageModel(dict: (array?[i])!)
                                self.array_data.append(model)
                                print("JSON: \(model)")
                            }
                        }
                    }
                }
            }

        })
        
        group.enter()
        queue.async(group: group, execute: {
            
            Alamofire.request("http://zzy.bolemayy.com/video/carousel/index", method: .post, parameters: nil, encoding: URLEncoding.default, headers: heards).responseJSON(completionHandler: { (response) in
                group.leave()
                if let json = response.result.value {
                    
                    let dict = json as! [String : AnyObject]
                    
                    let status = dict["status"] as! NSNumber
                    
                    if status == 0 {
                        let array = dict["data"] as? [[String : String]]
                        
                        if array?.count != 0 {
                            for i in 0  ..< (array?.count)! {
                                
                                let model = LyPhotoModel(dict: (array?[i])!)
                                self.array_phone.append(model)
                            }
                        }
                    }
                }
            })
        })
        
        group.notify(queue: .main, execute: {
            self.tableView.reloadData()
            
            var arrayIcon : [String] = [String]()
            for i in 0  ..< self.array_phone.count 
            {
                let model = self.array_phone[i]
                arrayIcon.append(model.img!)
            }
            self.heardView.array_icon = arrayIcon
        })
        
        print("主线")
    }
    
    private lazy var tableView : UITableView = {
       
        let tableView = UITableView()
        tableView.backgroundColor = self.define.ColorGray
        tableView.frame = CGRect(x: 0, y: 150, width: self.define.screenW, height: self.define.screenH - 150)
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    private lazy var heardView : LyPhotoPlayView = {
       
        let heardView = LyPhotoPlayView()
        heardView.backgroundColor = self.define.ColorWhite
        heardView.frame = CGRect(x: 0, y: 0, width: self.define.screenW, height:150)
        heardView.delegate = self
        return heardView
    }()
    
    private let define = LyUserDefault()
    
    lazy var array_data : [FirstPageModel] = [FirstPageModel]()
    
    lazy var array_phone : [LyPhotoModel] = [LyPhotoModel]()
    
}

extension FirstPageViewController : LyPhotoPlayViewDelegate {
    func lyPhotoPlayViewDidImageWithRow(row: Int) {
        navigationController?.pushViewController(MyMainViewController(), animated: true)
    }
}

extension FirstPageViewController : UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array_data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = FirstPageCell.cellWithTableView(tableView)
        cell.model = array_data[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let vc = DetailViewController()
        let model = array_data[indexPath.row]
        vc.strID = model.id
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return FirstPageCell.getHeight(model: array_data[indexPath.row])
    }
}

extension FirstPageViewController : UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController == self {
            navigationController.isNavigationBarHidden = true
        } else {
            navigationController.isNavigationBarHidden = false
        }
    }
}
