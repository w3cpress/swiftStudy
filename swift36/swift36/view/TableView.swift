//
//  TableView.swift
//  swift36
//
//  Created by Alan on 16/7/1.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

import UIKit

class TableView:UITableView,UITableViewDelegate, UITableViewDataSource {
    //用于保存所有消息
    var bubbleSection:Array<MessageItem>!
    //数据源,用于与 ViewController 交换数据
    var chatDataSource:ChatDataSource!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame:frame,  style:style)
        
        self.bubbleSection = Array<MessageItem>()
        self.backgroundColor = UIColor.clearColor()
        self.separatorStyle = UITableViewCellSeparatorStyle.None
        self.delegate = self
        self.dataSource = self
    }
    
    override func reloadData() {
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        
        var count =  0
        if ((self.chatDataSource != nil)) {
            count = self.chatDataSource.rowsForChatTable(self)
            if(count > 0) {
                for i in 0..<count {
                    let object =  self.chatDataSource.chatTableView(self, dataForRow:i)
                    bubbleSection.append(object)
                }
                
                //按日期排序方法
                bubbleSection.sortInPlace({
                    $0.date.timeIntervalSince1970 < $1.date.timeIntervalSince1970
                })
            }
        }
        super.reloadData()
    }
    
    //第一个方法返回分区数，在本例中，就是1
    func numberOfSectionsInTableView(tableView:UITableView)->Int {
        return 1
    }
    
    //返回指定分区的行数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section >= self.bubbleSection.count) {
            return 0
        }
        
        return self.bubbleSection.count
    }
    
    //用于确定单元格的高度，如果此方法实现得不对，单元格与单元格之间会错位
    func tableView(tableView:UITableView,heightForRowAtIndexPath indexPath:NSIndexPath) -> CGFloat {
            let data =  self.bubbleSection[indexPath.row]
            return max(data.insets.top + data.view.frame.size.height + data.insets.bottom, 52)
    }
    
    //返回自定义的 TableViewCell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
            let cellId = "MsgCell"
            let data =  self.bubbleSection[indexPath.row]
            let cell =  TableViewCell(data:data, reuseIdentifier:cellId)
            return cell
    }
}