//
//  ViewController.swift
//  swift19
//  Swift19 - 多行文本输入框（UITextView）和开关按钮（UISwitch）的用法
//  Created by Alan on 16/6/22.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var uiswitch:UISwitch!;
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //1.多行文本的创建
        let textview = UITextView(frame: CGRectMake(10,100,200,100));
        textview.layer.borderWidth = 1; //边框粗细
        textview.layer.borderColor = UIColor.blueColor().CGColor; //边框颜色
        self.view.addSubview(textview);
        
        //2.是否可编辑
        textview.editable = true;
        
        //3.内容是否可选
        textview.selectable = true;
        
        //4.属性font设置字体，textColor设置字体颜色，textAlignment设置对齐方式 
        textview.font = UIFont(name:"Zapfino", size:12);
        textview.textColor = UIColor.redColor();
        textview.textAlignment = NSTextAlignment.Left;
        
        //5.给文字中的电话号码和网址自动加链接
        textview.dataDetectorTypes = UIDataDetectorTypes.None //都不加链接
        textview.dataDetectorTypes = UIDataDetectorTypes.PhoneNumber //只有电话加链接
        textview.dataDetectorTypes = UIDataDetectorTypes.Link //只有网址加链接
        textview.dataDetectorTypes = UIDataDetectorTypes.All //电话和网址都加
        
        //6.自定义选择内容后的菜单
        let mail = UIMenuItem(title:"邮件",action: #selector(ViewController.onMail));
        let weixin = UIMenuItem(title:"微信",action:#selector(ViewController.onWeiXin));
        let menu = UIMenuController();
        menu.menuItems = [mail,weixin];
        
        //7.开关按钮（UISwitch）的用法
        uiswitch = UISwitch();
        //设置位置（开关大小无法设置）
        uiswitch.center = CGPointMake(100,50);
        //设置默认值
        uiswitch.on = true;
        uiswitch.addTarget(self, action: #selector(switchDidChange),
                           forControlEvents:UIControlEvents.ValueChanged)
        self.view.addSubview(uiswitch);
        
    }
    
    func onMail(){
        print("mail");
    }
    
    func onWeiXin(){
        print("weixin");
    }
    
    func switchDidChange(){
        //打印当前值
        print(uiswitch.on)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

