//
//  ViewController.swift
//  swift39
//  swift39 - 搜索条（UISearchBar）的用法
//  Created by Alan on 16/7/25.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

/* 
1.搜索条Options属性还可设置如下功能样式：
 Shows Search Results Button：勾选后，搜索框右边显示一个圆形向下的按钮，单击会发送特殊事件。
 Shows Bookmarks Button：勾选后，搜索框右边会显示一个书本的按钮，单击会发送特殊事件。
 Shows Cancel Button：勾选后，搜索框右边会出现一个“Cancel”按钮，单击会发送特殊事件。
 Shows Scope Bar：勾选后，会在搜索条下面出现一个分段控制器。
 
 原文链接：http://www.hangge.com/blog/cache/detail_562.html
 
 2.下面是一个搜索条的使用样例，功能如下：
 （1）在Main.storyboard界面里拖入一个 Search Bar 和一个 Table View，Search Bar放到Table View的页眉位置
 （2）初始化或者搜索条为空时，表格显示所有数据
 （3）搜索条不为空时，表格实时过滤显示匹配的项目
 */

import UIKit

class ViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    //引用通过storyboard创建的控件
    @IBOutlet var searchBar : UISearchBar!;
    @IBOutlet var tableView : UITableView!;
    
    //所有组件
    var ctrls:[String] = ["Label","Button1","Button2","Switch"];
    
    //搜索匹配的结果，Table View使用这个数组作为datasource
    var ctrlsel:[String] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // 起始加载全部内容
        self.ctrlsel = self.ctrls;
        // 设置代理
        self.searchBar.delegate = self;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        // 注册TableViewCell
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "SwiftCell");
    }
    
    // 返回表格行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ctrlsel.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // 为了提供表格显示性能，已创建完成的单元需要重复使用
        let identify:String = "SwiftCell";
        
        //统一形式的单元格重复使用，在声明时已注册
        let cell = tableView.dequeueReusableCellWithIdentifier(identify, forIndexPath: indexPath) as UITableViewCell;
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator;
        cell.textLabel?.text = self.ctrlsel[indexPath.row];
        
        return cell;
    }
    
    // 搜索代理UISearchBarDelegate方法，每次改变搜索内容时都会调用
    func searchBar(searchBar:UISearchBar, textDidChange searchText:String){
        print(searchText);
        
        //没有搜索内容时显示全部组件
        if searchText == "" {
            self.ctrlsel = self.ctrls;
        } else {
            //匹配用户输入内容的前缀(不区分大小写)
            self.ctrlsel = [];
            for ctrl in self.ctrls {
                if ctrl.lowercaseString.hasPrefix(searchText.lowercaseString){
                    self.ctrlsel.append(ctrl);
                }
            }
        }
        
        //刷新tableview 显示
        self.tableView.reloadData();
     }
    
    // 搜索代理UISearchBarDelegate方法，点击虚拟键盘上的Search按钮时触发
//    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
//        searchBar.resignFirstResponder();
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

