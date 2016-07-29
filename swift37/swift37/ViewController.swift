//
//  ViewController.swift
//  swift37
//  Swift37 - 给表格添加编辑功能（删除，插入）
//  Created by Alan on 16/7/5.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

/*
 功能
 1.下面的样例是给表格UITableView添加编辑功能：
（1）给表格添加长按功能，长按后表格进入编辑状态
（2）在编辑状态下，第一个分组处于删除状态，第二个分组处于插入状态
（3）点击删除图标，删除对应条目
（4）点击添加图标，插入一条新数据
 */

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIGestureRecognizerDelegate {

    var tableView:UITableView?;
    var allnames:Dictionary<Int,[String]>?;
    
    var adHeaders:[String]?;
    
    override func loadView(){
        super.loadView();
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.allnames = [
            0:[String](["UILabel 标签","UIButton 按钮"]),
            1:[String](["UIDatePiker 日期选择器","UITableView 表格视图"])
        ];
        
        self.adHeaders = ["常见UIKit 控件","高级UIKit 控件"];
        
        //创建表视图
        self.tableView = UITableView(frame:self.view.frame,style: UITableViewStyle.Grouped);
        self.tableView!.delegate = self;
        self.tableView!.dataSource = self;
        
        //创建一个重用的单元格
        self.tableView!.registerClass(UITableViewCell.self, forCellReuseIdentifier: "SwiftCell");
        self.view.addSubview(self.tableView!);
        
        //创建表头标签
        let headerLabel = UILabel(frame: CGRectMake(0, 0, self.view.bounds.size.width, 30))
        headerLabel.backgroundColor = UIColor.blackColor()
        headerLabel.textColor = UIColor.whiteColor()
        headerLabel.numberOfLines = 0
        headerLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        headerLabel.text = "UIKit控件"
        headerLabel.font = UIFont.italicSystemFontOfSize(20)
        self.tableView!.tableHeaderView = headerLabel;
        
        //绑定对长按的响应
        let longPress =  UILongPressGestureRecognizer(target:self,action:#selector(tableviewCellLongPressed))
        //代理
        longPress.delegate = self
        longPress.minimumPressDuration = 1.0
        //将长按手势添加到需要实现长按操作的视图里
        self.tableView!.addGestureRecognizer(longPress)
        
    }
    
    func tableviewCellLongPressed(gestureRecognizer:UILongPressGestureRecognizer) {
        if (gestureRecognizer.state == UIGestureRecognizerState.Began) {
            print("UIGestureRecognizerStateBegan");
        }
        if (gestureRecognizer.state == UIGestureRecognizerState.Changed) {
            print("UIGestureRecognizerStateChanged");
        }
        if (gestureRecognizer.state == UIGestureRecognizerState.Ended) {
            print("UIGestureRecognizerStateEnded");
            //在正常状态和编辑状态之间切换
            if(self.tableView!.editing == false){
                self.tableView!.setEditing(true, animated:true);
            } else {
                self.tableView!.setEditing(false, animated:true);
                
            }
        }
    }
    
    //在本例中，有2个分区
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    //返回表格行数（也就是返回控件数）
    func tableView(tableView:UITableView, numberOfRowsInSection section: Int) -> Int {
        let data = self.allnames?[section]
        return data!.count
    }
    
    // UITableViewDataSource协议中的方法，该方法的返回值决定指定分区的头部
    func tableView(tableView:UITableView, titleForHeaderInSection
        section:Int)->String?
    {
        var headers =  self.adHeaders!;
        return headers[section];
    }
    
    // UITableViewDataSource协议中的方法，该方法的返回值决定指定分区的尾部
    func tableView(tableView:UITableView, titleForFooterInSection
        section:Int)->String?
    {
        let data = self.allnames?[section]
        return "有\(data!.count)个控件"
    }
    
    //创建各单元显示内容(创建参数indexPath指定的单元）
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //为了提供表格显示性能，已创建完成的单元需重复使用
        let identify:String = "SwiftCell"
        //同一形式的单元格重复使用，在声明时已注册
        let cell = tableView.dequeueReusableCellWithIdentifier(identify, forIndexPath: indexPath) as UITableViewCell
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        let secno = indexPath.section
        var data = self.allnames?[secno]
        cell.textLabel?.text = data![indexPath.row]
        
        return cell
    }
    
    // UITableViewDelegate 方法，处理列表项的选中事件
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView!.deselectRowAtIndexPath(indexPath, animated: true)
        
        let itemString = self.allnames![indexPath.section]![indexPath.row]
        
        let alertController = UIAlertController(title:"提示!",message:"你选中了【\(itemString)】",preferredStyle: .Alert);
        let okAction = UIAlertAction(title: "确定", style: .Cancel, handler: nil)
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        if(indexPath.section == 1) {
            return UITableViewCellEditingStyle.Insert
        }
        return UITableViewCellEditingStyle.Delete
    }
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        var data = self.allnames?[indexPath.section]!
        
        let itemString = data![indexPath.row] as String
        return "确定删除\(itemString)？"
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if(editingStyle == UITableViewCellEditingStyle.Delete) {
            self.allnames?[indexPath.section]?.removeAtIndex(indexPath.row)
            
            self.tableView!.reloadData()
            self.tableView!.setEditing(true, animated: true)
            print("你确认了删除按钮")
            // Array
        } else if(editingStyle == UITableViewCellEditingStyle.Insert) {
            self.allnames?[indexPath.section]?.insert("插入一项新的", atIndex: indexPath.row+1)
            print("你按下了插入按钮")
            self.tableView!.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

