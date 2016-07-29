
//
//  ViewController.swift
//  swift20
//  Swift20 - 分段选择控件（UISegmentedControl）的用法
//  Created by Alan on 16/6/22.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //1.选择控件的创建，并监控控件选择值
        //选项除了文字还可以是图片)
        
        let _xiaobai = UIImage.init(named:"3");
        let items2 = ["选项一","选项二",_xiaobai!] as [AnyObject];
        
        let segmented = UISegmentedControl(items:items2);
        segmented.center = self.view.center;
        segmented.selectedSegmentIndex = 1; //默认选中第二项
        segmented.addTarget(self, action: #selector(segmentDidchange), forControlEvents: UIControlEvents.ValueChanged);
        self.view.addSubview(segmented);
        
        //2.选择控件中选项的添加和删除
        //添加文字选项
        segmented.insertSegmentWithTitle("新增选项",atIndex:1,animated:true);
        //添加图片选项
        //segmented.insertSegmentWithImage(UIImage(named:"3")!,atIndex:1,animated: true)
        //移除选项
        segmented.removeSegmentAtIndex(1,animated:true);
        
        //修改颜色
        segmented.tintColor = UIColor.redColor();
        
        //修改选项文字
        segmented.setTitle("swift", forSegmentAtIndex: 1);
        
        //修改选项图片
        //segmented.setImage(UIImage(named:"3"), forSegmentAtIndex: 2);
        
        //修改选项内容偏移位置
        segmented.setContentOffset(CGSizeMake(0,-5),forSegmentAtIndex:0)
        
    }
    
    func segmentDidchange(segmented:UISegmentedControl){
        //获得选项的索引
        print(segmented.selectedSegmentIndex)
        //获得选择的文字
        print(segmented.titleForSegmentAtIndex(segmented.selectedSegmentIndex))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

