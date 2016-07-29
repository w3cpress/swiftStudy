//
//  ChatDataSource.swift
//  swift36
//
//  Created by Alan on 16/7/1.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

import Foundation

/*
 数据提供协议
 */
protocol ChatDataSource {
    /*返回对话记录中的全部行数*/
    func rowsForChatTable( tableView:TableView) -> Int
    /*返回某一行的内容*/
    func chatTableView(tableView:TableView, dataForRow:Int)-> MessageItem
}