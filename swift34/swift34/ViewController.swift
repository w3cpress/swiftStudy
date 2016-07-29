//
//  ViewController.swift
//  swift34
//  Swift34 - 使用表格组件（UITableView）实现单列表
//  Created by Alan on 16/6/29.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

/*
 1，样例说明：
 （1）列表内容从 Controls.plist 文件中读取，类型为 Array。
 （2）点击列表项会弹出消息框显示该项信息。
 （3）按住列表项向左滑动，会出现删除按钮。点击删除即可删除该项。
  原文链接：http://www.hangge.com/blog/cache/detail_552.html
 
 2.单元格复用机制：
 由于普通的表格视图中对的单元格形式一般都是相同的，所以本例采用了单元格复用机制，可以大大提高程序性能。
 实现方式是初始化创建 UITableView 实例时使用 registerClass(UITableViewCell.self, forCellReuseIdentifier: "SwiftCell") 
 创建一个可重用的 UITableViewCell。并将其注册到UITableView，ID为 SwiftCell。
 下次碰到形式（或结构）相同的单元就可以直接使用 UITableView的dequeueReusableCellWithIdentifier 方法从UITableView中取出。
 */


import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var ctrlnames:[String]?;
    var tableView:UITableView?
    
    override func loadView() {
        super.loadView();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        //初始化数据，这一次数据，我们放在属性列表文件里
        self.ctrlnames =  NSArray(contentsOfFile:NSBundle.mainBundle().pathForResource("Controls", ofType:"plist")!) as? Array;
        
        print(self.ctrlnames)
        
        //创建表视图
        self.tableView = UITableView(frame: CGRectMake(0, 22, self.view.bounds.size.width, self.view.bounds.size.height), style:UITableViewStyle.Plain)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //创建一个重用的单元格
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "SwiftCell")
        self.view.addSubview(self.tableView!)
        
        //创建表头标签
        let headerLabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, 30))
        headerLabel.backgroundColor = UIColor.blackColor()
        headerLabel.textColor = UIColor.whiteColor()
        headerLabel.numberOfLines = 0
        headerLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        headerLabel.text = "常见 UIKit 控件"
        headerLabel.font = UIFont.italicSystemFontOfSize(20)
        self.tableView!.tableHeaderView = headerLabel
    }
    
    //在本例子中，只有一个分区
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    //返回表格行数（也就是返回控件数）
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ctrlnames!.count;
    }
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //为了提供表格显示性能，已创建完成的单元需重复使用
        let identify:String = "SwiftCell"
        //同一形式的单元格重复使用，在声明时已注册
        let cell = tableView.dequeueReusableCellWithIdentifier(identify,forIndexPath: indexPath) as UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        cell.textLabel?.text = self.ctrlnames![indexPath.row]
        return cell
    }
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView!.deselectRowAtIndexPath(indexPath, animated: true)
        
        let itemString = self.ctrlnames![indexPath.row];
        let alertController = UIAlertController(title: "提示!", message: "你选中了【\(itemString)】", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "确定", style: .Default,handler: nil)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
        
    }
    
    //滑动删除必须实现的方法
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        print("删除\(indexPath.row)")
        let index = indexPath.row
        self.ctrlnames?.removeAtIndex(index)
        self.tableView?.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Top)
    }
    
    //滑动删除
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
            return UITableViewCellEditingStyle.Delete
    }
    
    //修改删除按钮的文字
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
            return "删除"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

