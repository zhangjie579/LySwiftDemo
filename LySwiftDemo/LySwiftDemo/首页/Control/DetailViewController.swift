//
//  DetailViewController.swift
//  LySwiftDemo
//
//  Created by 张杰 on 2017/2/23.
//  Copyright © 2017年 张杰. All rights reserved.
//  详情页

import UIKit
import Alamofire
import SwiftyJSON

class DetailViewController: UIViewController {

    var strID : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        initData()
    }
    
    deinit {
        print("销毁了\(self)")
    }

    private func initView() {
//        initNav()
        view.addSubview(tableView)
        title = "详情页"
    }
    
    private func initNav() {
        
        let left = UIBarButtonItem(title: "返回", style: .done, target: self, action: #selector(backTo))
        let leftSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        leftSpace.width = -20
        navigationItem.leftBarButtonItems = [leftSpace,left]
    }
    
    @objc private func backTo() {
        
    }
    
    private func initData() {
        
        LyClassTool.loadingAnimation()
        
        let queue = DispatchQueue.global(qos: .default)
        let group = DispatchGroup()
        
        let defaluts = UserDefaults.standard
        let token = defaluts.string(forKey: define.UserInfo_token)
        
        //1.头部数据
        group.enter()
        queue.async(group: group, execute: {
            Alamofire.request("http://zzy.bolemayy.com/video/index/details", method: .post, parameters: ["vid" : self.strID!], encoding: URLEncoding.default, headers: ["token" : token!]).responseJSON(completionHandler: { (response) in
                
                group.leave()
                if let json = response.result.value
                {
                    let dict = json as! [String : AnyObject]
                    let status = dict["status"] as! NSNumber
                    if status == 0
                    {
                        self.modelHeard = DetailViewModel(dict: (dict["data"] as? [String : String])!)
                    }
                }
                
            })
        })
        
        //2.评论数据
        group.enter()
        queue.async(group: group, execute: {
            
            Alamofire.request("http://zzy.bolemayy.com/video/comment/list", method: .post, parameters: ["p" : "1" , "vid" : self.strID!], encoding: URLEncoding.default, headers: ["token" : token!]).responseJSON(completionHandler: { (response) in
                
                group.leave()
                if let json = response.result.value
                {
                    let dict = json as! [String : AnyObject]
                    let status = dict["status"] as! NSNumber
                    if status == 0
                    {
                        let array = dict["data"] as? [[String : AnyObject]]
                        if array != nil
                        {
                            for i in 0  ..< (array?.count)!
                            {
                                let model = DetailCommentModel(dict: (array?[i])!)
                                self.arrayData?.append(model)
                            }
                        }
                    }
                }
                
            })
        })
        
        group.notify(queue: DispatchQueue.main, execute: {
            
            LyClassTool.stopAnimation()
            self.heardView.model = self.modelHeard
            let h = DetailHeaderView.getHeight(model: self.modelHeard!)
            self.heardView.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: h)
            self.tableView.tableHeaderView = self.heardView
            self.tableView.reloadData()
        })
    }
    
    //MARK: 懒加载 
    private lazy var tableView : UITableView = {
       
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.white
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.frame = CGRect(x: 0, y: 0, width: self.define.screenW, height: self.define.screenH - CGFloat(self.define.NavBarHeight))
        return tableView
    }()
    
    private lazy var heardView : DetailHeaderView = {
        let heardView = DetailHeaderView()
        heardView.backgroundColor = UIColor.white
        heardView.delegate = self
        return heardView
    }()

    private var modelHeard : DetailViewModel?
    lazy var arrayData : [DetailCommentModel]? = [DetailCommentModel]()
    
    private let define = LyUserDefault()
}

extension DetailViewController : UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = DetailCommentCell.cellWithTableView(tableView)
        cell.model = arrayData?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return DetailCommentCell.getHeight(model: (arrayData?[indexPath.row])!)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension DetailViewController : DetailHeaderViewDelegate {
    func DetailHeardViewDidClickWithComment() {
        
        let vc = DetailCommentController()
        vc.strID = strID
        navigationController?.pushViewController(vc, animated: true)
    }
}
