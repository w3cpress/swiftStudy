//
//  ViewController.swift
//  swift16
//  Swift16 - 文本标签（UILabel）的用法
//  Created by Alan on 16/6/20.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //1.标签的创建
        //设置标签x坐标：5，y坐标：40，宽：300，高：100
        let label = UILabel(frame:CGRectMake(5,30, 310, 100))
        label.text="xiabai8.com";
        self.view.addSubview(label);
        
        //2.设置背景和颜色
        label.textColor = UIColor.whiteColor();
        label.backgroundColor = UIColor.blackColor();
        
        //3.对齐方式
        label.textAlignment = NSTextAlignment.Center;
        
        //4.文字阴影设置
        label.shadowColor = UIColor.grayColor();
        label.shadowOffset = CGSizeMake(-5,5); //阴影偏移值
        
        //5.字体设置
        label.font = UIFont(name:"Zapfino", size:12);
        
        //6.文字过长时的省略方式
        label.lineBreakMode = NSLineBreakMode.ByTruncatingTail;  //隐藏尾部并显示省略号
        label.lineBreakMode = NSLineBreakMode.ByTruncatingMiddle;  //隐藏中间部分并显示省略号
        label.lineBreakMode = NSLineBreakMode.ByTruncatingHead;  //隐藏头部并显示省略号
        label.lineBreakMode = NSLineBreakMode.ByClipping;  //截去多余部分也不显示省略号
        
        //7.文字大小自适应标签宽度
        label.adjustsFontSizeToFitWidth = true; //当文字超出标签宽度时，自动调整文字大小，使其不被截断
        
        //8.使标签可以显示多行文字
        label.numberOfLines = 2  //显示两行文字（默认只显示一行，设为0表示没有行数限制）
        
        //9.设置文本高亮
        //设置文本高亮
        label.highlighted = true
        //设置文本高亮颜色
        label.highlightedTextColor = UIColor.greenColor()
        
        //10.富文本设置
        //富文本设置
        let attributeString = NSMutableAttributedString(string:"welcome to xiaobai8.com");
        //从文本0开始6个字符字体HelveticaNeue-Bold,16号
        attributeString.addAttribute(NSFontAttributeName, value: UIFont(name: "HelveticaNeue-Bold", size: 16)!,range: NSMakeRange(0,6));
        //设置字体颜色
        attributeString.addAttribute(NSForegroundColorAttributeName, value: UIColor.blueColor(),range: NSMakeRange(0, 3))
        //设置文字背景颜色
        attributeString.addAttribute(NSBackgroundColorAttributeName, value: UIColor.greenColor(),range: NSMakeRange(3,3))
        label.attributedText = attributeString;
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

