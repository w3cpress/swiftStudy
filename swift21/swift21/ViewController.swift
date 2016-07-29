//
//  ViewController.swift
//  swift21
//  Swift21 - 图像控件（UIImageView）的用法
//  Created by Alan on 16/6/22.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //1.使用图像控件显示图片
        let img = UIImage(named:"3")    //初始化图片
        let vImg = UIImageView(image: img);   //初始化图片View
        vImg.frame.origin = CGPoint(x:0,y:20);   //指定图片显示的位置
        //vImg.frame = CGRect(x:0,y:20,width:120,height:120);   //指定图片的位置以及显示的大小
        self.view.addSubview(vImg);   //显示在View上
        
        //2.改变图片
        vImg.image = UIImage(named:"2")
        
        
        //3.从文件目录中获取图片
        let path = NSBundle.mainBundle().pathForResource("2", ofType: "png",inDirectory:"images")
        let newImage = UIImage(contentsOfFile: path!)
        
        let path_3 = NSBundle.mainBundle().pathForResource("3", ofType: "png",inDirectory:"images")
        let newImage_3 = UIImage(contentsOfFile: path_3!)
        
        let imageView = UIImageView(image:newImage)
        self.view.addSubview(imageView)
        
        //4.从网络获取图片
        //定义NSURL对象
        let url = NSURL(string: "https://www.baidu.com/img/baidu_jgylogo3.gif")
        
        //从网络获取数据流
        let data = NSData(contentsOfURL: url!)
        //如果这里为nil 
        //需要先设置info.plist 里面的App Transport Security 将那个XXload设置为yes就好了
        
        //通过数据流初始化图片
        let newImage2 = UIImage(data: data!)
        let imageView2 = UIImageView(image:newImage2);
        imageView2.frame.origin = CGPoint(x:0,y:200);
        self.view.addSubview(imageView2)
        
        
        //5.使用图像控件实现动画播放
        //UIImageView中提供了存储多张图片来创建动画的功能，具体做法是，在animationImages属性中设置一个图片数组，然后使用startAnimating方法开始动画，最后用stopAnimating方法停止动画。同时，使用animationDuration属性中可以设置动画每帧切换的速度（秒）
        imageView3 = UIImageView()
        imageView3.frame = CGRectMake(10,10,100,100)
        //设置动画图片
        imageView3.animationImages = [newImage!,newImage_3!]
        //设置每隔0.5秒变化一次
        imageView3.animationDuration = 0.5
        imageView3.frame.origin = CGPoint(x:0,y:400);
        self.view.addSubview(imageView3)
        
        //6.保持图片比例
        //默认UIImageView会拉伸图片使其占满整个UIImageView，如果不想让图片变形，可以将ContentMode设置为Aspect Fit。
        imageView3.contentMode = .ScaleAspectFit
        
    }
    var imageView3:UIImageView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        imageView3.startAnimating()
    }


}

