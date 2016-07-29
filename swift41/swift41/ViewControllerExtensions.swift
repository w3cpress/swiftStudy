//
//  ViewControllerExtensions.swift
//  swift41
//
//  Created by Alan on 16/7/28.
//  Copyright © 2016年 jollycorp. All rights reserved.
//
import UIKit

//用类扩展的方式
extension ViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.ctrls.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCellWithIdentifier("SwiftCell", forIndexPath: indexPath) as UITableViewCell;
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator;
        cell.textLabel?.text = self.ctrls[indexPath.row];
        
        return cell;
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // 跳转到detailViewController，取消选中状态
        self.tableView!.deselectRowAtIndexPath(indexPath, animated: true)
        // 创建DetailViewController
        let detailViewController = DetailViewController();
        // 传递控件的title，在detailView里用于判断生成响应的控件
        detailViewController.title = self.ctrls[indexPath.row];
        // navigationController跳转到detailViewController
        self.navigationController!.pushViewController(detailViewController, animated:true)
    }
}
