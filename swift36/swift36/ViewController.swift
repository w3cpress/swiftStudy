//
//  ViewController.swift
//  swift36
//  Swift36 - 自定义单元格实现微信聊天界面
//  Created by Alan on 16/7/1.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

/*
 1.下面是一个放微信聊天界面的消息展示列表，实现的功能有：
 （1）消息可以是文本消息也可以是图片消息
 （2）消息背景为气泡状图片，同时消息气泡可根据内容自适应大小
 （3）每条消息旁边有头像，在左边表示发送方，在右边表示接收方
 
 2.实现思路
 （1）需要定义一个数据结构保存消息内容 MessageItem
 （2）继承UITableViewCell实现自定义单元格，这里面放入头像和消息体
 （3）继承UITableView实现自定义表格，通过读取数据源，进行页面的渲染
 （4）消息体根据内容类型不同，用不同的展示方法
 （5）每个单元格的高度需要根据内容计算出来
 （6）数据由ViewController来提供初始化数据
 */
import UIKit

class ViewController: UIViewController, ChatDataSource {
    
    var Chats:Array<MessageItem>!;
    var tableView:TableView!;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupChatTable();
        
    }
    
    /*创建表格及数据*/
    func setupChatTable() {
        self.tableView = TableView(frame:CGRectMake(0, 20, self.view.frame.size.width, self.view.frame.size.height - 20), style: .Plain)
        
        //创建一个重用的单元格
        self.tableView!.registerClass(TableViewCell.self, forCellReuseIdentifier: "MsgCell")
        
        let me = "xiaoming.png"
        let you = "xiaohua.png"
        
        let first =  MessageItem(body:"嘿，这张照片咋样，我周末拍的呢！", logo:me, date:NSDate(timeIntervalSinceNow:-600), mtype:ChatType.Mine)
        
        let second =  MessageItem(image:UIImage(named:"luguhu.jpeg")!,logo:me, date:NSDate(timeIntervalSinceNow:-290), mtype:ChatType.Mine)
        
        let third =  MessageItem(body:"太赞了，我也想去那看看呢！",logo:you, date:NSDate(timeIntervalSinceNow:-60), mtype:ChatType.Someone)
        
        let fouth =  MessageItem(body:"嗯，下次我们一起去吧！",logo:me, date:NSDate(timeIntervalSinceNow:-20), mtype:ChatType.Mine)
        
        let fifth =  MessageItem(body:"好的，一定！",logo:you, date:NSDate(timeIntervalSinceNow:0), mtype:ChatType.Someone)
        
        Chats = [first,second, third, fouth, fifth]
        
        self.tableView.chatDataSource = self
        self.tableView.reloadData()
        self.view.addSubview(self.tableView)
    }
    
    /*返回对话记录中的全部行数*/
    func rowsForChatTable(tableView:TableView) -> Int {
        return self.Chats.count
    }
    
    /*返回某一行的内容*/
    func chatTableView(tableView:TableView, dataForRow row:Int) -> MessageItem {
        return Chats[row]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

