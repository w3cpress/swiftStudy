//
//  ViewController.swift
//  swift30
//  Swift30 - 日期选择控件（UIDatePicker）的用法
//  Created by Alan on 16/6/27.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var dpicker:UIDatePicker!
    @IBOutlet var btnShow:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //2.手动创建日期控件
        //datePickerInit();
        
        //3.倒计时用法
        datePickerInit2();
    }
    
    @IBAction func showClicked(sender:UIButton){
        let date = dpicker.date;
        
        //创建一个日期格式器
        let dformatter = NSDateFormatter();
        
        //为日期格式器，设置格式字符串
        dformatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss";
        
        // 使用日期格式器格式化日期、时间
        let datestr = dformatter.stringFromDate(date);
        
        let message = "您选择在日期和时间是：\(datestr)";
        
        let alertController = UIAlertController(title:"当前日期和时间",message: message,preferredStyle: .Alert);
        
        let cancelAction = UIAlertAction(title:"确定",style: .Cancel,handler: nil);
        
        alertController.addAction(cancelAction);
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func datePickerInit(){
        //创建日期选择器
        let datePicker = UIDatePicker(frame:CGRectMake(0,400,320,100));
        //将日期选择器区域设置为中文，则选择器日期显示为中文
        datePicker.locale = NSLocale(localeIdentifier:"zh_CN");
        
        datePicker.addTarget(self, action: #selector(dateChanged), forControlEvents: UIControlEvents.ValueChanged)
        self.view.addSubview(datePicker)
    }
    
    //日期选择器响应方法
    func dateChanged(datePicker : UIDatePicker){
        //更新提醒时间文本框
        let formatter = NSDateFormatter()
        //日期样式
        formatter.dateFormat = "yyyy年MM月dd日 HH:mm:ss"
        print(formatter.stringFromDate(datePicker.date))
    }
    
    var ctimer:UIDatePicker!
    var btnstart:UIButton!
    var leftTime:Int = 180
    var alertController:UIAlertController!
    var timer:NSTimer!
    
    func datePickerInit2(){
        ctimer = UIDatePicker(frame:CGRectMake(0.0, 200.0, 200.0, 200.0))
        self.ctimer.datePickerMode = UIDatePickerMode.CountDownTimer;
        
        //必须为 60 的整数倍，比如设置为100，值自动变为 60
        //下面这里设置有个以一次拨动不打印值的小bug，可以使用下面在另外一种方式替代
        //self.ctimer.countDownDuration = NSTimeInterval(leftTime);
        
        dispatch_async(dispatch_get_main_queue(), {
             self.ctimer.countDownDuration = NSTimeInterval(self.leftTime);
        })
        
        ctimer.addTarget(self, action: #selector(timerChanged), forControlEvents: UIControlEvents.ValueChanged)
        
        self.view.addSubview(ctimer)
        
        btnstart =  UIButton(type: .System)
        btnstart.frame = CGRect(x:100, y:150, width:100, height:100);
        btnstart.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        btnstart.setTitleColor(UIColor.greenColor(), forState:UIControlState.Disabled)
        btnstart.setTitle("开始", forState:UIControlState.Normal)
        btnstart.setTitle("倒计时中", forState:UIControlState.Disabled)
        
        btnstart.clipsToBounds = true;
        btnstart.layer.cornerRadius = 5;
        btnstart.addTarget(self, action:#selector(startClicked), forControlEvents:UIControlEvents.TouchUpInside)
        
        self.view.addSubview(btnstart)
    }
    
    func timerChanged(){
        print("您选择倒计时间为：\(self.ctimer.countDownDuration)")
    }
    /**
     *开始倒计时按钮点击
     */
    func startClicked(sender:UIButton){
        self.btnstart.enabled = false;
        
        // 获取该倒计时器的剩余时间
        leftTime = Int(self.ctimer.countDownDuration);
        // 禁用UIDatePicker控件和按钮
        self.ctimer.enabled = false;
        
        // 创建一个UIAlertView对象（警告框），并确认，倒计时开始
        alertController = UIAlertController(title:"到计时开始",message: "倒计时开始，还有 \(leftTime) 秒...",preferredStyle: .Alert);
        self.presentViewController(alertController, animated: true, completion: nil);
        // 启用计时器，控制每秒执行一次tickDown方法
        timer = NSTimer.scheduledTimerWithTimeInterval(NSTimeInterval(1), target:self,selector:#selector(tickDown),userInfo:nil,repeats:true)
    }
    /**
     *计时器每秒触发事件
     **/
    func tickDown() {
        alertController.message = "倒计时开始，还有 \(leftTime) 秒..."
        // 将剩余时间减少1秒
        leftTime -= 1;
        // 修改UIDatePicker的剩余时间
        self.ctimer.countDownDuration = NSTimeInterval(leftTime);
        
        print(leftTime)
        // 如果剩余时间小于等于0
        if(leftTime <= 0) {
            // 取消定时器
            timer.invalidate();
            // 启用UIDatePicker控件和按钮
            self.ctimer.enabled = true;
            self.btnstart.enabled = true;
            alertController.message = "时间到！"
            let cancelAction = UIAlertAction(title:"确定",style: .Cancel,handler: nil);
            alertController.addAction(cancelAction);
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

