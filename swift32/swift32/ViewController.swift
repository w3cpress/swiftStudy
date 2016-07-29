//
//  ViewController.swift
//  swift32
//  Swift32 - 工具条（UIToolbar）的用法
//  Created by Alan on 16/6/28.
//  Copyright © 2016年 jollycorp. All rights reserved.
//  原文:http://www.hangge.com/blog/cache/detail_551.html
//1.UIBarButtonItem是工具条按钮，有如下5种init初始化方法：

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //1.
        //barButtonInit1();
        
        //2.
        barButtonInit2();
    }
    //(1).初始化为普通的图片按钮
    func barButtonInit1(){
        //创建一个浏览器工具条，并设置它的大小和位置
        let browserToolbar = UIToolbar(frame:CGRectMake(0,20,320,44));
        self.view.addSubview(browserToolbar);
        
        //创建后退
        let btnback = UIBarButtonItem(image:UIImage(named:"back"),style:UIBarButtonItemStyle.Plain, target:self, action:#selector(backClicked));
        
        //第一个分隔按钮
        let btngap1 = UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.FlexibleSpace, target:nil, action:nil);
        
        
        //(2）普通图片按钮，但提供另一个备选图像供横屏使用
//        let btnback2 = UIBarButtonItem(image:UIImage(named:"back1.png"),landscapeImagePhone:UIImage(named:"back2.png"), style:UIBarButtonItemStyle.Plain, target:self,action:#selector(backClicked));
        //(3)普通文本按钮
//        let btnback3 =  UIBarButtonItem(title:"确定", style:UIBarButtonItemStyle.Plain, target:self,action:#selector(confrim));
        
        // 创建前进按钮 UIBarButtonItem
        let btnforward = UIBarButtonItem(image:UIImage(named:"forward"), style:UIBarButtonItemStyle.Plain, target:self, action:#selector(forwardClicked));
        
        // 第二个分隔按钮，创建一个可伸缩的UIBarButtonItem
        let btngap2 =  UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.FlexibleSpace, target:nil, action:nil);
        
        //固定间隔
        let btngap3 =  UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.FixedSpace, target:nil, action:nil);
        btngap3.width = 50;//还可以自定义宽度
        
        browserToolbar.setItems([btnback,btngap1,btnforward,btngap2], animated: false)
    }
    
    /*
     (4)使用预置按钮：如撤销，重做，编辑等（总共有25个样式）
     Custom：默认样式
     Flexible Space：自动伸缩的空白占位符
     Fixed Space：固定宽度的占位元素
     Add：“+”加号样式
     Edit：Edit文字样式
     Done：Done文字样式
     Cancel：Cancel文字样式
     Save：Save文字样式
     Undo：Undo文字样式
     Redo：Redo文字样式
     Compose：背景矩形插支笔的图标样式
     Reply：返回箭头的图标样式
     Action：背景矩形加上一个向上箭头的图标样式
     Organize：文件夹的图标样式
     Trash：垃圾桶的图标样式
     Bookmarks：书的图标样式
     Search：放大镜的图标样式
     Refresh：顺时针圆形箭头的图标样式
     Stop：一个×的图标样式
     Camera：一个照相机的图标样式
     Play：向右三角形代表播放的图标样式
     Pause：两条竖线代表播放的图标样式
     Rewind：向左两个三角代表回退的图标样式
     Fast Forward：向右两个三角代表快进的图标样式
     Page Curl：页面旋转的图标样式。在Xcode 6中似乎不显示
     */
    
    func barButtonInit2(){
        // 创建一个浏览器工具条，并设置它的大小和位置
        let browserToolbar =  UIToolbar(frame:CGRectMake(0, 20, 320, 44))
        // 将工具条添加到当前应用的界面中
        self.view.addSubview(browserToolbar)
        
        let btn1 =  UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.Compose, target:nil, action:nil);
        let btn2 =  UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.Add, target:nil, action:nil);
        let btn3 =  UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.FlexibleSpace, target:nil, action:nil);
        let btn4 =  UIBarButtonItem(barButtonSystemItem:UIBarButtonSystemItem.Reply, target:nil, action:nil);
        
        browserToolbar.setItems([btn1,btn2,btn3,btn4], animated: false)
    }
    func backClicked(sender:UIBarButtonItem) {
        print("后退");
    }
    
    func forwardClicked(sender:UIBarButtonItem) {
        print("前进");
    }
    
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

