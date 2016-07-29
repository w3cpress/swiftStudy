//
//  ViewController.swift
//  swift18
//  Swift18 - 文本输入框（UITextField）的用法
//  Created by Alan on 16/6/20.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //1.文本框的创建，有如下几个样式：
        //UITextBorderStyle.None: 无边框
        //UITextBorderStyle.Line: 直线边框
        //UITextBorderStyle.RoundedRect: 圆角矩形边框
        //UITextBorderStyle.Bezel: 边线+阴影
        
        let textField = UITextField(frame: CGRectMake(10,160,200,30))
        //设置边框样式为圆角矩形
        textField.borderStyle = UITextBorderStyle.RoundedRect;
        self.view.addSubview(textField);
        
        //2.文本框占位符提示文字
        textField.placeholder = "请输入用户名.";
        
        //3.文字大小超过文本框长度时自动缩小字号，而不是隐藏显示省略号
        textField.adjustsFontSizeToFitWidth = true;
        textField.minimumFontSize = 14; //最小可缩放
        
        //4.水平对齐方式
        /** 水平对齐 **/
        textField.textAlignment = .Right //水平右对齐
        textField.textAlignment = .Center //水平居中对齐
        textField.textAlignment = .Left //水平左对齐
        
        /** 垂直对齐 **/
        textField.contentVerticalAlignment = .Top  //垂直向上对齐
        textField.contentVerticalAlignment = .Center  //垂直居中对齐
        textField.contentVerticalAlignment = .Bottom  //垂直向下对齐
        //5. 背景图片设置
        textField.borderStyle = .None //先要去除边框样式
        textField.background = UIImage(named:"background1");
        
        //6.清除按钮（输入框内右侧小叉）
        textField.clearButtonMode = UITextFieldViewMode.WhileEditing  //编辑时出现清除按钮
        textField.clearButtonMode = UITextFieldViewMode.UnlessEditing  //编辑时不出现，编辑后才出现清除按钮
        textField.clearButtonMode = UITextFieldViewMode.Always  //一直显示清除按钮
        
        //7.设置文本框关联的键盘类型
        //Default: 系统默认的虚拟键盘
        //ASCII Capable: 显示英文字母的虚拟键盘
        //Numbers and Punctuation: 显示数字和标点的虚拟键盘
        //URL: 显示便于输入数字的虚拟键盘
        //Number Pad: 显示便于输入数字的虚拟键盘
        //Phone Pad: 显示便于拨号呼叫的虚拟键盘
        //Name Phone Pad: 显示便于聊天拨号的虚拟键盘
        //Email Address: 显示便于输入Email的虚拟键盘
        //Decimal Pad: 显示用于输入数字和小数点的虚拟键盘
        //Twitter: 显示方便那些Twitter的虚拟键盘
        //Web Search: 显示便于在网页上书写的虚拟键盘
        textField.keyboardType = UIKeyboardType.NumberPad

        //8.使文本框在界面打开时就获取焦点，并弹出输入键盘
        textField.becomeFirstResponder();
        //9.使文本框失去焦点，并收回键盘
        textField.resignFirstResponder();
        
        //10.设置键盘return键的样式
        textField.returnKeyType = UIReturnKeyType.Done //表示完成输入
        textField.returnKeyType = UIReturnKeyType.Go //表示完成输入，同时会跳到另一页
        textField.returnKeyType = UIReturnKeyType.Search //表示搜索
        textField.returnKeyType = UIReturnKeyType.Join //表示注册用户或添加数据
        textField.returnKeyType = UIReturnKeyType.Next //表示继续下一步
        textField.returnKeyType = UIReturnKeyType.Send //表示发送
        
        //11.键盘return键的响应
        let textField2 = UITextField(frame: CGRectMake(10,260,200,30))
        //设置边框样式为圆角矩形
        textField2.borderStyle = UITextBorderStyle.RoundedRect
        textField2.returnKeyType = UIReturnKeyType.Done
        textField2.delegate = self
        self.view.addSubview(textField2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(textField:UITextField) -> Bool {
        //收起键盘
        textField.resignFirstResponder()
        //打印出文本框中的值
        print(textField.text)
        return true;
    }
    
    

}