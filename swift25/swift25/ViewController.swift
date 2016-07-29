//
//  ViewController.swift
//  swift25
//  Swift25 - 将网页缓存到本地（抓取html页面，并实现离线浏览）
//  参考:http://www.hangge.com/blog/cache/detail_1118.html
//  Created by Alan on 16/6/23.
//  Copyright © 2016年 jollycorp. All rights reserved.
//

/*
 1.实现原理
 整个应用使用的核心技术是：NSURLProtocol 拦截。通过 NSURLProtocol 拦截，我们可以对所有的网络请求进行捕获并处理。
 比如，我们通过 WebView 访问一个网页，首先将捕获到的url地址与本地缓存里的数据匹配。如果有这个url对应得缓存数据，就直接使用缓存数据。
 如果没找到，再进行网络请求，同时将收到的数据缓存起来，供下次使用。
 前面说到，通过 NSURLProtocol 是可以拦截到所有的请求，也就是说不管是html页面，还是里面用到的css、js、图片等文件都是可以拦截并缓存的。
 2.使用Core Data进行数据持久化存储
 本样例使用 Core Data 来缓存网页数据,可以看前面swift24例子
 （1）创建项目的时候，勾选“Use Core Data”
 （2）打开项目中的 xcdatamodeld 文件，添加一个实体“CachedURLResponse”，并在并在 Attribute 栏目中添加如下属性：
 data：内容数据
 encoding：响应编码
 mimeType：响应数据类型
 timestamp：时间戳（记录缓存的时间）
 url：请求地址
 3.创建拦截类
 （1）通过继承 NSURLProtocol，我们创建一个拦截类：MyURLProtocol.swift
 （2）在 AppDelegate.swift 中的 didFinishLaunchingWithOptions 方法里将其注册一下。
 这样当运行程序后，MyURLProtocol 将会处理每一个请求然后交付给 URL Loading System。
 包括代码直接调用 loading system，以及许多系统组件依赖于加载框架的URL,比如 UIWebView。
 4.测试页面
 （1）我们在 textField 中输入 url，点击“确定”后会使用下方的 webView 加载对应的页面。
 （2）页面对应代码如下，这个同以前我们使用 webView 没什么不同。（实际上程序在后台已经默默地进行请求的拦截与缓存等操作了）
 */
import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    //网址输入框
    var textField: UITextField!
    var webView: UIWebView!
    var button: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        textField = UITextField();
        textField.frame = CGRectMake(10, 50, 200, 30);
        textField.delegate = self;
        textField.text = "http://";
        //设置边框样式为圆角矩形
        textField.borderStyle = UITextBorderStyle.RoundedRect;
        
        webView = UIWebView();
        webView.frame = CGRectMake(10, 90, 300, self.view.frame.height - 100);
        webview.scalesPageToFit = true;
        //创建一个ContactAdd类型的按钮
        button = UIButton(type:.System)
        //设置按钮位置和大小
        button.frame = CGRectMake(220, 50, 90, 30)
        button.backgroundColor = UIColor.blueColor();

        //设置按钮文字
        button.setTitle("确定", forState:UIControlState.Normal)
        button.setTitleColor(UIColor.whiteColor(),forState:.Normal);
       
        self.view.addSubview(textField);
        self.view.addSubview(webView);
        self.view.addSubview(button);
        
        button.addTarget(self, action: #selector(buttonGoClicked), forControlEvents:.TouchUpInside)
    }
    
    //确定按钮点击
    func buttonGoClicked(sender: UIButton) {
        if self.textField.isFirstResponder() {
            self.textField.resignFirstResponder()
        }
        self.sendRequest()
    }
    
    //键盘确定按钮点击
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.sendRequest()
        return true
    }
    
    //请求页面
    func sendRequest() {
        if let text = self.textField.text {
            let url = NSURL(string:text)
            let request = NSURLRequest(URL:url!)
            self.webView.loadRequest(request)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//总结：
//这个例子有一些问题，我需要学习后面的知识解决这个问题

