//
//  ViewController.swift
//  swift22
//  Swift22 - 进度条（UIProgressView）,滑块（UISlider）,警告框（UIAlertView）,告警提示框（UIAlertController）的用法
//  http://www.hangge.com/blog/cache/detail_537.html
//  http://www.hangge.com/blog/cache/detail_538.html
//  http://www.hangge.com/blog/cache/detail_651.html
//  自iOS8起，苹果就建议告警框使用UIAlertController来代替UIAlertView和UIActionSheel。
//  Created by Alan on 16/6/23.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //进度条
        progerss();
        //滑块
        slider();
        //警告框
        //alert();
        
        //创建一个System类型的按钮
        let button:UIButton = UIButton(type:.System)
        //设置按钮位置和大小
        button.frame = CGRectMake(0, 50, 100, 30)
        //设置按钮文字
        button.setTitle("删除", forState:UIControlState.Normal)
        self.view.addSubview(button);
        
        button.addTarget(self, action: #selector(alertCtr), forControlEvents: .TouchUpInside)
        
        //创建一个ContactAdd类型的按钮
        let button2:UIButton = UIButton(type:.System)
        //设置按钮位置和大小
        button2.frame = CGRectMake(120, 50, 100, 30)
        //设置按钮文字
        button2.setTitle("login", forState:UIControlState.Normal)
        self.view.addSubview(button2);
        
        button2.addTarget(self, action: #selector(loginAlertCtr), forControlEvents: .TouchUpInside)
        
    }
    
    func progerss(){
        //1.创建进度条
        let progressView = UIProgressView(progressViewStyle:.Default);
        progressView.center = self.view.center;
        progressView.progress = 0.8;
        self.view.addSubview(progressView);
        
        //2.设置进度条
        progressView.setProgress(0.8,animated:true)
        
        //3.改变进度条颜色
        progressView.progressTintColor = UIColor.greenColor(); //已有进度条颜色
        
        progressView.trackTintColor = UIColor.blueColor(); //剩余进度条颜色
    }
    
    func slider() {
        //1.创建滑块
        let sliderView = UISlider(frame:CGRectMake(0,100,300,50));
        //silderView.center = self.view.center;
        sliderView.minimumValue = 0;
        sliderView.maximumValue = 1;
        sliderView.value = 0.2;
        self.view.addSubview(sliderView);
        
        //2.设置滑块的值，同时有动画
        sliderView.setValue(0.8, animated: true);
        
        //3.滑块的值改变响应
        sliderView.continuous = true;
        sliderView.addTarget(self, action: #selector(sliderDidchange), forControlEvents: UIControlEvents.ValueChanged);
        
        //4.滑块左右两边槽的颜色
        sliderView.minimumTrackTintColor = UIColor.redColor()  //左边槽的颜色
        sliderView.maximumTrackTintColor = UIColor.greenColor() //右边槽的颜色
        
        //5.滑块后面槽线两侧添加图标
        sliderView.minimumValueImage = UIImage(named: "voice1"); //左边图标
        sliderView.maximumValueImage = UIImage(named: "voice2"); //右边图标
        
        //6.自定义滑块组件图片
        //设置滑块右边部分的图片
        sliderView.setMaximumTrackImage(UIImage(named:"slider_max"),forState:UIControlState.Normal)
        //设置滑块左边部分的图片
        sliderView.setMinimumTrackImage(UIImage(named:"slider_min"),forState:UIControlState.Normal)
        //设置滑块的图片
        sliderView.setThumbImage(UIImage(named:"slider_thumb"),forState:UIControlState.Normal)
        
        //设置滑块右边部分的图片-使用三宫格缩放（左右14像素不变，中间缩放）
        let imgTrackRight = UIImage(named:"slider_max")
        let imgRight = imgTrackRight!.stretchableImageWithLeftCapWidth(14, topCapHeight:0)
        sliderView.setMaximumTrackImage(imgRight, forState:UIControlState.Normal)
        
        
    }
    func sliderDidchange(slider:UISlider){
        print(slider.value)
    }
    
//    func alert(){
//        //1.下面代码创建并弹出一个告警框，并带有“取消”“确定”两个按钮
//        let alertView = UIAlertView();
//        alertView.title = "系统提示"
//        alertView.message = "您确定要离开xiaobai8.com吗？"
//        alertView.addButtonWithTitle("取消")
//        alertView.addButtonWithTitle("确定")
//        alertView.cancelButtonIndex = 0
//        alertView.delegate = self;
//        alertView.show();
//        
//    }
    
//    func alertView(alertView:UIAlertView, clickedButtonAtIndex buttonIndex: Int){
//        if(buttonIndex == alertView.cancelButtonIndex){
//            print("点击了取消")
//        } else {
//            print("点击了确认")
//        }
//    }
    
//    func alert(){
//        //2.警告框有下面4种样式
//        //Default：默认样式
//        //PlainTextInput：带输入框的告警框
//        //SecureTextInput：带密码框的告警框
//        //LoginAndPasswordInput：带输入框和密码框的告警框
//        let alertView = UIAlertView()
//        alertView.title = "系统登录"
//        alertView.message = "请输入用户名和密码！"
//        alertView.addButtonWithTitle("取消")
//        alertView.addButtonWithTitle("确定")
//        alertView.cancelButtonIndex = 0
//        alertView.delegate = self;
//        alertView.alertViewStyle = UIAlertViewStyle.LoginAndPasswordInput
//        alertView.show()
//    
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//    func alertView(alertView:UIAlertView, clickedButtonAtIndex buttonIndex: Int){
//        if(buttonIndex == alertView.cancelButtonIndex){
//            print("点击了取消")
//        } else {
//            let name = alertView.textFieldAtIndex(0)
//            let password = alertView.textFieldAtIndex(1)
//            print("用户名是：\(name!.text) 密码是：\(password!.text)")
//        }
//    }
    
   
    func alertCtr (){
        //2.除了弹出，还可以使用从底部向上滑出的样式
        //（注意：如果上拉菜单中有“取消”按钮的话，那么它永远都会出现在菜单的底部，不管添加的次序是如何）
        
        let alertController = UIAlertController(title:"保存或者删除数据",message: "删除数据将不可恢复",preferredStyle: .ActionSheet);
        
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        let deleteAction = UIAlertAction(title: "删除", style: .Destructive, handler: nil)
        let archiveAction = UIAlertAction(title: "保存", style: .Default, handler: nil)
        
        alertController.addAction(cancelAction)
        alertController.addAction(deleteAction)
        alertController.addAction(archiveAction)
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    //1.简单的应用（同时按钮响应Handler使用闭包函数）
    override func viewDidAppear(animated: Bool){
        super.viewDidAppear(animated)
        
        let alertController = UIAlertController(title: "系统提示", message: "您确定要离开xiaobai8.com吗？", preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        //按钮使用“告警”样式（文字颜色变红，用来来警示用户）
        let okAction = UIAlertAction(title: "好的", style: UIAlertActionStyle.Destructive, handler: { action in print("点击了确定")});
        
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        
        self.presentViewController(alertController, animated: true, completion: nil)
        
    }
    
    func loginAlertCtr (){
        let alertController = UIAlertController(title: "系统登录", message: "请输入用户名和密码", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
            textField.placeholder = "用户名"
        }
        alertController.addTextFieldWithConfigurationHandler {
            (textField: UITextField!) -> Void in
            textField.placeholder = "密码"
            textField.secureTextEntry = true
        }
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        let okAction = UIAlertAction(title: "好的", style: .Default,
                                     handler: {
                                        action in
                                        //也可以用下标的形式获取textField let login = alertController.textFields![0]
                                        let login = alertController.textFields!.first! as UITextField
                                        let password = alertController.textFields!.last! as UITextField
                                        print("用户名：\(login.text) 密码：\(password.text)")
        })
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
}

