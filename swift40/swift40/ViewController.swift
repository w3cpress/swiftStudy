//
//  ViewController.swift
//  swift40
//  swift40 - 使用UISearchController实现带搜索栏的表格
//  Created by Alan on 16/7/27.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    //展示列表
    var tableView : UITableView!
    
    //搜索控制器
    var countrySearchController = UISearchController();
    
    //原始数据集

    let schoolArray = ["清华大学","北京大学","中国人民大学","北京交通大学","北京工业大学","北京航空航天大学","北京理工大学","北京科技大学","中国政法大学","中央财经大学","华北电力大学","北京体育大学","上海外国语大学","复旦大学","华东师范大学","上海大学","河北工业大学"]
    var searchArray:[String] = [String]() {
        didSet {
            self.tableView.reloadData();
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //创建表视图
        self.tableView = UITableView(frame:UIScreen.mainScreen().bounds,style: UITableViewStyle.Plain)
        self.tableView!.delegate = self;
        self.tableView!.dataSource = self;
        
        //创建一个重用的单元格
        self.tableView!.registerClass(UITableViewCell.self,forCellReuseIdentifier: "MyCell")
        self.view.addSubview(self.tableView!)
        
        //配置搜索控制器
        self.countrySearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.hidesNavigationBarDuringPresentation = false
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.searchBarStyle = .Minimal
            controller.searchBar.sizeToFit()
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

