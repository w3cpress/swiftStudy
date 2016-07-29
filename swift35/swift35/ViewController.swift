//
//  ViewController.swift
//  swift35
//  Swift35 - 使用表格组件（UITableView）实现分组列表
//  Created by Alan on 16/6/30.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

/*
 1.样例说明：
 （1）列表以分组的形式展示
 （2）同时还自定义分区的头部和尾部
 （3）点击列表项会弹出消息框显示该项信息。
  原文链接：http://www.hangge.com/blog/cache/detail_557.html
 
 2.给表格的单元格UITableViewCell添加图片，详细文本标签
 表格UITableView中，每一单元格都是一个UITableViewCell。其支持简单的自定义，比如在单元格的内部，添加图片和详细文本标签。
 注意UITableViewCell的style：
 （1）UITableViewCellStyle.Default：默认的，只有一个常规内容标签和一个可选的UIImageView
 （2）UITableViewCellStyle.Value1：内容标签在左，详细标签在右，右边是蓝色或灰色的文本
 （3）UITableViewCellStyle.Value2：同Value1位置相同，左边是蓝色文本
 （4）UITableViewCellStyle.Subtitle：标签上下放置
 原文链接：http://www.hangge.com/blog/cache/detail_558.html
 */

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var tableView:UITableView?
    
    var allnames:Dictionary<Int, [String]>?
    
    var adHeaders:[String]?
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //初始化数据，这一次数据，我们放在属性列表文件里
        self.allnames =  [
            0:[String]([
                "UILabel 标签",
                "UITextField 文本框",
                "UIButton 按钮"]),
            1:[String]([
                "UIDatePiker 日期选择器",
                "UIToolbar 工具条",
                "UITableView 表格视图"])
        ];
        
        print(self.allnames)
        
        self.adHeaders = [
            "常见 UIKit 控件",
            "高级 UIKit 控件"
        ]
        
        //创建表视图
        self.tableView = UITableView(frame:CGRectMake(0, 22,UIScreen.mainScreen().bounds.width,UIScreen.mainScreen().bounds.height-22), style:UITableViewStyle.Grouped)
        self.tableView!.delegate = self
        self.tableView!.dataSource = self
        //创建一个重用的单元格
        self.tableView!.registerClass(UITableViewCell.self,
                                      forCellReuseIdentifier: "SwiftCell")
        self.view.addSubview(self.tableView!)
        
        //创建表头标签
        let headerLabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, 30))
        headerLabel.backgroundColor = UIColor.blackColor()
        headerLabel.textColor = UIColor.whiteColor()
        headerLabel.numberOfLines = 0
        headerLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        headerLabel.text = "高级 UIKit 控件"
        headerLabel.font = UIFont.italicSystemFontOfSize(20)
        self.tableView!.tableHeaderView = headerLabel
    }
    //在本例中，有2个分区
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2;
    }
    
    //返回表格行数（也就是返回控件数）
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int  {
        let data = self.allnames?[section]
        return data!.count
    }
    
    // UITableViewDataSource协议中的方法，该方法的返回值决定指定分区的头部
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            var headers =  self.adHeaders!;
            return headers[section];
    }
    
    // UITableViewDataSource协议中的方法，该方法的返回值决定指定分区的尾部
    func tableView(tableView:UITableView,titleForFooterInSection section:Int)->String? {
        let data = self.allnames?[section]
        return "有\(data!.count)个控件";
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //为了提供表格显示性能，已创建完成的单元需重复使用
        let identify:String = "SwiftCell"
        
        //同一形式的单元格重复使用，在声明时已注册
//        let secno = indexPath.section
//        var data = self.allnames?[secno];
//        
//        let cell = tableView.dequeueReusableCellWithIdentifier(identify, forIndexPath: indexPath) as UITableViewCell
//        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
//        cell.textLabel?.text = data![indexPath.row]
//        return cell;
        
        //2.UITableViewCell 用法
        let secno = indexPath.section
        var data = self.allnames?[secno];
        if(secno == 0){
            let cell = tableView.dequeueReusableCellWithIdentifier(identify, forIndexPath: indexPath) as UITableViewCell
            cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            
            cell.textLabel?.text = data![indexPath.row]
        
            let img = UIImage(named: "slider_min.jpg");
            cell.imageView?.image = img;
            return cell
        } else {
            //第二个分组表格使用详细标签
            let adcell = UITableViewCell(style: UITableViewCellStyle.Subtitle,reuseIdentifier: "SwiftCell");
            adcell.textLabel?.text = data![indexPath.row];
            print(adcell.textLabel?.text);
            adcell.detailTextLabel!.text = "这是\(data![indexPath.row])的说明"
            return adcell;
        }
           
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView!.deselectRowAtIndexPath(indexPath, animated: true)
        let itemString = self.allnames![indexPath.section]![indexPath.row]
        
        let alertController = UIAlertController(title: "提示!", message: "你选中了【\(itemString)】",preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "确定", style: .Cancel, handler: nil)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

